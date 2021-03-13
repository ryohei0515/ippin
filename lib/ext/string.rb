# frozen_string_literal: true

class String
  def strip_all_space!
    gsub!(/(^[[:space:]]+)|([[:space:]]+$)/, '') || ''
  end

  def strip_all_space
    clone.strip_all_space!
  end
end
