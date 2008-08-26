module Boss
  class ResultCollection 
    include Enumerable

    attr_reader :results

    def initialize
      @results=[]
    end
    
    def set_instance_variable(name, value)
      instance_variable_set("@#{name}",value)
      instance_eval("def #{name}\n @#{name}\n end")        
    end

    def each
      @results.each { |result| yield result }
    end
    
    def <<(element)
      @results << element
    end
    
    def [](key)
      @results[key]
    end

  end
end
