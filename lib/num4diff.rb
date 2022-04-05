require 'ffi'

#
# 数値計算による常微分方程式の解法するライブラリ
#
module Num4DiffLib
    extend FFI::Library
    spec = Gem.loaded_specs["num4diff"]
    gem_root = spec.gem_dir
    ffi_lib ["#{gem_root}/ext/num4diff/libnum4diff.so"]
    # y = f(xi)
    # @param [double] xi xiの値
    # @return [double] y xiに対するyの値
    callback   :f, [:double], :double

    #
    # オイラー法による数値計算
    #   yi_1 = eulerMethod(yi, xi, h, func)
    # @param [double] yi xiに対するyiの値
    # @param [double] xi xiの値
    # @param [double] h  刻み幅
    # @param [callback] func xiに対する微分を計算する関数
    # @return [double] yi_1 xi+hに対するyiの値
    #
    attach_function :eulerMethod,
        :CNum4Diff_eulerMethod, [:double, :double, :double, :f], :double
    # ホイン法による数値計算
    #   yi_1 = heunMethod(yi, xi, h, func)
    # @param [double] yi xiに対するyiの値
    # @param [double] xi xiの値
    # @param [double] h  刻み幅
    # @param [callback] func xiに対する微分を計算する関数
    # @return [double] yi_1 xi+hに対するyiの値
    #
    attach_function :heunMethod,
        :CNum4Diff_heunMethod, [:double, :double, :double, :f], :double
    #
    # 4次のルンゲ＝クッタ法による数値計算
    #   yi_1 = rungeKuttaMethod(yi, xi, h, func)
    # @param [double] yi xiに対するyiの値
    # @param [double] xi xiの値
    # @param [double] h  刻み幅
    # @param [callback] func xiに対する微分を計算する関数
    # @return [double] yi_1 xi+hに対するyiの値
    attach_function :rungeKuttaMethod,
        :CNum4Diff_rungeKuttaMethod, [:double, :double, :double, :f], :double
end
