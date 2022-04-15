require 'num4diff'
class Num4DiffTest
    def initialize
        @y0 = 1.0
        @h = 0.001
        @a = 1
        @e = Math.exp(@a)
    end
    #
    # オイラー法のテスト
    def eulerMethodTest
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::eulerMethod(yi, x, @h) do
                next 1.0 + @a * x
            end
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
            yi_1 =  Num4DiffLib::heunMethod(yi, x, @h) do
                next 1.0 + @a * x
            end
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
            yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, x, @h) do
                next 1.0 + @a * x
            end
            yi = yi_1
        }
        print "exp(", @a, "):", @e
        print " "
        print "1.0:", yi_1             # yi_1 = 2.6760202602624927 
        puts
    end
end
tst = Num4DiffTest.new
tst.eulerMethodTest()
tst.heunMethodTest()
tst.rungeKuttaMethodTest()

