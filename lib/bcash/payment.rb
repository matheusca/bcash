module Bcash
  class Payment
    include ActionView::Helpers::TagHelper
    include ActiveModel::Validations

    attr_accessor :package, :options
    attr_reader :email

    validates_presence_of :email

    def initialize(package, options = {})
      @package = package
      @options = options
      @email   = @options[:email_loja]
    end

    def html
      form_content = File.open(File.join(File.dirname(__FILE__), 'form_bcash.html.erb')).read

      button_html = if block_given?
        yield
      else
        content_tag('button', 'Pagar com Bcash!', type: 'submit')
      end

      ERB.new(form_content).result(binding)
    end
  end
end
