require 'set'
require 'forwarder'
require_relative './core_extension'

module Lab42
  class Options
    class Validator
      attr_reader :missing, :spurious
      extend Forwarder

      forward :missing?, to: :missing, as: :empty?, after: Lab42::Negate
      forward :spurious?, to: :spurious, as: :empty?, after: Lab42::Negate

      def valid?
        missing.empty? && spurious.empty?
      end

      def validate parsed
        parsed.each do | key, value |
          @spurious.update key => value unless @allowed.include? key
          @missing.delete key if @missing.include? key
        end
      end

      private
      def initialize registered
        @spurious = {}
        @missing   = Hash[
          *registered.select{ |_,v| v == :required }.map{ |k,| [k => true] }.flatten
        ]
        @allowed  = Set.new registered.keys
      end 
    end # class Validator
  end # class Options
end # module Lab42
