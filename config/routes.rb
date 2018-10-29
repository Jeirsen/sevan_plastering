Rails.application.routes.draw do

  resources :lots
  resources :projects
  resources :builders
  devise_for :users
  root 'home#index'

  #History Orders
  get 'archived-orders' => 'home#history', :as => 'history_orders'

  #vendors
  resources :vendors
  post 'vendor-email' => 'vendors#vendor_email', :as => 'vendor_email'
  post 'vendor-product' => 'vendors#vendor_product', :as => 'vendor_product'
  delete 'remove-product-vendor' => 'vendors#remove_product_vendor', :as => 'remove_product_vendor'

  #products
  resources :products
  post 'admin-product' => 'products#admin_product', :as => 'admin_product'
  get 'search-products' => 'products#search_products', :as => 'search_products'
  post 'prioritize-product' => 'products#prioritize', :as => 'prioritize_product'
  post 'remove-product' => 'products#remove_product', :as  => 'remove_product'


  #units
  get 'units' => 'units#index', :as => 'units'
  post 'admin-unit' => 'units#admin_unit', :as => 'admin_unit'

  #models
  post 'create-model' => 'models#create', :as => 'create_model'
  get 'model/:id/show' => 'models#show', :as => 'model_detail'
  get 'model/:id/edit' => 'models#edit'
  post 'model/:id' => 'models#update', :as => 'model_update'
  delete 'remove-model' => 'models#remove_model', :as => 'remove_model'

  #orders
  get 'orders/:id' => 'orders#show', :as => 'order_detail'
  get 'search-projects' => 'orders#search_projects', :as => 'search_projects'
  get 'search-lots' => 'orders#search_lots', :as => 'search_lots'
  get 'searc-model' => 'orders#search_model', :as => 'search_model'
  post 'create-order' => 'orders#create_order', :as => 'create_order'
  post 'add-item-order' => 'orders#add_order_item', :as => 'add_item'
  post 'edit-item-order' => 'orders#edit_order_item', :as => 'edit_order_item'
  post 'send-order-mail' => 'orders#send_mail', :as => 'send_mail'
  delete 'remove-order-item' => 'orders#remove_item', :as => 'remove_order_item'
  get 'search_orders_by' => 'orders#search_orders_by', :as => 'search_orders_by'
  post 'remove-order' => 'orders#remove_order', :as => 'remove_order'

  #templates
  post 'template-product' => 'templates#template_product', :as => 'template_product'
  delete 'remove-product-template' => 'templates#remove_template_product', :as => 'remove_template_product'

  namespace :admin do
    resources :users
    get 'settings' => 'settings#index'
    get 'settings/:setting_id/edit' => 'settings#edit'
    put 'settings/:setting_id/edit' => 'settings#update'
  end

end
