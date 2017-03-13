lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'bf_multi_rss'
  s.version     = '0.3.3'
  s.licenses    = ['MIT']
  s.summary     = 'Parallel rss fetching'
  s.authors     = ['Sebastian Schürmann']
  s.email       = 'rubycoder@example.com'
  s.files       = ['lib/bf_multi_rss/fetcher.rb', 'lib/bf_multi_rss/rss_error.rb', 'lib/bf_multi_rss/rss_result.rb']
  s.homepage    = 'https://github.com/bundesfeeds'
  s.add_development_dependency 'bundler', '~> 1.14'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_runtime_dependency 'http', '~> 2.2'
  s.add_runtime_dependency 'parallel', '~> 1.10'
end
