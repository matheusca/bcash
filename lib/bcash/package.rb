module Bcash
	
	class Package

		attr_accessor :integration, :shipping_cost, :items

		def initialize(items)
			@items = items
		end

		def seal(shipping_cost = 0, integration = Bcash::PAD)
			@shipping_cost = shipping_cost
			@integration = integration
		end

		class << self

			def create(items)
				items_humanize_bcash = {}	

				items.each_with_index do |item, index|
					amount_to_post = index + 1

					items_humanize_bcash[:"produto_codigo_#{amount_to_post}"] = item.id
					items_humanize_bcash[:"produto_descricao_#{amount_to_post}"] = item.description
					items_humanize_bcash[:"produto_qtde_#{amount_to_post}"] = item.amount
					items_humanize_bcash[:"produto_valor_#{amount_to_post}"] = item.price
				end

				Package.new(items_humanize_bcash)
			end

		end
	end
end
