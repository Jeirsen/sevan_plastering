Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  #vendors
  resources :vendors
  post 'new-vendor-email' => 'vendors#new_email', :as => 'new_email'

end
