Rails.application.routes.draw do
  resources :reservations
  resources :experiences do
    get 'add_company/:id', to: 'experiences#add_company', as: 'add_company'
    get 'remove_company/:id', to: 'experiences#remove_company', as: 'remove_company'
  end
  resources :experience_ideas
  resources :businesses
  resources :locations
  resources :categories

  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
