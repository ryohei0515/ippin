# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ippin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       routing_specs: false
    end

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # バリデーションエラー時の表示を変更
    # config.action_view.field_error_proc = Proc.new do |html_tag, instance|
    #   if instance.kind_of?(ActionView::Helpers::Tags::Label)
    config.action_view.field_error_proc = proc do |html_tag, instance|
      if instance.is_a?(ActionView::Helpers::Tags::Label)
        "<div class=\"error-label\">#{html_tag}</div>".html_safe
      else
        html_tag.html_safe
      end
    end
  end
end
