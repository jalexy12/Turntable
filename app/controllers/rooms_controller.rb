class RoomsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def soundcloud
		tracks = $soundcloud_client.get('/tracks', :limit => 10, :order => 'hotness')
		# @tracks = tracks.map do |track|
  # 			$soundcloud_client.get(track.stream_url)
		# end
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
			@room.users.push(current_user)
			redirect_to :controller => :rooms, :action => :room, :room => @room.name
		else
			flash[:alert] = "You can only be in one room at a time"
			redirect_to('/')
		end
	end
	def room
		@user = User.find_by_id(current_user.id)
		@room = Room.find_by_name(params[:room])
		@users = @room.users.all
		Pusher.trigger("private-#{@room.name}", 'client-userjoin', {users: @users, user: current_user})
	end

	def remove
	  @room = Room.find_by_name(params[:room])
	  @user = User.find_by_id(params[:id])
	  @room.users.delete(params[:id])
	  @users = @room.users.all
	  Pusher.trigger("private-#{@room.name}", 'client-userleave', {users: @users, user: @user})
	  render json: @room.users
	end

	private

	def room_params
		params.require(:room).permit(:name)
	end
end

