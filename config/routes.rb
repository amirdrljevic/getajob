Rails.application.routes.draw do


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    match '/users/:id',     to: 'users#show',       via: 'get'
    devise_for :users, :path_prefix => 'd'
    resources :users, :only =>[:show]
    resources :categories
    resources :jobs
    root 'home#index'
  end
end
