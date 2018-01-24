Rails.application.routes.draw do
  resources :business_settings do
    get 'activate_ride_requests', to: 'business_settings#activate_ride_requests', as: 'activate_ride_requests'
    get 'deactivate_ride_requests', to: 'business_settings#deactivate_ride_requests', as: 'deactivate_ride_requests'
  end
  resources :kill_switches
  devise_for :users do
     get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'ride_requests/inactive', to:'ride_requests#inactive', as: 'inactive'
  get 'ride_requests/new_2', to:'ride_requests#new_2', as: 'new_2'

  resources :ride_requests do
    get '/assign/:shuttle_id', to: 'ride_requests#assign_to_shuttle', as: 'assign_shuttle'
    get '/mark_clear', to: 'ride_requests#mark_clear', as: 'mark_clear'
    get 'advance_status', to:'ride_requests#advance_status', as: 'advance_status'
    get 'reset_status', to:'ride_requests#reset_status', as: 'reset_status'
    get 'send_inital_sms', to: 'ride_requests#send_inital_sms', as: 'send_inital_sms'
    get :autocomplete_pickup_location_name, :on => :collection

  end
  get 'ride_request/manager', to: "ride_requests#manager", as:'ride_request_manager'
  get 'ride_request/check_last_ride/:id', to: "ride_requests#check_last_ride", as:'last_ride'
  resources :shuttle_stops
  resources :shuttles do
    get 'set_looping', to: 'shuttles#set_looping', as:'set_looping'
    get 'stop_looping', to: 'shuttles#stop_looping', as:'stop_looping'
    get 'set_active', to: 'shuttles#set_active', as:'set_active'
    get 'set_inactive', to: 'shuttles#set_inactive', as:'set_inactive'
    get 'driver', to: "shuttles#driver", as: "driver"
    get 'clear_all', to: "shuttles#clear_all", as: "clear_all"
    get 'all_rolling', to: "shuttles#all_rolling", as: "all_rolling"
    get 'check_last_ride/:id', to: 'shuttles#check_last_ride', as: 'check_last_ride'
  end
  get 'shuttle_locations', to: 'shuttles#shuttle_locations', as: 'shuttle_locations'
  get 'shuttle/trackers', to: 'shuttles#trackers', as: 'shuttle_trackers'
  get 'driver', to:'shuttles#driver', as: 'driver'
  get 'driver/:id', to:'shuttles#driver', as: 'driver_id'
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
  resources :locations do
    get 'show_after_2', to: 'locations#set_show_after_2', as: 'show_after_2'
  end
  resources :categories

  resources :charges
  get 'set_play_sound', to: "business_settings#set_play_sound", as: 'set_play_sound'

  get 'test_text', to: 'twilios#send_test', as: 'twilio_test'

  get 'right_column_list', to: 'pages#right_column_list', as: 'right_column_list'
  get 'front_desk', to: 'pages#front_desk', as: 'front_desk'
  post 'pages/front_desk/send_sms', to: 'pages#send_sms', as: 'pages_send_sms'
  post 'pages/front_desk/send_sms_intl', to: 'pages#send_sms_intl', as: 'pages_send_sms_intl'
  get 'message_sent', to: 'pages#text_message_sent', as: 'text_message_sent'

  get 'mobile_pages/ride_request', to: 'mobile_pages#ride_request', as: 'mobile_ride_request'
  post 'mobile_pages/create', to: 'mobile_pages#create', as: 'mobile_create_ride_request'
  get 'mobile_pages/ride_request_details/:ride_request_id', to: 'mobile_pages#ride_request_details', as: 'mobile_ride_request_details'
  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
