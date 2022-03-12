#ifndef _CNum4Diff_H_
#define _CNum4Diff_H_

/**************************************/
/* 構造体宣言                         */
/**************************************/
typedef struct _CNum4Diff CNum4Diff;

struct _CNum4Diff
{
	double (*FP_eulerMethod)(double x, double dt);
};
/**************************************/
/* define宣言                         */
/**************************************/
/**************************************/
/* プロトタイプ宣言                   */
/**************************************/
double CNum4Diff_eulerMethod(double x, double dt);
#endif
