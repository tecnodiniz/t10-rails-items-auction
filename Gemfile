source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

gem 'cssbundling-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'faraday'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pry'
gem 'puma', '~> 5.0'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end
group :test do
  gem 'capybara'
  gem 'simplecov', require: false
end
group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'cpf_cnpj'
end
