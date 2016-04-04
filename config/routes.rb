Rails.application.routes.draw do
  root "home#index"
  get  "home" => "home#index"
  post "draw" => "home#draw"
end
