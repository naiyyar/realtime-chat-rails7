class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]
  
  # GET /rooms or /rooms.json
  def index
    @rooms = Room.order(created_at: :desc)
    @single_room = @rooms.first
    @messages = @single_room.messages.order(created_at: :asc)
    @room = Room.new

    render 'index'
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @rooms = current_user.rooms.order(created_at: :desc)
    @single_room = @room
    @messages = @single_room.messages.order(created_at: :asc)
    @room = Room.new

    render 'index'
  end

  # GET /rooms/new
  def new
    @users = User.where.not(id: current_user.id)
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.create!(room_params.merge(user_id: current_user.id))    
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.remove(@room)
      }
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name)
    end
end
