class RoomVoteService
  attr_reader :vote_params

  def initialize(vote_params:)
    @vote_params = vote_params
  end

  def perform
    create_vote
  rescue
    false
  end

  private

  def create_vote
     @vote = Vote.new
     @vote.room_id = vote_params.dig(:room_id)
     @vote.contributor_id = vote_params.dig(:contributor_id)
     @vote.estimation = vote_params.dig(:estimation)
     @vote.status = 0
     @vote.save!
  end
end
