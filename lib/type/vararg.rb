require_relative './type'

module RDL::Type
  class VarargType < Type
    attr_accessor :type

    @@cache = {}

    class << self
      alias :__new__ :new
    end

    def self.new(type)
      t = @@cache[type]
      if not t
        t = OptionalType.__new__ type
        @@cache[type] = t
      end
      return t
    end

    def initialize(type)
      @type = type
      super
    end
        
    def to_s
      "*(#{@type})"
    end

    def ==(other) # :nodoc:
      return other.instance_of? VarargType && other.type == @type
    end

    def hash # :nodoc:
      return 59 + @type.hash
    end
  end
end
