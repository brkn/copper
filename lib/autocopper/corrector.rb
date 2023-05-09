# frozen_string_literal: true

module Autocopper
  class Corrector
    # TODO: expect less arguments or make them kwargs
    def initialize(block, index, file_parser, file_path)
      @block = block
      @index = index
      @file_parser = file_parser
      @file_path = file_path
    end

    def correct
      return "FIXME, return a message to inform the caller, they should increment the index" unless valid?

      remove_block
      rubocop_autocorrect
      git_commit

      @block.cop_name
    end

    private

    def valid?
      return false if @block.excluded_files.empty?
      return false if @block.autocorrect == "none"

      true
    end

    def remove_block
      @file_parser.remove_block(@index)
    end

    def rubocop_autocorrect
      exit_status = system("bundle exec rubocop -A #{excluded_files_argument} > /dev/null")

      if exit_status
        puts "Auto corrected files via Rubocop."
      else
        raise "rubocop autocorrect failed"
      end
    end

    def git_commit
      raise "git commit failed" unless system("git add #{excluded_files_argument} #{@file_path} > /dev/null")
      raise "git commit failed" unless system("git commit -m 'Fix #{@block.cop_name} violations' > /dev/null")

      puts "Created a git commit for #{kebab_cop_name}...\n\n"

      true
    end

    def excluded_files_argument
      @block.excluded_files.join(" ")
    end

    def kebab_cop_name
      Utils.to_kebab_case(@block.cop_name)
    end

    # def with_seperate_branch
    # # raise 'git commit failed' unless system("git checkout -b #{branch_name} > /dev/null")

    # # yield

    # # raise 'git commit failed' unless system('git checkout master > /dev/null')
    # end

    # def branch_name
    #   "rubocop/fix-#{kebab_cop_name}"
    # end
  end
end
