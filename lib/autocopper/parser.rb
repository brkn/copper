# frozen_string_literal: true

require "psych"

module Autocopper
  class Parser
    def initialize(filepath)
      @filepath = filepath
    end

    def get_block(block_index)
      block_index_with_header = block_index + 1

      file_content = File.read(@file_path)
      raw_block = blocks(file_content)[block_index_with_header]

      raise "No todo block has left" if raw_block.nil? || raw_block.empty?

      parsed_yaml = get_parsed_yaml(raw_block)

      {
        cop_name: get_cop_name(parsed_yaml),
        excluded_files: get_excluded_files(parsed_yaml),
        autocorrect: get_autocorrect(raw_block)
      }
    end

    def remove_block(block_index)
      block_index_with_header = block_index + 1

      file_content = File.read(@file_path)

      blocks = blocks(file_content)
      removed_block = blocks.delete_at(block_index_with_header)
      updated_content = blocks.join("\n\n")

      File.write(@file_path, updated_content)

      cop_name = get_removed_cop_name(removed_block)
      puts "Removed #{cop_name} block from #{@file_path} file"

      removed_block
    end

    private

    def get_parsed_yaml(block)
      Psych.safe_load(block, [Symbol])
    end

    def get_removed_cop_name(removed_block)
      get_cop_name(
        get_parsed_yaml(
          removed_block
        )
      )
    end

    def get_cop_name(parsed_yaml)
      parsed_yaml.keys.first.to_s
    end

    def get_excluded_files(parsed_yaml)
      parsed_yaml[get_cop_name(parsed_yaml)]["Exclude"] || []
    end

    def blocks(file_content)
      file_content.split("\n\n")
    end

    def get_autocorrect(block)
      case block
      when /supports safe autocorrection \(--autocorrect\)\./
        "safe"
      when /supports unsafe autocorrection \(--autocorrect-all\)\./
        "unsafe"
      else
        "none"
      end
    end
  end
end
