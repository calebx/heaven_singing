Rails.application.routes.draw do
  root "home#index"
  get  "home" => "home#index"
  post "draw" => "home#draw"
  get  "list" => "home#list"

  get "try" => "home#try"
end
