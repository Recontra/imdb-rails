Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :create, :update, :show, :destroy]
      resources :users, only: [:create]

      post "login"  => "sessions#create"
    end
  end
end
