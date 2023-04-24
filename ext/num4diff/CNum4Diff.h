#ifndef _CNum4Diff_H_
#define _CNum4Diff_H_

/**************************************/
/* 構造体宣言                         */
/**************************************/
typedef struct _CNum4Diff           CNum4Diff;
typedef struct _CNum4DiffTier       CNum4DiffTier;
typedef struct _CNum4DiffMultistage CNum4DiffMultistage;
typedef double (*Func)(double x);

struct _CNum4DiffTier
{
    double (*FP_eulerMethod)(double yi, double xi, double h, Func func);
    double (*FP_heunMethod)(double yi, double xi, double h, Func func);
    double (*FP_rungeKuttaMethod)(double yi, double xi, double h, Func func);
};
struct _CNum4DiffMultistage
{
	double (*FP_adamsBashforthMethod)(double a, double b, double y0, double h, Func func);
	double (*FP_adamsMoultonMethod)(double a, double b, double y0, double h, Func func);
;
};
struct _CNum4Diff
{
    CNum4DiffTier tierMethod;
    CNum4DiffMultistage multistageMethod;
};
/**************************************/
/* define宣言                         */
/**************************************/
/**************************************/
/* プロトタイプ宣言                   */
/**************************************/
double CNum4Diff_Tier_eulerMethod(double yi, double xi, double h, Func func);
double CNum4Diff_Tier_heunMethod(double yi, double xi, double h, Func func);
double CNum4Diff_Tier_rungeKuttaMethod(double yi, double xi, double h, Func func);
double CNum4Diff_Multistage_adamsBashforthMethod(double a, double b, double y0, double h, Func func);
double CNum4Diff_Multistage_adamsMoultonMethod(double a, double b, double y0, double h, Func func);
#endif
