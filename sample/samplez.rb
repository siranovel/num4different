require 'num4diff'
def eulerMethodTest
    f = Proc.new do |x|
        a = 1.0
        next 1.0 + a * x
    end
    y0 = 1.0
    h = 0.001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::eulerMethod(yi, x, h, f)
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.5015
    puts
end
def heunMethodTest
    f = Proc.new do |x|
        a = 1.0
        next 1.0 + a * x
    end
    y0 =  1.0
    h = 0.00001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::heunMethod(yi, x, h, f)
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.594909275334592
    puts
end
def rungeKuttaMethodTest
    f = Proc.new do |x|
        a = 1.0
        next 1.0 + a * x
    end
    y0 = 1.0
    h = 0.001
    yi = y0
    yi_1 = 0.0
    0.step(1, h) { |x|
        yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, x, h, f)
        yi = yi_1
    }
    print "1.0:"
    print yi_1                         # yi_1 = 2.6760202602624927
    puts
end
eulerMethodTest()
heunMethodTest()
rungeKuttaMethodTest()
