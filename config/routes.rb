Rails.application.routes.draw do
  resources :ride_requests do
    get '/assign/:shuttle_id', to: 'ride_requests#assign_to_shuttle', as: 'assign_shuttle'
    get '/mark_clear', to: 'ride_requests#mark_clear', as: 'mark_clear'
    get :autocomplete_pickup_location_name, :on => :collection
  end
  get 'ride_request/manager', to: "ride_requests#manager", as:'ride_request_manager'
  resources :shuttle_stops
  resources :shuttles
  get 'shuttle_locations', to: 'shuttles#shuttle_locations', as: 'shuttle_locations'
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



  get 'right_column_list', to: 'pages#right_column_list', as: 'right_column_list'
  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
