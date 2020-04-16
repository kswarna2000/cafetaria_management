Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/orders/showorders", to: "orders#showorders"
  post "/orderitems/redirect", to: "orderitems#redirect"
  resources :menuitems
  resources :orders
  resources :orderitems
  resources :menus
end
