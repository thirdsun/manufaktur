ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def authenticate(admin: false)
    if admin
      @key = api_keys(:admin_api_key).key
    else
      @key = api_keys(:user).key
    end

    request.headers['Authorization'] = "Token token=#{@key}"
  end
end

class PolicyTest < ActiveSupport::TestCase
  def assert_permit(user, record, action)
    message = "User #{user} should be permitted #{action} on #{record}, but isn't."
    assert permit(user, record, action), message
  end

  def refute_permit(user, record, action)
    message = "User #{user} should NOT be permitted #{action} on #{record}, but is."
    refute permit(user, record, action), message
  end

  def permit(user, record, action)
    self.class.to_s.gsub(/Test/, "").constantize.new(user, record).public_send("#{action.to_s}?")
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end