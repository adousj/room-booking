source 'http://ruby.taobao.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake', '10.1.0'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'sass'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3'

gem 'unicorn', :require => false

# Test requirements
group :test, :development do
  gem 'rspec'
  gem 'capybara'
  gem 'rr', :require => false
  gem 'rspec-padrino'
  gem 'rack-test', :require => 'rack/test'
  gem 'autotest-growl', :require => false
end

# Padrino Stable Gem
gem 'padrino', '0.11.3'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.2'
# end

gem 'coffee-script'

gem 'chronic'
