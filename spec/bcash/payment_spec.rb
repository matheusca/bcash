require 'spec_helper'

items = [
  Bcash::Item.new(id: 1, description: 'Test', amount: 2, price: 10.00),
  Bcash::Item.new(id: 3, description: 'Another test', amount: 5, price: 40.00),
]

package = Bcash::Package.create(items)

describe Bcash::Payment do
  describe "Invalid package" do
    subject{Bcash::Payment.new(package)}

    it "should be invalid" do
      subject.should_not be_valid
    end
  end
  describe "With valid package" do
    subject {Bcash::Payment.new(package, {email_loja: 'test@test.com', url_retorno: 'http://www.test.com'})}

    it "should return a form" do
      subject.html.should match(/^<form/)
      subject.html.should match(/<button/)
    end 

    it "should return html with block button" do
      subject.html{"<input type='submit' />"}.should match(/<input\ type=\'submit\'/)
    end

    it "should has inputs" do
      form_bcash = Nokogiri::HTML(subject.html) 
      form_bcash.at('input[@name="email_loja"]')['value'].should == 'test@test.com'
      form_bcash.at('input[@name="url_retorno"]')['value'].should == 'http://www.test.com'
      form_bcash.at('input[@name="frete"]')['value'].should == '0'
      form_bcash.at('input[@name="tipo_integracao"]')['value'].should == 'PAD'
      form_bcash.at('input[@name="produto_codigo_1"]')['value'].should == '1'
      form_bcash.at('input[@name="produto_descricao_1"]')['value'].should == 'Test'
      form_bcash.at('input[@name="produto_qtde_1"]')['value'].should == '2'
      form_bcash.at('input[@name="produto_valor_1"]')['value'].should == '10.0'
      form_bcash.at('input[@name="produto_codigo_2"]')['value'].should == '3'
      form_bcash.at('input[@name="produto_descricao_2"]')['value'].should == 'Another test'
      form_bcash.at('input[@name="produto_qtde_2"]')['value'].should == '5'
      form_bcash.at('input[@name="produto_valor_2"]')['value'].should == '40.0'
    end
  end
end
