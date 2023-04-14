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
    # アダムス・バッシュフォース法(3段)のテスト
    def adamsBashforthMethodTest
        yi = @y0

        yi_1 =  Num4DiffLib::adamsBashforthMethod(0, 1, yi, @h, @func)
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             # yi_1 = 2.7072138201422864
        puts
    end
    #
    # アダムス・ムルトン法(3段)のテスト
    def adamsMoultonMethodTest
        yi = @y0
        yi_1 =  Num4DiffLib::adamsMoultonMethod(0, 1, yi, @h, @func)
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             # yi_1 = 2.7104123200664993 
        puts
    end
end
tst = Num4DiffTest.new
tst.eulerMethodTest()
tst.heunMethodTest()
tst.rungeKuttaMethodTest()
tst.adamsBashforthMethodTest()
tst.adamsMoultonMethodTest()
