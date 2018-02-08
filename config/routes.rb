Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  #vendors
  get 'vendors' => 'vendor#index', :as => 'list_vendors'

end
