# frozen_string_literal: true

require "phlex"
require "async"

module Flecks
	autoload :Shell, "flecks/shell"
	autoload :Slot, "flecks/slot"
	autoload :Queue, "flecks/queue"

	def Shell(...)
		render Shell.new(...)
	end

	def Slot(...)
		render Slot.new(...)
	end
end
