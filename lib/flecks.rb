# frozen_string_literal: true

require "phlex"

module Flecks
	autoload :Shell, "flecks/shell"
	autoload :Slot, "flecks/slot"

	def Shell(...)
		render Shell.new(...)
	end

	def Slot(...)
		render Slot.new(...)
	end
end
