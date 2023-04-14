#ifndef _CNum4Diff_H_
#define _CNum4Diff_H_

/**************************************/
/* 構造体宣言                         */
/**************************************/
typedef struct _CNum4Diff CNum4Diff;
typedef double (*Func)(double x);

struct _CNum4Diff
{
	double (*FP_eulerMethod)(double yi, double xi, double h, Func func);
	double (*FP_heunMethod)(double yi, double xi, double h, Func func);
	double (*FP_rungeKuttaMethod)(double yi, double xi, double h, Func func);
	double (*FP_adamsBashforthMethod)(double a, double b, double y0, double h, Func func);
	double (*FP_adamsMoultonMethod)(double a, double b, double y0, double h, Func func);
;
};
/**************************************/
/* define宣言                         */
/**************************************/
/**************************************/
/* プロトタイプ宣言                   */
/**************************************/
double CNum4Diff_eulerMethod(double yi, double xi, double h, Func func);
double CNum4Diff_heunMethod(double yi, double xi, double h, Func func);
double CNum4Diff_rungeKuttaMethod(double yi, double xi, double h, Func func);
double CNum4Diff_adamsBashforthMethod(double a, double b, double y0, double h, Func func);
double CNum4Diff_adamsMoultonMethod(double a, double b, double y0, double h, Func func);
#endif
