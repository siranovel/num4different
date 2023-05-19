require 'num4diff'
class Num4DiffTest
    def initialize
        @y0 = 1.0
        @h = 0.001
        @a = 1
        @e = Math.exp(@a)
        @func = Proc.new{|x|
            1.0 + @a * x 
        }
    end
    #
    # オイラー法のテスト
    def eulerMethodTest
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::eulerMethod(yi, x, @h, @func)
            yi = yi_1
        }
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             # yi_1 = 2.5015
        puts
    end
    #
    # ホイン法のテスト
    def heunMethodTest
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::heunMethod(yi, x, @h, @func)
            yi = yi_1
        }

        print "exp(", @a, "):", @e
        print " "
	print "1.0:", yi_1             # yi_1 = 2.597305097418414
	puts
    end
    #
    # 4次のルンゲクッタ法のテスト
    def rungeKuttaMethodTest
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, x, @h, @func)
            yi = yi_1
        }
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             # yi_1 = 2.6760202602624927 
        puts
    end
    #
    # アダムス・バッシュフォース法(k段)のテスト
    #   k = 2    yi_1 = 2.6738300800873835
    #   k = 3    yi_1 = 2.6761325593844068
    #   k = 4    yi_1 = 2.6784369572244606
    #   k = 5    yi_1 = 2.680743276163638
    def adamsBashforthMethodTest(k)
        yi = @y0
        yi_1 =  Num4DiffLib::adamsBashforthMethod(k, 0, 1, yi, @h, @func)
        print "k=", k, " "
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             
        puts
    end
    #
    # アダムス・ムルトン法(k段)のテスト
    #   k = 2    yi_1 = 2.6738301371944577
    #   k = 3    yi_1 = 2.6761326061765063
    #   k = 4    yi_1 = 2.678436999480585
    #   k = 5    yi_1 = 2.6807433155801172
    def adamsMoultonMethodTest(k)
        yi = @y0
        yi_1 =  Num4DiffLib::adamsMoultonMethod(k, 0, 1, yi, @h, @func)
        print "k=", k, " "
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1              
        puts
    end
end
tst = Num4DiffTest.new
tst.eulerMethodTest()
tst.heunMethodTest()
tst.rungeKuttaMethodTest()
2.step(5) { |k|
    tst.adamsBashforthMethodTest(k)
    tst.adamsMoultonMethodTest(k)
}
