Rails.application.routes.draw do
  root "employees#index"

  resources :employees, only: %i[index show]

  get "up" => "rails/health#show", as: :rails_health_check
end
