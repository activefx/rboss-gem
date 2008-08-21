require 'ostruct'

module Boss
  module Result
    class Base < OpenStruct

      def initialize(data={})
        super
      end

    end
    
  end
  
end