class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy participate ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.find_each
    @room = Room.new
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    redirect_to participate_room_path(@room) if session[:current_contributor].blank?

    # session[:moderator_name] = @room.moderator_name unless session[:moderator_name]

    @moderator_name = @room.moderator_name
    @current_contributor = session[:current_contributor]
    @contributors = @room.contributors
 
    @shared_url = "#{request.protocol}#{request.host}:#{request.port}#{@room.shared_link}/participate"
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
        session[:moderator_name] = @service.room.moderator_name
        session[:current_contributor] = @service.room.moderator_name

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

  def participation 
    @service = ParticipateVotesService.new(participate_vote_params: { room_id: params[:id], contributor_name: params[:name]})

    respond_to do |format|
      if @service.perform
        session[:current_contributor] = params[:name]

        format.html { redirect_to @service.room, notice: "Contributor was successfully created." }
        format.json { render :show, status: :created, location: @service.room }
      else
        format.html { redirect_to @service.room, notice: "Contributor add failed." }
        format.json { render json: @service.room.errors, status: :unprocessable_entity }
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
        format.html { redirect_to @service.room, notice: "Start vote failed." }
        format.json { render json: @service.room.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset 
    @service = ResetVotesService.new(reset_votes_params: {room_id: reset_votes_params})

    respond_to do |format|
      if @service.perform
        format.html { redirect_to @service.room, notice: "Votes was successfully reinit." }
        format.json { render :show, status: :created, location: @service.room }
      else
        format.html { redirect_to @service.room, notice: "Reinit votes failed." }
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

  def participate
  end

  def reveal_votes
  end

  def hide_votes
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.empty_moderator_name
    @room.destroy!
    session[:moderator_name] = nil
    session[:current_contributor] = nil

    respond_to do |format|
      format.html { redirect_to rooms_path, status: :see_other, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find_by(uuid: params.expect(:id)) || Room.find(params.expect(:id))
    rescue 
      redirect_to rooms_path, status: :see_other, notice: "Room not found."
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.expect(room: [ :name, :uuid, :shared_link, :status, :team_name,  :moderator_name ])
    end

    def reset_votes_params
      params.expect(:id)
    end

    def vote_params
      params.expect(vote: [ :room_id, :contributor_id, :estimation ])
    end
end
