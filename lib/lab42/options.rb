require 'ostruct'
require_relative './options/parser'
require_relative './options/forwarder'

module Lab42
  class Options
    def parse *args
      args = args.first if Array === args.first
      @parsed = Lab42::Options::Parser.new.parse( args )
      set_defaults
      check_required
      issue_errors!
      result = OpenStruct.new @parsed
      result.forwarding_to :kwds
    end

    private
    def initialize options={}
      @registered = {}
      @errors = []
      options.each do | k, v |
        register_option k, v
      end
    end

    def check_required
      required_options.each do |ro|
        @errors << "Required option #{ro} was not provided" unless @parsed[:kwds].to_h.has_key? ro
      end
    end

    def defaults
      @__defaults__ =
        @registered.select{|_,v| v != :required}
    end

    def issue_errors!
      return if @errors.empty?
      raise ArgumentError, @errors.join("\n")
    end
    def register_option k, v
      @registered[k] = v
    end

    def required_options
      @__required_options__ ||=
        @registered.select{|_,v| v == :required}.keys
    end

    def set_defaults
      defaults.each do |k, dv|
        @parsed[:kwds][k] = dv unless @parsed[:kwds].to_h.has_key? k
      end
    end
  end
end
