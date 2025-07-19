Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  authenticated :user do
    root to: "habits#index", as: :authenticated_root
    resources :habits do
      resources :habit_checkins, only: [ :create, :destroy ]
    end
  end

  unauthenticated do
    root to: "home#index"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
