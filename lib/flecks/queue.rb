# frozen_string_literal: true

class Flecks::Queue
	def initialize
		@queue = ::Queue.new
		@count = 0
	end

	def push(id, task, content)
		@count += 1

		Async do
			case task
			when Thread
				@queue.push([id, task.value, content])
			when Async::Task
				@queue.push([id, task.wait, content])
			else
				raise "Unknown task type: #{task.inspect}"
			end
		end
	end

	def drain
		while @count > 0
			yield @queue.pop
			@count -= 1
		end
	end
end
