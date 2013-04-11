require 'spec_helper'

items = [
	Bcash::Item.new(id: 1, description: 'Test', amount: 2, price: 10.00),
	Bcash::Item.new(id: 3, description: 'Another test', amount: 5, price: 40.00),
]

posts = {
	produto_codigo_1: items[0].id, produto_descricao_1: items[0].description, produto_qtde_1: items[0].amount, produto_valor_1: items[0].price, 
	produto_codigo_2: items[1].id, produto_descricao_2: items[1].description, produto_qtde_2: items[1].amount, produto_valor_2: items[1].price, 
} 
describe Bcash::Package do
	subject {Bcash::Package.create(items)}
	
	it "should return 8 items humanize with bcash" do
		subject.items.should include(posts)
	end
end
