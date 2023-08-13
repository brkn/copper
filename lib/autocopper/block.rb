# frozen_string_literal: true

# TODO: switch to zeitwerk
require "psych"

module Autocopper
  # Block is a readonly data object for a single rubocop ignore block
  class Block
    # raw_block refers to the single rubocop ignore block of yaml string
    def initialize(raw_block)
      @raw_block = raw_block
      # TODO: block should know it's index.
    end

    def cop_name
      parsed_yaml.keys.first.to_s
    end

    def excluded_files
      # TODO: clean up this access
      parsed_yaml[cop_name]["Exclude"] || []
    end

    def autocorrect
      case @raw_block
      when /supports safe autocorrection \(--autocorrect\)\./
        "safe"
      when /supports unsafe autocorrection \(--autocorrect-all\)\./
        "unsafe"
      else
        "none"
      end
    end

    private

    def parsed_yaml
      @parsed_yaml ||= Psych.safe_load(@raw_block, [Symbol])
    end
  end
end
