# frozen_string_literal: true

class ClipboardComponent < ViewComponent::Base
  attr_reader :content_str

  def initialize(content_str:)
    @content_str = content_str
  end
end
