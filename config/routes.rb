HeraCms::Engine.routes.draw do
  # root to: "dashboard#home"

  resources :links, only: :update
  resources :texts, only: :update
  resources :images, only: :update
end
