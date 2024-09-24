# frozen_string_literal: true

require_relative "lib/flecks/version"

Gem::Specification.new do |spec|
	spec.name = "flecks"
	spec.version = Flecks::VERSION
	spec.authors = ["Joel Drapper"]
	spec.email = ["joel@drapper.me"]

	spec.summary = "Deferred rendering for Phlex"
	spec.description = "Render IO-bound content asynchronously in Phlex."
	spec.homepage = "https://github.com/phlex-ruby/flecks"
	spec.license = "MIT"
	spec.required_ruby_version = ">= 3.3.1"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/phlex-ruby/flecks"
	spec.metadata["changelog_uri"] = "https://github.com/phlex-ruby/flecks/blob/main/CHANGELOG.md"
	spec.metadata["funding_uri"] = "https://github.com/sponsors/joeldrapper"

	spec.files = Dir[
		"README.md",
		"LICENSE.txt",
		"lib/**/*.rb"
	]

	spec.require_paths = ["lib"]
	spec.add_runtime_dependency "phlex", "2.0.0.beta2"

	spec.metadata["rubygems_mfa_required"] = "true"
end
