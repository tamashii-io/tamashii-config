# frozen_string_literal: true

require 'tamashii/config/version'
require 'tamashii/config/attribute'
require 'tamashii/configurable'

module Tamashii
  # Tamashii Config module
  module Config
    # :nodoc:
    class Shared
      include Configurable
    end

    class << self
      def respond_to_missing?(name, _include_private = false)
        shared.respond_to?(name)
      end

      def method_missing(name, *args, &block)
        return super unless shared.respond_to?(name)
        shared.send(name, *args, &block)
      end

      def add(name, options = {})
        Shared.config(name, options)
      end

      private

      def shared
        @shared ||= Shared.new
      end
    end
  end
end
