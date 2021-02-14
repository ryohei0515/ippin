# frozen_string_literal: true

require 'rspec/retry'

RSpec.configure do |config|
  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.around :each, :js do |example|
    example.run_with_retry retry: 2
  end

  config.retry_callback = proc do |example|
    Capybara.reset! if example.metadata[:js]
  end
end
