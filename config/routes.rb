Rails.application.routes.draw do
  root "pages#index"

  resource :session, only: [ :new, :create, :destroy ]

  resources :courses, only: :show do
    member do
      get :confirm_start
      get :complete
      post :start
    end

    resources :steps, only: :show do
      resources :answers, only: :create
    end
  end

  resources :standards, only: [ :show ] do
    member do
      get :courses
      post :generate_certificate
      get :certificate
    end
  end

  get "verify/:certificate_number", to: "verifications#show", as: "verify_certificate"

  resource :profile, only: [ :show ]

  get "up" => "rails/health#show", as: :rails_health_check

  mount Motor::Admin => "/motor_admin"
end
