Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'questions#index'
  resources :questions do
    get  'play', on: :member
    post  'answer', on: :member
  end
  get   'feed', to: 'questions#feed', as: 'feed'
  get   'result/:answer_id', to: 'questions#result', as: 'result'
  patch 'evaluate/:answer_id', to: 'questions#evaluate', as: 'evaluate'
end
