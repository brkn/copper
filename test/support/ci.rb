# frozen_string_literal: true

# Generate XML test reports that can be parsed by CI
require "minitest/ci" if ENV["CI"]
