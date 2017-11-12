# frozen_string_literal: true

module Tamashii
  # Make class can be configure
  module Configurable
    # :nodoc:
    module ClassMethods
      def config(attr_name, options = {})
        configs[attr_name.to_sym] = Config::Attribute.new(attr_name, options)
        define_method(attr_name) { self[attr_name] }
        define_method("#{attr_name}=") { |value| self[attr_name] = value }
      end

      def configs
        @configs ||= {}
      end

      def config?(name)
        @configs.keys.include?(name.to_sym)
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    def [](attr_name)
      return unless self.class.config?(attr_name)
      attr_name = attr_name.to_sym
      container[attr_name]&.value ||
        self.class.configs[attr_name]&.default
    end

    def []=(attr_name, value)
      return unless self.class.config?(attr_name)
      container[attr_name.to_sym] =
        self.class.configs[attr_name.to_sym].build(value)
    end

    private

    def container
      @container ||= {}
    end
  end
end
