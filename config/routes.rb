Rails.application.routes.draw do

  resources :projects
  resources :builders
  devise_for :users
  root 'home#index'

  #vendors
  resources :vendors
  post 'vendor-email' => 'vendors#vendor_email', :as => 'vendor_email'

  #products
  resources :products

end
