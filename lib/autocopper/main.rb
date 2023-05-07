# frozen_string_literal: true

module Autocopper
  class Main
    def initialize(file_path, num_of_cops)
      @file_parser = File.new(file_path)
      @num_of_cops = num_of_cops

      @index = 0
      @fixed_cops = []
    end

    def call
      puts "Will correct only #{@num_of_cops} rules...\n\n" unless @num_of_cops.nil?

      while @fixed_cops.length < loop_limit
        corrected_cop_name = Corrector.new(block, @index, @file_parser).correct

        if corrected_cop_name.nil?
          @index += 1
          next
        end

        @fixed_cops << corrected_cop_name
      end

      puts finished_message
    rescue StandardError => e
      warn "Error: #{e.message}"
      raise e
    end

    private

    def loop_limit
      @loop_limit ||= if @num_of_cops.nil?
                        999_999_999
                      else
                        @num_of_cops
                      end
    end

    def block
      @file_parser.get_block(@index)
    end

    def finished_message
      return "There wasn't any cops that can be fixed via autocorrect." if @fixed_cops.empty?

      "Fixed cops: #{@fixed_cops.join(', ')}"
    end

    # trap "SIGINT" do
    #   puts "Received interrupt. Shutting down gracefully."

    #   # TODO: Move this into its own class
    #   # puts "FIXME, add the #{deleted_block} into the #{index} again"
    #   # puts "FIXME, call git reset --hard HEAD"

    #   puts finished_message

    #   exit 130
    # end
  end
end
