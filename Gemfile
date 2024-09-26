# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
	gem "quickdraw", github: "joeldrapper/quickdraw"
	gem "simplecov", require: false
end

group :development do
	gem "rubocop"
	gem "solargraph"
	gem "benchmark-ips"
end

gem "concurrent-ruby"
