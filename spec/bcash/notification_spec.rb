require 'spec_helper'

describe Bcash::Notification do

  # Don't have all params. If you see all, visit: https://www.bcash.com.br/desenvolvedores/integracao-retorno-automatico-loja-online.html
  let(:params) do
    {
      id_transacao: '123',
      data_transacao: '20/04/2013',
      data_credito: '22/04/2013',
      valor_original: '12.00',
    }
  end
  subject{ Bcash::Notification.new(params) }

  it "returns instance" do
    expect(subject.id_transacao).to eq('123')
    expect(subject.data_transacao).to eq('20/04/2013')
    expect(subject.data_credito).to eq('22/04/2013')
    expect(subject.valor_original).to eq('12.00')
  end

end
