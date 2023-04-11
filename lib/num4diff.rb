require 'ffi'
require 'ffi-compiler/loader'

#
# 数値計算による常微分方程式の解法するライブラリ
#
module Num4DiffLib
    extend FFI::Library

    ffi_lib FFI::Compiler::Loader.find('num4diff') 
    # @overload f(xi)
    #   dy = f(xi)
    #   @yield [x] dy = f(x)
    #   @yieldparam [double] xi xiの値
    #   @return [double] xiに対するyの値
    callback   :f, [:double], :double

    #
    # オイラー法による数値計算
    # @overload eulerMethod(yi, xi, h, func)
    #   yi_1 = eulerMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    #
    attach_function :eulerMethod,
        :CNum4Diff_eulerMethod, [:double, :double, :double, :f], :double
    #
    # ホイン法による数値計算
    # @overload heunMethod(yi, xi, h, func)
    #   yi_1 = heunMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    #
    attach_function :heunMethod,
        :CNum4Diff_heunMethod, [:double, :double, :double, :f], :double
    #
    # 4次のルンゲ＝クッタ法による数値計算
    # @overload  rungeKuttaMethod(yi, xi, h, func)
    #   yi_1 = rungeKuttaMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    #
    attach_function :rungeKuttaMethod,
        :CNum4Diff_rungeKuttaMethod, [:double, :double, :double, :f], :double
    #
    # アダムス・バッシュフォース法(3段)による数値計算
    # @overload adamsBashforthMethod(a, b, yi, h, func)
    #   @param [double] a 下限値
    #   @param [double] b 上限値
    #   @param [double] yi xiに対するyiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    #
    attach_function :adamsBashforthMethod,
        :CNum4Diff_adamsBashforthMethod, [:double, :double, :double, :double, :f], :double
    #
    # アダムス・ムルトン法(3段)による数値計算
    # @overload adamsMoultonMethod(a, b, yi, xi, h, func)
    #   @param [double] a 下限値
    #   @param [double] b 上限値
    #   @param [double] yi xiに対するyiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    #
    attach_function :adamsMoultonMethod,
        :CNum4Diff_adamsMoultonMethod, [:double, :double, :double, :double, :f], :double
end
