class RoomBuilderService
  attr_reader :build_params

  def initialize(build_params:)
    @build_params = build_params
  end

  def perform
    build_room.save!
    build_moderator.save!
  rescue
    false
  end

  def room
    @room
  end

  private

  def build_moderator
    @moderator = Moderator.new
    @moderator.name = build_params.dig(:moderator_name)
    @moderator.current_room_uuid = room.uuid
    @moderator.team_name = build_params.dig(:team_name)
    @moderator
  end

  def build_room
    @room = Room.new(build_params.except(:moderator_name, :team_name))
    @room.uuid = Random.uuid
    @room.shared_link = "/rooms/#{@room.uuid}"
    @room.status = 0

    @room
  end
end
