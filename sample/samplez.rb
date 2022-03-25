require 'num4diff'
def eulerMethodTest
    y0 = 1.0
    h = 0.001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::eulerMethod(yi, x, h) do
            a = 1.0
            next y0 + a * x
        end
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.5015
    puts
end
def heunMethodTest
    y0 = 1.0
    h = 0.001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::heunMethod(yi, x, h) do
            a = 1.0
            next y0 + a * x
        end
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.594909275334592
    puts
end
def rungeKuttaMethodTest
    y0 = 1.0
    h = 0.001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, x, h) do
            a = 1.0
            next y0 + a * x
        end
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.6760202602624927
    puts
end
eulerMethodTest()
heunMethodTest()
rungeKuttaMethodTest()
