Rails.application.routes.draw do
  resources :groups
  resources :shifts
  devise_for :users
  root 'shifts#index'
  resources :blogs
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
