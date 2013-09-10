require 'spec_helper'

describe Bcash::Notification do

  # Don't have all params. If you see all, visit: https://www.bcash.com.br/desenvolvedores/integracao-retorno-automatico-loja-online.html
  def params
    {
      id_transacao: '123',
      data_transacao: '20/04/2013',
      data_credito: '22/04/2013',
      valor_original: '12.00',
    }
  end

  it "should return instance" do
    notification = Bcash::Notification.new(params)
    notification.id_transacao.should == '123'
    notification.data_transacao.should == '20/04/2013'
    notification.data_credito.should == '22/04/2013'
    notification.valor_original.should == '12.00'
  end

end
