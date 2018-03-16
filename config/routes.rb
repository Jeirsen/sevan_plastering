Rails.application.routes.draw do

  resources :lots
  resources :projects
  resources :builders
  devise_for :users
  root 'home#index'

  #vendors
  resources :vendors
  post 'vendor-email' => 'vendors#vendor_email', :as => 'vendor_email'
  post 'vendor-product' => 'vendors#vendor_product', :as => 'vendor_product'

  #products
  resources :products
  post 'admin-product' => 'products#admin_product', :as => 'admin_product'
  get 'search-products' => 'products#search_products', :as => 'search_products'

  #units
  get 'units' => 'units#index', :as => 'units'
  post 'admin-unit' => 'units#admin_unit', :as => 'admin_unit'

  #models
  post 'create-model' => 'models#create', :as => 'create_model'
  get 'model/:id/show' => 'models#show', :as => 'model_detail'

end
