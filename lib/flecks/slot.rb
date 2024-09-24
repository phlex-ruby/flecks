# frozen_string_literal: true

class Flecks::Slot < Phlex::HTML
	include Phlex::DeferredRender

	def initialize(promise)
		@id = SecureRandom.urlsafe_base64
		@promise = promise
		@placeholder = nil
	end

	def view_template
		slot(name: @id, &@placeholder)
	end

	def placeholder(&content)
		@placeholder = content
	end

	def content(&content)
		(context[:slots] ||= {})[@id] = [@promise, content]
	end
end
