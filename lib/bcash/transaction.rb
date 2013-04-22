require 'base64'

module Bcash
  class Transaction
    attr_accessor :email, :token, :id_transaction, :id_order
    attr_reader :items
    
    def initialize(email = nil, token = nil, id_transaction = nil, id_order = nil)
      @email = email
      @token = token
      @id_transaction = id_transaction
      @id_order = id_order
    end


    def get
      transaction = Nokogiri::XML(get_transaction_url)
      self.instance_variables.each{|variable| raise Bcash::Errors::EmptyAttributes.new if self.instance_variable_get(variable).nil?}

      create_transaction_attrs(transaction) 
    end

    private

    def get_transaction_url
      url = 'https://www.pagamentodigital.com.br/transacao/consulta'

      RestClient.post(url, params, headers).to_str
    end

    def create_transaction_attrs(transaction)
      transaction.xpath("//transacao/*").each do |node|
        next if node.name == "pedidos"
        self.instance_variable_set "@#{node.name}", node.text

        self.class.class_eval do
           attr_reader node.name
        end
      end        

      @items = transaction.xpath("//pedidos/item").map do |item|
        Item.new({
          :id => item.css("codigo_produto").text,
          :description => item.css("nome_produto").text,
          :amount => item.css("qtde").text,
          :price => item.css("valor_total").text
        })
      end

      nil
    end

    def base64_bcash
      Base64.strict_encode64("#{self.email}:#{self.token}")
    end

    def params
      {
       :id_transacao => @id_transaction, 
       :id_pedido => @id_pedido, 
      }
    end

    def headers
      {
        'Authorization' => "Basic #{base64_bcash}"
      }
    end

  end
end
