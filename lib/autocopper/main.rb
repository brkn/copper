# frozen_string_literal: true

module Autocopper
  class Main
    def initialize(file_path, num_of_cops)
      @file_path = file_path
      @num_of_cops = num_of_cops
      @parser = Parser.new(file_path)

      @index = 0
      @fixed_cops = []
    end

    def call
      puts "Will correct only #{@num_of_cops} rules...\n\n" unless @num_of_cops.nil?

      loop_limit = @num_of_cops || 999_999_999

      while fixed_cops.length < loop_limit
        corrected_cop_name = Corrector.new(block, @index, @parser).correct

        if corrected_cop_name.nil?
          @index += 1
          next
        end

        @fixed_cops << corrected_cop_name
      end

      print_exit_stats
    rescue StandardError => e
      warn "Error: #{e.message}"
      exit(1)
    end

    private

    def block
      @parser.get_block(@index)
    end

    def print_exit_stats
      if @fixed_cops.empty?
        puts "There wasn't any cops that can be fixed via autocorrect."
      else
        puts "Fixed cops: #{@fixed_cops.join(', ')}"
      end
    end

    # trap "SIGINT" do
    #   puts "Received interrupt. Shutting down gracefully."

    #   # TODO: Move this into its own class
    #   # puts "FIXME, add the #{deleted_block} into the #{index} again"
    #   # puts "FIXME, call git reset --hard HEAD"
    #   # puts "FIXME, finish the "

    #   print_exit_stats(fixed_cops)

    #   exit 130
    # end
  end
end
