# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'bf_multi_rss'
  spec.version = '0.3.7'
  spec.authors = ['Sebastian Schürmann']
  spec.email = ['sebs@2xs.org']

  spec.summary = 'Parallel rss fetching'
  spec.homepage = 'https://github.com/bundesfeeds'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'http', '~> 2.2'
  spec.add_runtime_dependency 'parallel', '~> 1.10'
end
