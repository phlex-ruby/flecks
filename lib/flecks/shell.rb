# frozen_string_literal: true

class Flecks::Shell < Phlex::HTML
	ZERO_WIDTH_SPACE = "&#8203"
	SAFE_BYTES_FOR_SAFARI = Phlex::SGML::SafeValue.new(ZERO_WIDTH_SPACE * 512)

	def before_template
		if context[:rendered_shell]
			raise "You shouldn’t render more than one shell."
		end

		context[:rendered_shell] = true
	end

	def view_template
		Sync do
			template(shadowrootmode: "open") do
				# Hack to encourage Safari to stream the content 😞
				span(aria_hidden: "true", style: "-webkit-user-select: none; user-select: none; pointer-events: none;") { raw SAFE_BYTES_FOR_SAFARI }
				yield
			end

			flush

			if (slots = context[:slots])
				slots.drain do |id, result, content|
					div(slot: id) { content.call(result) }
					flush
				end
			end
		end
	end
end
