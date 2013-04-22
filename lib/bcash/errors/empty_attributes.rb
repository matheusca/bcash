module Bcash
  module Errors
    class EmptyAttributes < Exception

      def initialize
        super("All attributes are required.")
      end

    end
  end
end
