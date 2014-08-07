Gem::Specification.new do |s|
  s.name = "atos"
  s.version = "0.9.0"
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage = "http://github.com/gbarillot/#{s.name}"
  s.authors = ["Guillaume Barillot"]
  s.email = "gbarillot@gmail.com"
  s.description = "Ruby on Rails gateway for SIPS/ATOS french online payments API"
  s.summary = "Ruby on Rails gateway for SIPS/ATOS"
  s.extra_rdoc_files = %w(README.md)
  s.license = 'MIT'
  s.files = Dir["MIT-LICENSE", "README.md", "Gemfile", "lib/**/*.rb", 'test/**/*.rb']
  s.test_files = Dir.glob("test/*_test.rb")
  s.require_paths = ["lib"]

  s.add_dependency 'rails'
end
