Rails.application.routes.draw do
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
  end
  resources :experience_ideas
  resources :businesses
  resources :locations
  resources :categories

  resources :charges

  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
