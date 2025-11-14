Rails.application.routes.draw do
  resources :tasks, only: [:index, :show]
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
