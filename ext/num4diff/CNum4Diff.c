#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "CNum4Diff.h"

static double CNum4Diff_doEulerMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doHeunMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doRungeKuttaMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doAdamsBashforthMethod(int k, double a, double b, double y0, double h, Func func);
static double CNum4Diff_doAdamsMoultonMethod(int k, double a, double b, double y0, double h, Func func);
static CNum4Diff _cNum4Diff = {
    .tierMethod = {
	.FP_eulerMethod          = CNum4Diff_doEulerMethod,
	.FP_heunMethod           = CNum4Diff_doHeunMethod,
	.FP_rungeKuttaMethod     = CNum4Diff_doRungeKuttaMethod,
    },
    .multistageMethod = {
	.FP_adamsBashforthMethod = CNum4Diff_doAdamsBashforthMethod,
	.FP_adamsMoultonMethod   = CNum4Diff_doAdamsMoultonMethod,
    },
};
/* アダムステーブル */
static AdamsTbl bash[] = {
    [0] = {.s = 2,                     // k = 2
           .bv = {[0] = 3,   [1] = -1}
          },          
    [1] = {.s = 12,                    // k = 3
           .bv = {[0] = 23,  [1] = -16,  [2] = 5}
          },
    [2] = {.s = 24,                    // k = 4
           .bv = {[0] = 55,  [1] = -59,  [2] = 37,  [3] = -9}
          }, 
    [3] = {.s = 720,                   // k = 5
           .bv = {[0] = 1901,[1] = -2774,[2] = 2616,[3] = -1274, [4] = 251}
          }, 
};
static AdamsTbl moulton[] = {
    [0] = {.s = 2,                     // k = 2
           .bv = {[0] = 1,  [1] = 1}
          },           
    [1] = {.s = 12,                    // k = 3
           .bv = {[0] = 5,  [1] = 8,  [2] = -1}
          },
    [2] = {.s = 24,                    // k = 4
           .bv = {[0] = 9,  [1] = 19, [2] = -5,  [3] = 1}
          }, 
    [3] = {.s = 720,                   // k = 5
          .bv = {[0] = 251,[1] = 646,[2] = -264,[3] = 106,[4] = -19}
          }, 
};
/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Diff_Tier_eulerMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.tierMethod.FP_eulerMethod(yi, xi, h, func);
}
double CNum4Diff_Tier_heunMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.tierMethod.FP_heunMethod(yi, xi, h, func);
}
double CNum4Diff_Tier_rungeKuttaMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.tierMethod.FP_rungeKuttaMethod(yi, xi, h, func);
}
double CNum4Diff_Multistage_adamsBashforthMethod(int k, double a, double b, double y0, double h, Func func)
{
    assert(func != 0);
    assert(a < b);
    assert((1 < k) && (k < 6));

    return _cNum4Diff.multistageMethod.FP_adamsBashforthMethod(k, a, b, y0, h, func);
}
double CNum4Diff_Multistage_adamsMoultonMethod(int k, double a, double b, double y0, double h, Func func)
{
    assert(func != 0);
    assert(a < b);
    assert((1 < k) && (k < 6));

    return _cNum4Diff.multistageMethod.FP_adamsMoultonMethod(k, a, b, y0, h, func);
}
/**************************************/
/* 処理実行部                         */
/**************************************/
/* 
 * オイラー法
 */
static double CNum4Diff_doEulerMethod(double yi, double xi, double h, Func func)
{
    double y = func(xi);

    return yi + h * y;
}
/*
 * ホイン法
 */
static double CNum4Diff_doHeunMethod(double yi, double xi, double h, Func func)
{
    double y = func(xi);
    double k1 = 0.0;
    double k2 = 0.0;

    k1 = h * y;                        // k1 = h * f(xi, y)
    k2 = h * (yi + k1);                // k2 = h * f(xi + h, h * f(xi + h, yi + k1)
    return yi + (k1 + k2) / 2.0;
}
/*
 * ルンゲクッタ法
 */
static double CNum4Diff_doRungeKuttaMethod(double yi, double xi, double h, Func func)
{
    double y = 0.0;
    double k1 = 0.0;
    double k2 = 0.0;
    double k3 = 0.0;
    double k4 = 0.0;

    y = func(xi);
    k1 = h * y;                        // k1 = h * f(xi, y)
    k2 = h * (yi + k1 / 2.0);          // k2 = h * f(xi + h / 2, yi + k1 / 2) 
    k3 = h * (yi + k2 / 2.0);          // k3 = h * f(xi + h / 2, y1 + k2 / 2)
    k4 = h * (yi + k3);                // k4 = h * f(xi + h, yi + k3)
    return yi + (k1 + 2 * k2 + 2 * k3 + k4) / 6.0; 
}
/*
 * アダムス・バッシュフォース法(k段)
 */
static double CNum4Diff_doAdamsBashforthMethod(int k, double a, double b, double y0, double h, Func func)
{
    double xi = a;
    double y = 0.0;
    double *f = malloc(sizeof(double) * k);
    int i;
    double bk;

    f[k - 1] = y0;
    for (i = 0; i < k - 2; i++) {
        f[k - (i + 2)] =  CNum4Diff_Tier_rungeKuttaMethod(f[k - (i + 1)], xi, h, func);
    }
    for (xi = xi + h; xi < b; xi += h) {
        f[0]  = CNum4Diff_Tier_rungeKuttaMethod(f[1], xi, h, func);
        // 予測子
        bk = 0.0;
        for (i = 0; i < k; i++) {
            bk += bash[k - 2].bv[i] * f[i];
        }
        y = f[0] + h * bk / bash[k - 2].s;
        // f値をずらす
        for (i = 0; i < k - 1; i++) {
            f[k - (i + 1)] = f[k - (i + 2)];
        }
    }
    return y;
}
/*
 * アダムス・ムルトン法(k段)
 */
static double CNum4Diff_doAdamsMoultonMethod(int k, double a, double b, double y0, double h, Func func)
{
    double xi = a;
    double y_pred = 0.0;
    double y = 0.0;
    double *f = malloc(sizeof(double) * k);
    double *f2 = malloc(sizeof(double) * (k + 1));
    int i;
    double bk;

    f[k - 1] = y0;
    for (i = 0; i < k - 2; i++) {
        f[k - (i + 2)] =  CNum4Diff_Tier_rungeKuttaMethod(f[k - (i + 1)], xi, h, func);
    }
    for (xi = xi + h; xi < b; xi += h) {
        f[0]  = CNum4Diff_Tier_rungeKuttaMethod(f[1], xi, h, func);
        // 予測子
        bk = 0.0;
        for (i = 0; i < k; i++) {
            bk += bash[k - 2].bv[i] * f[i];
            f2[i + 1] = f[i];
        }
        y_pred = f[0] + h * bk / bash[k - 2].s;
        f2[0] = y_pred;
        // 修正子
        bk = 0.0;
        for (i = 0; i < k; i++) {
            bk += moulton[k - 2].bv[i] * f2[i];
        }
        y = f[0] + h * bk / moulton[k - 2].s;
        // f値をずらす
        for (i = 0; i < k - 1; i++) {
            f[k - (i + 1)] = f[k - (i + 2)];
        }
    }
    return y;
}

