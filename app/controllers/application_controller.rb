class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  $soundcloud_client = SoundCloud.new({
    :client_id     => "63e3ccea0adc000556c062fa4d6d51af",
    :client_secret => "2f3f52086467bd7ad086a8a3da4680ce",
  })
end
