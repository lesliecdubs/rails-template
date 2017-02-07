# frozen_string_literal: true
require 'email_spec'
require 'email_spec/rspec'

RSpec.configure do |config|
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.before(:each) do
    reset_mailer # Clears out ActionMailer::Base.deliveries
  end
end
