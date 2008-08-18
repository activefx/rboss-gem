module Boss

  class Config < OpenStruct

    def initialize(hash={})
      #Setup defaults      
      super({:count => 10, :lang => "en", :format => "object"}.merge(hash))
    end
   
    def to_url
      self.marshal_dump.inject("") {|accum, key| accum+="&#{key[0]}=#{key[1]}"  }
    end

  end

end
