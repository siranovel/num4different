#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "CNum4Diff.h"

static double CNum4Diff_doEulerMethod(double yi, double x, double h, Func func);
static double CNum4Diff_doHeunMethod(double yi, double x, double h, Func func);
static double CNum4Diff_doRungeKuttaMethod(double yi, double x, double h, Func func);
static CNum4Diff _cNum4Diff = {
	.FP_eulerMethod = CNum4Diff_doEulerMethod,
	.FP_heunMethod = CNum4Diff_doHeunMethod,
	.FP_rungeKuttaMethod = CNum4Diff_doRungeKuttaMethod,
};
/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Diff_eulerMethod(double yi, double x, double h, Func func)
{
	return _cNum4Diff.FP_eulerMethod(yi, x, h, func);
}
double CNum4Diff_heunMethod(double yi, double x, double h, Func func)
{
	return _cNum4Diff.FP_heunMethod(yi, x, h, func);
}
double CNum4Diff_rungeKuttaMethod(double yi, double x, double h, Func func)
{
	return _cNum4Diff.FP_rungeKuttaMethod(yi, x, h, func);
}
/**************************************/
/* 処理実行部                         */
/**************************************/
/* 
 * オイラー法
 */
static double CNum4Diff_doEulerMethod(double yi, double x, double h, Func func)
{
    double y = func(x);

    return yi + y * h;
}
/*
 * ホイン法
 */
static double CNum4Diff_doHeunMethod(double yi, double x, double h, Func func)
{
    double k1 = 0.0;
    double k2 = 0.0;
    double y = 0.0;
    double Y1 = 0.0;

    y = func(x);
    Y1 = yi + h * y;
    k1 = y * h;
    k2 = Y1 * h;
    return yi + (k1 + k2) / 2.0;
}
/*
 * ルンゲクッタ法
 */
static double CNum4Diff_doRungeKuttaMethod(double yi, double x, double h, Func func)
{
    double k1 = 0.0;
    double k2 = 0.0;
    double k3 = 0.0;
    double k4 = 0.0;
    double y = 0.0;

    y = func(x);
    k1 = h * y;
    k2 = h * (yi + k1 / 2.0);
    k3 = h * (yi + k2 / 2.0);
    k4 = h * (yi + k3);
    return yi + (k1 + 2 * k2 + 2 * k3 + k4) / 6.0; 
}

