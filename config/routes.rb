Nftixs::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  root to: 'tickets#index'

  get "/login" => "access#new"
  get '/forgot-password' => "access#forgot_password", :as => "forgot_password"
  get "/logout" => "access#destroy"
  put "send_reset_password" => "access#send_reset_password", :as => 'send_reset_password'
  get "reset_password/:token" => "access#reset_password", :as => 'reset_password'
  put "update_reset_password" => "access#update_reset_password", :as => 'update_reset_password'
  get "/authenticate/:auth" => "members#authenticate", :as => "authenticate"


  resource :access, :controller => "access" do
    get :forgot_password
  end

  resources :tickets
  resources :ticket_groups
  resources :users
end
