Rails.application.routes.draw do
  devise_for :users, skip: [:registrations],  controllers: {registrations: 'users/registrations'}
  as :user do

    get   '/join' => 'users/registrations#new',    as: 'new_user_registration'
    post  '/join' => 'users/registrations#create', as: 'user_registration'

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'rooms#index'

  resources :rooms do
    resources :messages
  end
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
