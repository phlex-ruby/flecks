# frozen_string_literal: true

class Flecks::Shell < Phlex::HTML
	ZERO_WIDTH_SPACE = "​" # trust me, it’s there! 😅
	SAFE_BYTES_FOR_SAFARI = Phlex::SGML::SafeValue.new(ZERO_WIDTH_SPACE * 512)

	def initialize(nonce: nil)
		@nonce = nonce
	end

	def before_template
		if context[:rendered_shell]
			raise "You shouldn’t render more than one shell."
		end

		context[:rendered_shell] = true
	end

	def view_template
		Sync do
			span(aria_hidden: "true", style: "-webkit-user-select: none; user-select: none;") { raw SAFE_BYTES_FOR_SAFARI }
			yield

			flush

			if (slots = context[:flecks_slots])
				slots.drain do |id, result, content|
					script(type: "text/javascript", nonce: @nonce) do
						raw(
							safe <<~JS
								(function() {
									setTimeout(function() {
										document
											.querySelectorAll('[data-phlex-slot="#{id}"]').forEach(function(element) {
												element.outerHTML = `#{capture { content.call(result) } }`;
											});
									}, 0);
								})();
							JS
						)
					end

					flush
				end
			end
		end
	end
end
