class RevealVoteService
  attr_reader :reveal_vote_params

  def initialize(reveal_vote_params:)
    @reveal_vote_params = reveal_vote_params
  end

  def perform
    change_votes_status
  end

  def room
    @room ||= Room.find(reveal_vote_params.dig(:room_id))
  end

  private
  
  def change_votes_status
    return false unless room

    room.votes.update_all!(status: 1)
  end
end

