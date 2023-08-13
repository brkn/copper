# frozen_string_literal: true

module Autocopper
  class FileParser
    def initialize(file_path)
      @file_path = file_path
    end

    attr_reader :file_path

    def get_block(block_index)
      block_index_with_header = block_index + 1

      raw_block = raw_blocks.delete_at(block_index_with_header)

      raise "No todo block has left" if raw_block.nil?
      raise "No todo block has left" if raw_block.empty?

      Block.new(raw_block)
    end

    def remove_block(block_index)
      block_index_with_header = block_index + 1
      # TODO: fix naming here, raw_blocks_snapshot is horrible.
      raw_blocks_snapshot = raw_blocks # have to create a copy of the hash here

      raw_removed_block = raw_blocks_snapshot.delete_at(block_index_with_header)
      updated_raw_blocks = raw_blocks_snapshot.join("\n\n")

      File.write(@file_path, updated_raw_blocks)

      removed_block = Block.new(raw_removed_block)

      puts "Removed #{removed_block.cop_name} block from #{@file_path} file"

      removed_block
    end

    private

    def file_content
      # NOTE: Do not cache this method. We always want the latest version
      File.read(@file_path)
    end

    def raw_blocks
      file_content.split("\n\n")
    end
  end
end
