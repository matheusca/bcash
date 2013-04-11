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
			@email = @options[:email_loja]
		end
		
		def html
			form_content = File.open(File.join(File.dirname(__FILE__), 'form_bcash.html.haml')).read

			if block_given?
				button_html = yield
			else
				button_html = content_tag('button', 'Pagar com Bcash!', type: "submit")
			end

			Haml::Engine.new(form_content).render(nil, package: self.package, options: self.options, button_html: button_html)			
		end
	end
end
