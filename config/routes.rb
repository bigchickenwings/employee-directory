Rails.application.routes.draw do
  root "users#index"

  resources :employees, only: %i[index show]

  get "up" => "rails/health#show", as: :rails_health_check
end
