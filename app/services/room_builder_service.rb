class RoomBuilderService
  attr_reader :build_params
  def initialize(build_params:)
    @build_params = build_params
  end

  def perform
    build_room.save
  end
  
  def room 
    @room
  end
  
  private

  def build_room
    @room = Room.new(build_params)
    @room.uuid = Random.uuid
    @room.shared_link = "/rooms/#{@room.uuid}"
    @room.status = 0

    @room
  end
end