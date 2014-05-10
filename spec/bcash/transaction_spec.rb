require 'spec_helper'
require 'fakeweb'

describe Bcash::Transaction do
  it "should include the order id if specified" do
    RestClient.should_receive(:post) do |url, params, headers|
      params[:id_pedido].should == "123"
      ""
    end
    Bcash::Transaction.new('teste@test.com', '1234567890', '18621609', "123").get
  end

  context "its ok" do
    before(:each) do
      body = File.open(File.join(File.dirname(__FILE__), '..', 'response', 'transaction_200.xml')).read
      FakeWeb.register_uri(:post, %r|pagamentodigital\.com\.br|, :body => body, :content_type => 'text/xml')
      FakeWeb.allow_net_connect = false

      subject.email = 'teste@test.com'
      subject.token = '1234567890'
      subject.id_transaction = '18621609'
      subject.id_order = 'R415728787'
    end

    it "should nil in get" do
      subject.get.should be_nil
    end

    it "should return attributes" do
      subject.get

      subject.id_transacao.should == '18621609'
      subject.id_pedido.should == 'R415728787'
      subject.valor_original.should == '0.01'
      subject.items[0].id.should == "1070870205"
      subject.items[0].description.should == "Ruby on Rails Bag"
      subject.items[0].amount.should == "1"
      subject.items[0].price.should == "0.01"
      subject.items[1].id.should == "1070870206"
      subject.items[1].description.should == "Ruby on Rails Bag"
      subject.items[1].amount.should == "3"
      subject.items[1].price.should == "10.0"
    end
  end

  context "empty attributes" do
    it "should return raise EmptyAttributes" do
      expect {subject.get}.to raise_error(Bcash::Errors::EmptyAttributes)
    end
  end
end
