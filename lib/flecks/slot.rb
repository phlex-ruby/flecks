# frozen_string_literal: true

class Flecks::Slot < Phlex::HTML
	include Phlex::DeferredRender

	def initialize(task)
		task => Proc
		@id = SecureRandom.urlsafe_base64
		@task = task
		@placeholder = nil
		@content = nil
	end

	def view_template
		id = @id

		div(data_phlex_slot: id, &@placeholder)
		queue = context[:flecks_slots] ||= Flecks::Queue.new
		queue.push(id, @task, @content)
	end

	def placeholder(&placeholder)
		@placeholder = placeholder
	end

	def content(&content)
		@content = content
	end
end
