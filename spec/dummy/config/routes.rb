Rails.application.routes.draw do
  root to: 'pages#home'
  resources :restaurants
  mount HeraCms::Engine => "/hera_cms"
end
