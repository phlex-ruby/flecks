# frozen_string_literal: true

class Flecks::Shell < Phlex::HTML
	def before_template
		if context[:rendered_shell]
			raise "You shouldn’t render more than one shell."
		end

		context[:rendered_shell] = true
	end

	def view_template(&)
		template(shadowrootmode: "open", &)

		flush

		slots = context[:slots] ||= {}

		while slots.length > 0
			slots.each do |id, (task, content)|
				case task
				when Thread
					next if task.alive?
					div(slot: id) { content.call(task.value) }
				when Ractor
					next if task.alive?
					div(slot: id) { content.call(task.value) }
				when defined?(Async) && Async::Task
					next if task.running?
					div(slot: id) { content.call(task.result) }
				when defined?(Concurrent::IVar) && Concurrent::IVar
					next if task.pending?
					div(slot: id) { content.call(task.value) }
				when defined?(ActiveRecord::Relation) && ActiveRecord::Relation
					next if !!task.instance_variable_get(:@future_result)&.pending?
					div(slot: id) { content.call(task) }
				else
					raise "Unknown task type: #{task.inspect}"
				end

				flush
				slots.delete(id)
			end

			sleep 0.01
		end
	end
end