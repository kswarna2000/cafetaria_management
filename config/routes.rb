Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "home#index"
  get "/report", to: "orders#report"
  post "/orderitems/showmenuitems", to: "orderitems#showmenuitems"
  get "/orders/showorders", to: "orders#showorders"
  get "/orderitems/showitems", to: "orderitems#showitems"
  get "/orders/complaints", to: "orders#complaints"
  get "/orders/viewcomplaints", to: "orders#viewcomplaints"
  post "/orderitems/display", to: "orderitems#display"
  post "/orders/store", to: "orders#store"
  post "/menus/edit", to: "menus#edit"
  post "/orders/mark", to: "orders#mark"
  post "/orders/complain", to: "orders#complain"
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  post "/orderitems/invoice", to: "orderitems#invoice"
  get "/orderitems/showinvoice", to: "orderitems#showinvoice"
  post "/filter", to: "orders#filter"
  get "/orders/showreport", to: "orders#showreport"
  get "/users/newclerk", to: "users#newclerk"
  resources :menuitems
  resources :orders
  resources :orderitems
  resources :menus
  resources :users
  resources :sessions
end
