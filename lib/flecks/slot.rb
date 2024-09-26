# frozen_string_literal: true

class Flecks::Slot < Phlex::HTML
	include Phlex::DeferredRender

	def initialize(task)
		@id = SecureRandom.urlsafe_base64
		@task = task
		@placeholder = nil
	end

	def view_template
		slot(name: @id, &@placeholder)
	end

	def placeholder(&content)
		@placeholder = content
	end

	def content(&content)
		queue = context[:slots] ||= Flecks::Queue.new
		queue.push(@id, @task, content)
	end
end
