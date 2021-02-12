# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'vendor'
end

require 'bundler/setup'
require 'codebreaker'

require_relative '../lib/codebreaker/validation/errors'
require_relative '../lib/codebreaker/validation/validatable'
