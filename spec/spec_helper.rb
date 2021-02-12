# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'vendor'
  minimum_coverage 95
end

require 'bundler/setup'
require 'codebreaker'

require_relative '../lib/codebreaker/validation/errors'
require_relative '../lib/codebreaker/validation/validatable'
