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

    # オイラー法による数値計算
    #
    # @overload eulerMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    # @example
    #    yi = 1.0
    #    h = v
    #    func = Proc.new{|x|
    #        1.0 + @a * x 
    #    }
    #    yi_1 =  Num4DiffLib::eulerMethod(yi, 0.0, h, func)  
    #
    attach_function :eulerMethod,
        :CNum4Diff_Tier_eulerMethod, [:double, :double, :double, :f], :double
    # ホイン法による数値計算
    #
    # @overload heunMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    # @example
    #    yi = 1.0
    #    h = v
    #    func = Proc.new{|x|
    #        1.0 + @a * x 
    #    }
    #    yi_1 =  Num4DiffLib::heunMethod(yi, 0.0, h, func)  
    #
    attach_function :heunMethod,
        :CNum4Diff_Tier_heunMethod, [:double, :double, :double, :f], :double
    # 4次のルンゲ＝クッタ法による数値計算
    #
    # @overload  rungeKuttaMethod(yi, xi, h, func)
    #   @param [double] yi xiに対するyiの値
    #   @param [double] xi xiの値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] xi+hに対するyi_1の値
    # @example
    #    yi = 1.0
    #    h = v
    #    func = Proc.new{|x|
    #        1.0 + @a * x 
    #    }
    #    yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, 0.0, h, func)  
    #
    attach_function :rungeKuttaMethod,
        :CNum4Diff_Tier_rungeKuttaMethod, [:double, :double, :double, :f], :double
    #
    # アダムス・バッシュフォース法(k段)による数値計算
    # @overload adamsBashforthMethod(k, a, b, y0, h, func)
    #   @param [int]    k k段アダムス法
    #   @param [double] a 下限値
    #   @param [double] b 上限値
    #   @param [double] y0 y(x0=a)の値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] [a,b]の積分値
    # @example
    #    yi = 1.0
    #    h = v
    #    func = Proc.new{|x|
    #        1.0 + @a * x 
    #    }
    #    yi_1 =  Num4DiffLib::adamsBashforthMethod(2, 0, 1, yi, h, func)  
    #
    attach_function :adamsBashforthMethod,
        :CNum4Diff_Multistage_adamsBashforthMethod, [:int, :double, :double, :double, :double, :f], :double
    # アダムス・ムルトン法(k段)による数値計算
    #
    # @overload adamsMoultonMethod(k, a, b, y0, h, func)
    #   @param [int]    k k段アダムス法
    #   @param [double] a 下限値
    #   @param [double] b 上限値
    #   @param [double] y0 y0 y(x0=a)の値
    #   @param [double] h  刻み幅
    #   @param [callback] func xiに対する傾きを計算する関数
    #   @return [double] [a,b]の積分値
    # @example
    #    yi = 1.0
    #    h = v
    #    func = Proc.new{|x|
    #        1.0 + @a * x 
    #    }
    #    yi_1 =  Num4DiffLib::adamsMoultonMethod(2, 0, 1, yi, h, func)  
    #
    attach_function :adamsMoultonMethod,
        :CNum4Diff_Multistage_adamsMoultonMethod, [:int, :double, :double, :double, :double, :f], :double
end
