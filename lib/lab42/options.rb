require 'ostruct'
require 'lab42/core/fn'
require 'lab42/core/kernel'

require_relative './options/parser'
require_relative './options/forwarder'
require_relative './options/validator'
require_relative './options/error_issuer'

module Lab42
  class Options
    attr_reader :strict_mode, :yaml_file

    def define_help txt
      @defined_help_text = txt
      self
    end

    def define_help_for opt, txt=nil, &blk
      @help_text_for_option[opt] = txt||blk.(defaults.fetch(opt))
      self
    end

    def get_help_text
      (
      [ @defined_help_text ] +
      required_options.map do | ro |
        "#{ro}: #{@help_text_for_option.fetch(ro, :required)}"
      end +
      defaults.map do | d,v | 
        "#{d}: defaults to #{@help_text_for_option.fetch(d,v.inspect)}"
      end
      ).compact.join("\n")
    end

    def parse *args
      args = args.first if Array === args.first
      @parsed = Lab42::Options::Parser.new.parse( self, args )

      return if help_asked?

      validate!
      
      set_defaults
      
      OpenStruct.new( @parsed ).forwarding_to :kwds
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

    def strict(new_mode=:errors)
      @strict_mode = new_mode
      self
    end

    def strict?; !!strict_mode end

    def warning_mode?
      strict? && /warnings\z/ === strict_mode
    end

    def error_mode?
      strict? && !warning_mode?
    end
    private
    def initialize options={}
      @registered = {}
      @help_text_for_option = {}
      @strict_mode = :errors
      options.each do | k, v |
        register_option k, v
      end
    end

    #     @spurious.each do | err |
    #       $stderr.puts "invalid parameter #{err.inspect}"
    #     end
    #   else
    #     raise ArgumentError, "invalid parameters: #{@spurious.map(&sendmsg(:inspect)).join(", ")}"
    #   end


    def defaults
      @__defaults__ =
        @registered.select{|_,v| v != :required}
    end

    def help_asked?
      %w{-h --help :help}.any?( &@parsed[:to_a].fn.include? )
    end

    #     @spurious.each do | err |
    #       $stderr.puts "invalid parameter #{err.inspect}"
    #     end
    #   else
    #     raise ArgumentError, "invalid parameters: #{@spurious.map(&sendmsg(:inspect)).join(", ")}"
    #   end

    def issue_errors validator
      errors = "validator.missing"
      raise ArgumentError, @errors.join("\n")
    end

    #     @spurious.each do | err |
    #       $stderr.puts "invalid parameter #{err.inspect}"
    #     end
    #   else
    #     raise ArgumentError, "invalid parameters: #{@spurious.map(&sendmsg(:inspect)).join(", ")}"
    #   end

    def issue_warnings validator
      get_spurious
      
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
    def validate!
      validator = Validator.new( @registered )
      validator.validate @parsed[:kwds].to_h
      return if validator.valid?
      issuer = ErrorIssuer.new self, validator
      issuer.handle_errors!
    end
  end

  class PermissiveOptions < Options
    def strict
      raise NoMethodError, "strict message not understood in this object #{self}"
    end
    private
    def initialize *args, **kwds
      super(*args, **kwds)
      @strict_mode = false
    end
  end
end
