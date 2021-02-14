HeraCms::Engine.routes.draw do
  root to: "dashboard#home"

  resources :links, only: :update
end
