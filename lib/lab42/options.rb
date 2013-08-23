require 'ostruct'
require_relative './options/parser'
require_relative './options/forwarder'

module Lab42
  class Options
    attr_reader :yaml_file

    def parse *args
      args = args.first if Array === args.first
      @parsed = Lab42::Options::Parser.new.parse( self, args )
      set_defaults
      check_required
      issue_errors!
      result = OpenStruct.new @parsed
      result.forwarding_to :kwds
    end

    def read_from file_sym_or_hash
      case file_sym_or_hash
      when String
        read_from_file file_sym_or_hash
      when Symbol
        read_from_parameterized_file file_sym_or_hash => nil
      else
        read_from_parameterized_file file_sym_or_hash
      end
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

    def read_from_file file
      @yaml_file = file
    end

    def read_from_parameterized_file params
      raise ArgumentError, "#{params} is not a Hash" unless Hash === params
      @yaml_file = params
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
