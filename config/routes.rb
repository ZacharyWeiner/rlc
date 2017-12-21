Rails.application.routes.draw do
  devise_for :users do
     get '/users/sign_out' => 'devise/sessions#destroy'
  end


  resources :ride_requests do
    get '/assign/:shuttle_id', to: 'ride_requests#assign_to_shuttle', as: 'assign_shuttle'
    get '/mark_clear', to: 'ride_requests#mark_clear', as: 'mark_clear'
    get 'advance_status', to:'ride_requests#advance_status', as: 'advance_status'
    get 'reset_status', to:'ride_requests#reset_status', as: 'reset_status'
    get :autocomplete_pickup_location_name, :on => :collection
  end
  get 'ride_request/manager', to: "ride_requests#manager", as:'ride_request_manager'
  resources :shuttle_stops
  resources :shuttles do
    get 'set_looping', to: 'shuttles#set_looping', as:'set_looping'
    get 'stop_looping', to: 'shuttles#stop_looping', as:'stop_looping'
  end
  get 'shuttle_locations', to: 'shuttles#shuttle_locations', as: 'shuttle_locations'
  get 'shuttle/trackers', to: 'shuttles#trackers', as: 'shuttle_trackers'
  get 'driver', to:'shuttles#driver', as: 'driver'
  post 'driver/:id/set_location', to:'shuttles#set_location', as: 'set_location'
  post 'ride_requests/rider/set_location', to:'ride_requests#set_rider_location', as: 'set_rider_location'
  post 'ride_requests/rider/set_rider_info', to:'ride_requests#set_rider_info', as: 'set_rider_info'
  get 'ride_requests/rider/clear_session', to: 'ride_requests#clear_rider_info', as: 'clear_rider_info'
  get 'assign_drivers', to: 'shuttles#assign_drivers', as: 'assign_drivers'
  resources :images
  resources :experience_occurances do
    resources :reservations
  end
  resources :reservations do
    get 'deposit', to: 'reservations#deposit', as: 'deposit'
  end
  get 'my_reservations', to:'reservations#my_reservations', as: 'my_reservations'

  resources :experiences do
    get 'add_company/:id', to: 'experiences#add_company', as: 'add_company'
    get 'remove_company/:id', to: 'experiences#remove_company', as: 'remove_company'
    resources :reservations
    resources :images
  end

  resources :experience_ideas
  resources :businesses
  resources :locations
  resources :categories

  resources :charges


  get 'test_text', to: 'twilios#send_test', as: 'twilio_test'

  get 'right_column_list', to: 'pages#right_column_list', as: 'right_column_list'
  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
