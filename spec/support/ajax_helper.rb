# frozen_string_literal: true

module AjaxHelper
  def wait_for_loaded_until_css_exists(selector)
    until has_css?(selector); end
  end

  def wait_for_loaded_until_content_exists(content)
    until has_content?(content); end
  end

  def wait_for_loaded_until_css_disappeared(selector)
    while has_css?(selector); end
  end

  def wait_for_loaded_until_content_disappeared(content)
    while has_content?(content); end
  end
end
