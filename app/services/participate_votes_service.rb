
class ParticipateVotesService
  attr_reader :participate_vote_params

  def initialize(participate_vote_params:)
    @participate_vote_params = participate_vote_params
  end

  def perform
    add_contributor 
  rescue
    false
  end

  def add_contributor
    return false unless room

    contributor = room.contributors.build
    contributor.name = participate_vote_params.dig(:contributor_name)
    contributor.save!
  end

  def room
    @room ||= Room.find(participate_vote_params.dig(:room_id))
  end
end
