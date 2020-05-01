Rails.application.routes.draw do

  root 'home#index'
  
  get '/stats' , to: "home#stats"

  resources :home,path: "/", only: [:index, :create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
