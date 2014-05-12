require 'spec_helper'
require 'fakeweb'

describe Bcash::Transaction do
  describe "#get" do
    it "returns include the order id if specified" do
      expect(RestClient). to receive(:post) do |url, params, headers|
        expect(params[:id_pedido]).to eq("123")
        ""
      end
      Bcash::Transaction.new('teste@test.com', '1234567890', '18621609', "123").get
    end

    it "doesn't returns include the transaction id if not specified" do
      expect(RestClient).to receive(:post) do |url, params, headers|
        expect(params.has_key?(:id_transacao)).to be_falsey
        ""
      end
      Bcash::Transaction.new('teste@test.com', '1234567890', nil, "123").get
    end
  end

  context "its ok" do
    before(:each) do
      body = File.open(File.join(File.dirname(__FILE__), '..', 'response', 'transaction_200.xml')).read
      FakeWeb.register_uri(:post, %r|pagamentodigital\.com\.br|, :body => body, :content_type => 'text/xml')
      FakeWeb.allow_net_connect = false
    end
    subject{ Bcash::Transaction.new('teste@test.com', '1234567890', nil, "123") }

    it "returns self in get" do
      expect(subject.get).to eq(subject)
    end

    it "returns attributes" do
      subject.get

      expect(subject.id_transacao).to eq('18621609')
      expect(subject.id_pedido).to eq('R415728787')
      expect(subject.valor_original).to eq('0.01')
      expect(subject.items[0].id).to eq("1070870205")
      expect(subject.items[0].description).to eq("Ruby on Rails Bag")
      expect(subject.items[0].amount).to eq("1")
      expect(subject.items[0].price).to eq("0.01")
      expect(subject.items[1].id).to eq("1070870206")
      expect(subject.items[1].description).to eq("Ruby on Rails Bag")
      expect(subject.items[1].amount).to eq("3")
      expect(subject.items[1].price).to eq("10.0")
    end
  end

  context "empty attributes" do
    it "should return raise EmptyAttributes" do
      expect{subject.get}.to raise_error(Bcash::Errors::EmptyAttributes)
    end
  end
end
