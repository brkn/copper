# frozen_string_literal: true

module Autocopper
  module Utils
    def to_kebab_case(str)
      str.gsub(/([A-Z]+)([A-Z][a-z])/, "\1-\2")
        .gsub(/([a-z\d])([A-Z])/, "\1-\2")
        .downcase
    end
  end
end
