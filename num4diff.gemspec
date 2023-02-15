Gem::Specification.new do |s|
  s.name        = 'num4diff'
  s.version     = '0.2.6'
  s.date        = '2023-02-15'
  s.summary     = "num for different!"
  s.description = "numerical solution for ordinaray differential equations"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4different"
  s.license     = "MIT"
  s.files       = ["LICENSE"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[ext/num4diff/Rakefile]
  s.add_dependency 'ffi-compiler', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'rake', '~> 12.3', '>= 12.3.3'
end

