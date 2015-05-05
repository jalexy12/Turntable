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
		@room = Room.find_by_name(params[:id])
		if current_user
			Pusher.trigger(@room.name, 'userjoinroom', {newuseralert: "#{current_user.email} has joined the room"})
			redirect_to :controller => :rooms, :action => :room, :room => @room.name
		else
			flash[:alert] = "You can only be in one room at a time"
			redirect_to('/')
		end
	end
	def room
		@user = User.find_by_id(current_user.id)
		@room = Room.find_by_name(params[:room])
		@room.users.push(@user)
	end

	private

	def room_params
		params.require(:room).permit(:name)
	end
end
