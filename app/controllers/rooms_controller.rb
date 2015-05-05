class RoomsController < ApplicationController
	def index
	end

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(room_params)
		if @room.save
			callback
			redirect_to "/joinroom/#{@room.name}"	
		else
			redirect_to '/newroom'
		end
	end

	def joinroom
		@room = params[:id]
		Pusher.trigger(@room, 'event', {foo: 'Hi user'})
		render :room
	end

	private

	def room_params
		params.require(:room).permit(:name)
	end
end
