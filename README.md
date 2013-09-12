# Bcash

Integração com Bcash (antigo Pagamento Digital)

## Como usar

### Criando e validando um item

Você pode criar um item e, como no Rails, verificar se ele é válido:

``` ruby
item = Bcash::Item.new(id: 1, description: 'teste', amount: 2, price: 30.0)
item.valid?
```

Você pode criar quantos itens forem necessários para enviar ao Bcash:

``` ruby
items = []
items << Bcash::Item.new(id: 1, description: 'teste', amount: 2, price: 30.0)
```

### Criando um pacote

Com os itens criados, crie um pacote para o envio:

``` ruby
package = Bcash::Package.create(items)
```

No pacote você pode alterar o valor do frete e o tipo de integração com o Bcash:

``` ruby
Bcash::Package.create(items, 30.0, Bcash::PAD)
```

### Gerando pagamento

Crie um pagamento:

``` ruby
payment = Bcash::Payment.new(package, email_loja: 'test@test.com')
```

Podemos colocar nas opções uma _url de retorno_ para a qual o Bcash irá
redirecionar o usuário após finalizar o pagamento:

``` ruby
Bcash::Payment.new(package, email_loja: 'test@test.com', url_retorno: 'http://meu-site.com.br')
```

Você pode encontrar todas as opções na
[página do Bcash para desenvolvedores](https://www.bcash.com.br/desenvolvedores/integracao-loja-online.html), buscando por "campos opcionais".

### Gerando formulário

Tendo o objeto do pagamento, você pode gerar o formulário pronto para envio:

``` ruby
payment.html
```

Você também pode alterar o input de envio para a maneira que desejar:

``` ruby
payment.html { submit_tag('button', 'Pagar!') }
```

### Retorno automático

Se você utilizou a opção de _url de retorno_, você pode capturar o POST enviado
pelo Bcash:

``` ruby
notification = Bcash::Notification(params)
notification.id_transacao
```

Você pode visualizar todos os parâmetros na
[página do Bcash para desenvolvedores](https://www.bcash.com.br/desenvolvedores/integracao-retorno-automatico-loja-online.html).

### Verificar transação

Você pode visualizar as transações e consultar o status do seu pedido. Para isso
obtenha a chave de acesso da seguinte maneira:

```
Logue em sua conta no site do Bcash -> Ferramentas -> Sua chave acesso
```

Com a chave de acesso, podemos utilizar a classe transação de duas maneiras:

``` ruby
transaction = Bcash::Transaction.new(email, token, id_transacao, id_pedido)
transaction.get
```

Ou

``` ruby
transaction = Bcash::Transaction.new
transaction.email = 'teste@teste.com.br'
transaction.token = '1234567890'
transaction.id_transaction = '123'
transaction.id_order = '1234'
transaction.get
```

Agora você tem todos os parâmetros para consulta:

``` ruby
transaction.id_transacao
transaction.status
```

Você pode ver todos HTTP code e parâmetros de retorno no [manual de transação](https://www.bcash.com.br/site/manual/Bcash_Manual_Integracao_Consultar_Dados_Transacao.pdf).

## Instalação

Adicione ao seu Gemfile:

``` ruby
gem 'bcash'
```

E execute:

``` shell
$ bundle
```

## Contribuindo

1. Fork
2. Crie seu branch (`git checkout -b my-new-feature`)
3. Commit suas mudanças (`git commit -am 'Add some feature'`)
4. Envie o branch (`git push origin my-new-feature`)
5. Rode os testes
6. Crie um novo Pull Request
