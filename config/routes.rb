Rails.application.routes.draw do
  devise_for :users
  root 'pusher#index'
  post '/pusher/auth' => 'pusher#auth'
  #Create new room
  get '/newroom' => 'rooms#new'
  post '/newroom' => 'rooms#create', as: :rooms
  #Join room
  get '/joinroom/:id' => 'rooms#joinroom'
  #Room itself
  get '/room/:room' => 'rooms#room'
  #Remove users from room in DB
  post '/room/:room/remove/:id' => 'rooms#remove'
  #Soundcloud test
  get '/soundcloud' => "rooms#soundcloud"
end
