Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  #vendors
  get '/vendors' => 'vendor#index', :as => 'list_vendors'
  get '/vendor/new' => 'vendor#new', :as => 'new_vendor'
  get '/vendor/(:id)' => 'vendor#show', :as => 'vendor_detail'
  post '/vendor' => 'vendor#create'

end
