# frozen_string_literal: true

module Tamashii
  module Config
    # Config::Attribute
    class Attribute
      class TypeMismatchError < StandardError; end

      # :nodoc:
      class Value
        attr_reader :value

        def initialize(attribute, value)
          @attribute = attribute
          @value = value
        end
      end

      # :nodoc:
      class Reference
        def initialize(target, attribute)
          @target = target
          @attribute = attribute
        end

        def value
          @target[@attribute]
        end

        def sync(value)
          @target[@attribute] = value
        end
      end

      attr_reader :name

      def initialize(name, options = {})
        @name = name.to_sym
        @type = options[:as] if options[:as].is_a?(Class)
        @default = options[:default]
        @to = options[:to]
        @ref = Reference.new(@to, @name) unless @to.nil?
      end

      def build(value = nil)
        return @ref unless @to.nil?
        validate_type_of(value)
        Value.new(self, value)
      end

      def default
        return @default if @to.nil?
        @ref.value
      end

      protected

      def validate_type_of(value)
        raise TypeMismatchError unless value.is_a?(@type)
      end
    end
  end
end
