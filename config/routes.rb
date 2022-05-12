Rails.application.routes.draw do
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root 'rooms42#home'

  devise_for :users

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'authentication/ft_auth', to: "authentication#ft_auth"
  get 'authentication42api', to: 'authentication#authenticate' #authentication42api_path
  get 'authentication42api/callback', to: 'authentication#authentication_callback'#authentication42api_callback_path

  get 'rooms', to: 'rooms42#rooms'

end
