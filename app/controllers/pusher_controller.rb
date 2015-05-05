class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action

  def index
  	Pusher.get_async("/channels").callback { |response|
  		puts response[:channels]
  # use reponse[:channels]
	}.errback { |error|
  # error is an instance of Pusher::Error
	}
  end

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end

end
