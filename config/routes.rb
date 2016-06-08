Rails.application.routes.draw do
  get 'sponsored_posts/show'

  get 'sponsored_posts/new'

  get 'sponsored_posts/edit'

   resources :labels, only: [:show]
   resources :topics do
      resources :posts, except: [:index]
      resources :sponsoredposts, except: [:index]  
    end

    resources :posts, only: [] do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      post '/up-vote' => 'votes#up_vote', as: :up_vote
      post '/down-vote' => 'votes#down_vote', as: :down_vote
    end

   resources :users, only: [:new, :create]
   resources :sessions, only: [:new, :create, :destroy]

   get 'about' => 'welcome#about'

  root 'welcome#index'
end
