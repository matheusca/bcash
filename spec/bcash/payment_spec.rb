require 'spec_helper'




describe Bcash::Payment do
  let(:items) do 
    [
      Bcash::Item.new(id: 1, description: 'Test', amount: 2, price: 10.00),
      Bcash::Item.new(id: 3, description: 'Another test', amount: 5, price: 40.00),
    ]
  end

  let(:package) do
    Bcash::Package.create(items)
  end

  describe "Invalid package" do
    subject{Bcash::Payment.new(package)}

    it "returns invalid" do
      expect(subject).to_not be_valid
    end
  end

  describe "With valid package" do
    subject {Bcash::Payment.new(package, {email_loja: 'test@test.com', url_retorno: 'http://www.test.com'})}

    it "returns a form" do
      expect(subject.html).to match(/^<form/)
      expect(subject.html).to match(/<button/)
    end

    it "returns html with block button" do
      expect(subject.html{"<input type='submit' />"}).to match(/<input\ type=\'submit\'/)
    end

    it "returns has inputs" do
      form_bcash = Nokogiri::HTML(subject.html)

      expect(form_bcash.at('input[@name="email_loja"]')['value']).to eq('test@test.com')
      expect(form_bcash.at('input[@name="url_retorno"]')['value']).to eq('http://www.test.com')
      expect(form_bcash.at('input[@name="frete"]')['value']).to eq('0')
      expect(form_bcash.at('input[@name="tipo_integracao"]')['value']).to eq('PAD')
      expect(form_bcash.at('input[@name="produto_codigo_1"]')['value']).to eq('1')
      expect(form_bcash.at('input[@name="produto_descricao_1"]')['value']).to eq('Test')
      expect(form_bcash.at('input[@name="produto_qtde_1"]')['value']).to eq('2')
      expect(form_bcash.at('input[@name="produto_valor_1"]')['value']).to eq('10.0')
      expect(form_bcash.at('input[@name="produto_codigo_2"]')['value']).to eq('3')
      expect(form_bcash.at('input[@name="produto_descricao_2"]')['value']).to eq('Another test')
      expect(form_bcash.at('input[@name="produto_qtde_2"]')['value']).to eq('5')
      expect(form_bcash.at('input[@name="produto_valor_2"]')['value']).to eq('40.0')
    end
  end
end
