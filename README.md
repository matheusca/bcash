# Bcash

Integração com Bcash(antigo Pagamento Digital)

## Como usar

# Criando um item

	items = [] 
	items << Bcash::Item.new({id: 1, description: 'teste', amount: 2, price: 30.0})

Você pode criar quando itens for necessários para enviar para o Bcash

Você pode validar se o item criado é valido

	item = Bcash::Item.new({id: 1, description: 'teste', amount: 2, price: 30.0})
	item.valid?

Valide o item, igual ao Rails.

# Criando um pacote

Com os itens criados, crie um pacote para o envio

	package = Package.create(items)

No pacote você pode alterar o valor do frete e o tipo de integração do Bcash
	
	Package.create(items, 30.0, BCASH::PAD)

# Gerando pagamento

Crie um pagamento

	payment = Bcash::Payment.new(package, {:email_loja => 'test@test.com'}) 

Podemos colocar nas opções uma url de retorno para o Bcash voltar ao site desejado.

	Bcash::Payment.new(package, {:email_loja => 'test@test.com', :url_retorno => 'http://www.teste.com.br'})

Você pode encontrar todas as opções no [site do bcash](https://www.bcash.com.br/desenvolvedores/integracao-loja-online.html) e procure por campos opcionais

# Gerando formulário

	payment.html

Você terá o formulário pronto para envio, você também pode alterar o input do de envio para a maneira que desejar

	payment.html{tag_content('button', 'Pagar!')}

# Retorno automático

Se você utilizou a opção de url de retorno, você pode capturar o POST enviado pelo Bcash

	notification = Bcash::Notification(params)
	notification.id_transacao

Você pode visualizar todos os parametros na [página de desenvolvimento do bcash](https://www.bcash.com.br/desenvolvedores/integracao-retorno-automatico-loja-online.html)

## Instalação

Adicione ao seu Gemfile:

    gem 'bcash'

E execute:

    $ bundle

## TODO

* Criar classe para retorno automatico
* Verificar status do pedido

## Contributing

1. Fork 
2. Cria seu branch (`git checkout -b my-new-feature`)
3. Commit suas mudanças (`git commit -am 'Add some feature'`)
4. Envie o branch (`git push origin my-new-feature`)
5. Rode os testes
6. Cria um novo Pull Request
