require 'ostruct'
require_relative './options/parser'
require_relative './options/forwarder'

module Lab42
  class Options
    def parse *args
      args = args.first if Array === args.first
      @parsed = Lab42::Options::Parser.new.parse( args )
      check_result
      issue_errors!
      result = OpenStruct.new @parsed
      result.forwarding_to :kwds
    end

    private
    def initialize options={}
      @registered = {}
      options.each do | k, v |
        register_option k, v
      end
    end

    def check_result
      @errors = []
      check_requirements
      # set_defaults
    end

    def check_requirements
      required_options.each do |ro|
        @errors << "Required option #{ro} was not provided" unless @parsed[:kwds].to_h.has_key? ro
      end
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
        @parsed.merge! k, dv do |key, oldv, newv|
          oldv || newv
        end
      end
    end
  end
end
