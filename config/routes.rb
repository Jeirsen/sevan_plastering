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

end
