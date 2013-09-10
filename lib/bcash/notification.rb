module Bcash
  class Notification
    attr_accessor :params

    def initialize(params)
      @params = params

      create_bcash_attrs
    end

    def create_bcash_attrs
      @params.each do |key, value|
        self.instance_variable_set "@#{key}", value

        self.class.class_eval do
          attr_reader key
        end
      end
    end

  end
end
