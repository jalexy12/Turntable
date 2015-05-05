class RoomsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(room_params)
		if @room.save
			redirect_to "/joinroom/#{@room.name}"	
		else
			redirect_to '/newroom'
		end
	end

	def joinroom
		@room = params[:id]
		if current_user && current_user.inroom != true
			Pusher.trigger(@room, 'userjoinroom', {newuseralert: "#{current_user.email} has joined the room"})
			current_user.update(inroom: true)
			render :room
		else
			flash[:alert] = "You can only be in one room at a time"
			redirect_to(:index)
		end
	end

	private

	def room_params
		params.require(:room).permit(:name)
	end
end
