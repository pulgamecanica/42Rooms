Rails.application.routes.draw do
  #Root
  root 'rooms42#rooms'
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

  get '/reservations/:id', to: 'rooms42#reservation', as: "reservation"
  get '/reservations/:id/edit', to: 'rooms42#edit_reservation', as: "edit_reservation"
  get '/rooms/:id/calendar', to: 'rooms42#calendar', as: 'room_calendar'
  resources :reservations, only: [:update, :create, :edit]

  #Admin Routes
  get '/home', to: 'admins#home'
  scope module: 'admins' do
    resources :rooms, only: [:new, :create, :edit, :update, :destroy] do 
      resources :white_lists, only: [:create, :destroy]
    end
    resources :users, only: [:new, :create, :edit, :update, :destroy, :index]
  end
end
