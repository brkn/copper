# frozen_string_literal: true

# describe Autocopper, "::CLI" do
# TODO: move this complexity inside the before all into spec helper
# before(:all) do
#   @temp_dir_path = Dir.mktmpdir

#   Dir.chdir(@temp_dir_path)

#   system("git init")

#   FileUtils.cp(gemfile_path, "Gemfile")
#   # FileUtils.cp(gemfile_lock_path, "Gemfile.lock")
#   FileUtils.cp(rubocop_todo_fixture_path, ".rubocop_todo.yml")
#   FileUtils.cp(rubocop_fixture_path, ".rubocop.yml")

#   FileUtils.copy_entry(app_fixture_path, "./app")

#   system("bundle install")
#   system("git add . && git commit -m 'init with fixtures'")
# end

# after(:all) do
#   FileUtils.remove_entry_secure(@temp_dir_path)
# end

# let(:arguments) { [] }

# it 'calls autocopper and returns "foo"' do
#   output = Autocopper::CLI.new.call(arguments)

#   expect(output).to eq("foo")
# end
# end
