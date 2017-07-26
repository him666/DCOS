Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'index#home'
  get 'index/home'
  get 'index/admin'
  post 'index/permission'
  get 'index/document'
  post 'index/document'
  get 'index/data'
  resources :interactions
end

