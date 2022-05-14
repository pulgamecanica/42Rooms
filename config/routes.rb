Rails.application.routes.draw do
  #Root
  root 'rooms42#home'
  #User routes
  devise_for :users
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  #Authentication routes
  get 'authentication/ft_auth', to: "authentication#ft_auth"
  get 'authentication42api', to: 'authentication#authenticate' #authentication42api_path
  get 'authentication42api/callback', to: 'authentication#authentication_callback'#authentication42api_callback_path
  #Website Routes
  get 'rooms', to: 'rooms42#rooms'
  get '/rooms/:id', to: 'rooms42#show', as: 'room'
end
