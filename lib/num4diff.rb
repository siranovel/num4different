require 'ffi'

module Num4DiffLib
    extend FFI::Library
    ffi_lib ['libnum4diff.so', 'c']
    attach_function :puts, [:string], :int
    attach_function :eulerMethod, :CNum4Diff_eulerMethod, [:double, :double], :double
end
