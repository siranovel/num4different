#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "CNum4Diff.h"

static double CNum4Diff_doEulerMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doHeunMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doRungeKuttaMethod(double yi, double xi, double h, Func func);
static double CNum4Diff_doAdamsBashforthMethod(double a, double b, double y0, double h, Func func);
static double CNum4Diff_doAdamsMoultonMethod(double a, double b, double y0, double h, Func func);
static CNum4Diff _cNum4Diff = {
	.FP_eulerMethod          = CNum4Diff_doEulerMethod,
	.FP_heunMethod           = CNum4Diff_doHeunMethod,
	.FP_rungeKuttaMethod     = CNum4Diff_doRungeKuttaMethod,
	.FP_adamsBashforthMethod = CNum4Diff_doAdamsBashforthMethod,
	.FP_adamsMoultonMethod   = CNum4Diff_doAdamsMoultonMethod,
};
/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Diff_eulerMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.FP_eulerMethod(yi, xi, h, func);
}
double CNum4Diff_heunMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.FP_heunMethod(yi, xi, h, func);
}
double CNum4Diff_rungeKuttaMethod(double yi, double xi, double h, Func func)
{
    assert(func != 0);

    return _cNum4Diff.FP_rungeKuttaMethod(yi, xi, h, func);
}
double CNum4Diff_adamsBashforthMethod(double a, double b, double y0, double h, Func func)
{
    assert(func != 0);
    assert(a < b);

    return _cNum4Diff.FP_adamsBashforthMethod(a, b, y0, h, func);
}
double CNum4Diff_adamsMoultonMethod(double a, double b, double y0, double h, Func func)
{
    assert(func != 0);
    assert(a < b);

    return _cNum4Diff.FP_adamsMoultonMethod(a, b, y0, h, func);
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
 * アダムス・バッシュフォース法(3段)
 */
static double CNum4Diff_doAdamsBashforthMethod(double a, double b, double y0, double h, Func func)
{
    double xi = a;
    double fi;
    double fi1 = 0;
    double fi2 = 0;
    double y = 0.0;

    fi2  = y0;
    xi = xi + h;
    fi1  = CNum4Diff_rungeKuttaMethod(fi2, xi, h, func);
    y = fi1;
    for (xi = xi + h; xi < b; xi += h) {
        fi  = CNum4Diff_rungeKuttaMethod(fi1, xi, h, func);
        y = y + h * (23 * fi - 16 * fi1 + 5 * fi2) / 12.0;
        fi2 = fi1;
        fi1 = fi;
    }
    return y;
}
/*
 * アダムス・ムルトン法(3段)
 */
static double CNum4Diff_doAdamsMoultonMethod(double a, double b, double y0, double h, Func func)
{
    double xi = a;
    double fi;
    double fi1 = 0;
    double fi2 = 0;
    double y_pred = 0.0;
    double y = 0.0;

    fi2  = y0;
    xi = xi + h;
    fi1  = CNum4Diff_rungeKuttaMethod(fi2, xi, h, func);
    y = fi1;
    for (xi = xi + h; xi < b; xi += h) {
        fi  = CNum4Diff_rungeKuttaMethod(fi1, xi, h, func);
        y_pred = y + h * (23 * fi - 16 * fi1 + 5 * fi2) / 12.0;
        y = y + h * (5 * y_pred  + 8 * fi -1 * fi1) / 12.0;
        fi2 = fi1;
        fi1 = fi;
    }
    return y;
}

