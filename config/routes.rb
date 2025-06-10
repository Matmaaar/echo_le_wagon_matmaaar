Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Health check & test
  get "up" => "rails/health#show", as: :rails_health_check
  get "test", to: "pages#test"




  # Main content routes
  resources :contents do
    member do
      get :generate_questions
      post :summary, to: "contents#create_summary"
    end
    resources :messages, only: [:index, :create]
    resources :questions, only: [:index, :new, :create]
    resources :notes, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # Questions & answers
  resources :questions do
    resources :answers, only: [:new, :create]
  end

  # UI kit preview page
  get "/uikit", to: "pages#uikit", as: :uikit
end
