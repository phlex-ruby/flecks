# frozen_string_literal: true

class Flecks::Queue
	def initialize
		@queue = ::Queue.new
		@count = 0
	end

	def push(id, task, content)
		@count += 1

		Async do
			@queue.push([id, task.call, content])
		end
	end

	def drain
		while @count > 0
			yield(*@queue.pop)
			@count -= 1
		end
	end
end
