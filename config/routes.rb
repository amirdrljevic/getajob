Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    match '/users/:id',     to: 'users#show',       via: 'get'
    devise_for :users, :path_prefix => 'd'
    resources :users, :only =>[:show]
    #special route to display all applications for all jobs for certain user, shown only if there is no job_id in URL params
    resources :applications, :only => [:index] 
    resources :categories
    resources :jobs do 
      resources :applications
    end
    root 'home#index'
  end
end
