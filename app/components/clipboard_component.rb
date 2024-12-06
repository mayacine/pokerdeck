# frozen_string_literal: true

class ClipboardComponent < ViewComponent::Base
  attr_reader :content_str, :visible

  def initialize(content_str:, visible: true)
    @content_str = content_str
    @visible = visible
  end

  def render?
    visible
  end
end
