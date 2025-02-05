require 'spec_helper'
require 'num4diff'

RSpec.describe Num4DiffLib do
    before do
        @y0 = 1.0
        @h = 0.001
        @a = 1
        @func = Proc.new{|x|
            1.0 + @a * x 
        }
    end
    it '#eulerMethod' do
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::eulerMethod(yi, x, @h, @func)
            yi = yi_1
        }
        expect( 
            yi_1 
        ).to my_round(2.5015, 4)
    end
    it '#heunMethod' do
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::heunMethod(yi, x, @h, @func)
            yi = yi_1
        }
        expect( 
            yi_1 
        ).to my_round(2.5973, 4)
    end
    it '#rungeKuttaMethod' do
        yi = @y0
        yi_1 = 0.0
        0.step(1, @h) { |x|
            yi_1 =  Num4DiffLib::rungeKuttaMethod(yi, x, @h, @func)
            yi = yi_1
        }
        expect( 
            yi_1 
        ).to my_round(2.6760, 4)
    end
    describe 'Adams' do
        describe 'adamsBashforth' do
            it '#damsBashforthMethod_2' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsBashforthMethod(2, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#damsBashforthMethod_3' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsBashforthMethod(3, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#damsBashforthMethod_4' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsBashforthMethod(4, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#damsBashforthMethod_5' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsBashforthMethod(5, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
        end
        describe 'adamsMoulton' do
            it '#adamsMoultonMethod_2' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsMoultonMethod(2, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#adamsMoultonMethod_3' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsMoultonMethod(3, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#adamsMoultonMethod_4' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsMoultonMethod(4, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
            it '#adamsMoultonMethod_5' do
                yi = @y0
                expect( 
                    Num4DiffLib::adamsMoultonMethod(5, 0, 1, yi, @h, @func)
                ).to my_round(2.6761, 4)
            end
        end
    end
end

