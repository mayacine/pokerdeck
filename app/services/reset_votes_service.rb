class ResetVotesService
  attr_reader :reset_votes_params

  def initialize(reset_votes_params:)
    @reset_votes_params = reset_votes_params
  end

  def perform
    reset_votes_status
  end

  def room
    @room ||= Room.find(reset_votes_params.dig(:room_id))
  end

  private
  
  def reset_votes_status
    return false unless room

    room.votes.delete_all
  end
end

