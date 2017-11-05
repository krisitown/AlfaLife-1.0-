Rails.application.routes.draw do
  root 'articles#index'

  resources :users
  resources :questions
  resources :articles
  resources :messages
  resources :plan_requests
  resources :videos
  resources :plans
  
 

  get 'auth/:provider/callback' => 'sessions#social_auth'

  get 'make_payment' => 'plan_requests#make_payment'
  post 'send_payment' => 'plan_requests#send_payment' 

  get 'plans/new/:to_user/:request_id' => 'plans#new'
  get 'videos/show/:id' => 'videos#show'
  get 'videos/:id/delete' => 'videos#delete'
  get 'videos/:id/make_featured' => 'videos#make_featured'
  get 'videos/category/:category' => 'videos#index'

  get 'articles/:id/delete' => 'articles#delete'
  get 'questions/:id/delete' => 'questions#delete'
  get 'comments/:id/delete' => 'comments#delete'
  post 'questions/upvote' => 'comments#upvote'
  post 'questions/downvote' => 'comments#downvote'
  
  post 'discussions/change_category' => 'questions#change_category'
  get 'discussions/change_category' => 'questions#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  
  get 'receive_payment_123875136516898791374817348' => 'plan_requests#new'

  post 'add_comment' => 'comments#create'
end
