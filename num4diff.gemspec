Gem::Specification.new do |s|
  s.name        = 'num4diff'
  s.version     = '0.0.20'
  s.date        = '2022-03-24'
  s.summary     = "num for diffrent!"
  s.description = "numerical solution for ordinaray differential equations"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4different"
  s.license     = "MIT"
  s.files       = ["lib/num4diff.rb", "LICENSE"]
  s.files       += Dir["ext/num4diff/*.so"]
  s.extensions  = %w[ext/num4diff]
  s.add_runtime_dependency 'ffi', '~> 1.15', '>= 1.15.0'
end
