source "https://rubygems.org"

gemspec

group :development do
  gem "rake"
  gem "test-unit"
  gem "test-unit-ruby-core"

  # RBS requires Ruby >= 3.0
  if RUBY_VERSION >= "3.0.0"
    gem "rbs", "~> 3.4.0"
  end
end
