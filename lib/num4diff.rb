require 'ffi'

module Num4DiffLib
    extend FFI::Library
    spec = Gem.loaded_specs["num4diff"]
    gem_root = spec.gem_dir
    ffi_lib ["#{gem_root}/ext/num4diff/libnum4diff.so"]
    # y = f(xi) 
    callback   :f, [:double], :double
    # yi_1 = eulerMethod(yi, xi, h, func)
    attach_function :eulerMethod,
        :CNum4Diff_eulerMethod, [:double, :double, :double, :f], :double
    # yi_1 = heunMethod(yi, xi, h, func)
    attach_function :heunMethod,
        :CNum4Diff_heunMethod, [:double, :double, :double, :f], :double
    # yi_1 = rungeKuttaMethod(yi, xi, h, func)
    attach_function :rungeKuttaMethod,
        :CNum4Diff_rungeKuttaMethod, [:double, :double, :double, :f], :double
end
