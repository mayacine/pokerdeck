class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.find_each
    @room = Room.new
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @shared_url = "#{request.protocol}#{request.host}/#{@room.shared_link}"
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @service = RoomBuilderService.new(build_params: room_params)

    respond_to do |format|
      if @service.perform

        format.html { redirect_to @service.room, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @service.room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def start_vote
    @service = StartVoteService.new(start_vote_params: start_vote_params)

    respond_to do |format|
      if @service.perform
        format.html { redirect_to @service.room, notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @service.room }
      else
        format.html { redirect_to @service.room, notice: "Sart vote failed." }
        format.json { render json: @service.room.errors, status: :unprocessable_entity }
      end
    end
  end

  def vote
    @service = RoomVoteService.new(vote_params: vote_params)
    respond_to do |format|
      if @service.perform

        format.html { redirect_to @service.room, notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @service.room }
      else
        format.html { redirect_to @service.room, notice: "Save vote failed." }
        format.json { render json: @service.room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_path, status: :see_other, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find_by(uuid: params.expect(:id)) || Room.find(params.expect(:id))
    rescue StandardError => e
      redirect_to rooms_path, status: :see_other, notice: "Room not found."
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.expect(room: [ :name, :uuid, :shared_link, :status, :team_name,  :moderator_name ])
    end

    def vote_params
      params.expect(vote: [ :room_id, :contributor_id, :estimation ])
    end
end
