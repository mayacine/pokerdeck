# frozen_string_literal: true

class StartedVotePanelComponent < ViewComponent::Base
  attr_reader :room, :shared_url, :moderator_name, :current_contributor, :contributors

  def initialize(room:, shared_url:, moderator_name:, current_contributor:, contributors:)
    @room = room
    @shared_url = shared_url
    @moderator_name = moderator_name
    @current_contributor = current_contributor
    @contributors = contributors
  end
end
