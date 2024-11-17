class EndVotesService
  attr_reader :end_votes_params

  def initialize(end_votes_params:)
    @end_votes_params = end_votes_params
  end

  def perform
    closed_status_room
  rescue
    false
  end

  def closed_status_room
    return false unless room

    room.update!(status: 3)
  end

  def room
    @room ||= Room.find(end_votes_params.dig(:room_id))
  end
end
