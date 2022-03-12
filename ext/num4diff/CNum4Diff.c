#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "CNum4Diff.h"


static double CNum4Diff_doEulerMethod(double x, double dt);
static CNum4Diff _cNum4Diff = {
	.FP_eulerMethod = CNum4Diff_doEulerMethod,
};
/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Diff_eulerMethod(double x, double dt)
{
	return _cNum4Diff.FP_eulerMethod(x, dt);
}
/**************************************/
/* 処理実行部                         */
/**************************************/
static double CNum4Diff_doEulerMethod(double x, double dt)
{
	return 0;
}
