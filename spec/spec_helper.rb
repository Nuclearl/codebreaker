# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 100
  add_filter 'spec'
  add_filter 'vendor'
end

require 'bundler/setup'
require 'codebreaker'
require 'ffaker'

require_relative '../lib/codebreaker/validation/errors'
require_relative '../lib/codebreaker/validation/validatable'
