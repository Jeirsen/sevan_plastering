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
  get 'model/:id/edit' => 'models#edit'
  post 'model/:id' => 'models#update', :as => 'model_update'

  #orders
  get 'orders/:id' => 'orders#show', :as => 'order_detail'
  get 'search-projects' => 'orders#search_projects', :as => 'search_projects'
  get 'search-lots' => 'orders#search_lots', :as => 'search_lots'
  get 'searc-model' => 'orders#search_model', :as => 'search_model'
  post 'create-order' => 'orders#create_order', :as => 'create_order'
  post 'add-item-order' => 'orders#add_order_item', :as => 'add_item'
  post 'edit-item-order' => 'orders#edit_order_item', :as => 'edit_order_item'

  #templates
  post 'template-product' => 'templates#template_product', :as => 'template_product'

  namespace :admin do
    resources :users
  end

end
