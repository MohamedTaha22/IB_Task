Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  concern :api_base do
    resource :applications, only: [:create]
    scope "/applications" do
      put ':token', to: 'applications#update', as: 'update_application'
      get ':token', to: 'applications#show', as: 'show_application'
      post ':token/chats', to: 'chats#create', as: 'create_chat'
      get ':token/chats/:chat_num', to: 'chats#show', as: 'show_chat'
      get ':token/chats/:chat_num/messages', to: 'messages#index', as: 'list_message'
      post ':token/chats/:chat_num/messages', to: 'messages#create', as: 'create_message'
      get ':token/chats/:chat_num/messages/:message_num', to: 'messages#show', as: 'show_message'
      put ':token/chats/:chat_num/messages/:message_num', to: 'messages#update', as: 'update_message'
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    concerns :api_base
  end
end
