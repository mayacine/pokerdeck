class StartVoteService
  attr_reader :start_vote_params

  def initialize(start_vote_params:)
    @start_vote_params = start_vote_params    
  end

  def perform
    change_status_room
  rescue
    false
  end
  
  def change_status_room
    return false unless room

    room.update!(status: 1)
  end

  def room
    @room ||= Room.find(start_vote_params.dig(:room_id))
  end
end
