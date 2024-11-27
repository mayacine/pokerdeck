Rails.application.routes.draw do
  resources :rooms do
    member do
      get "vote/:participant_id", action: "vote"
      get "reset", action: "reset"
      get "participate", action: "participate"
      get "reveal_votes", action: "reveal_votes"
      get "hide_votes", action: "hide_votes"
      post "participation", action: "participation"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "rooms#new"
end
