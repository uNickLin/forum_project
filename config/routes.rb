Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :topics do
  	member do # member做特定物件的事件
      post :like
      post :dislike
      post :add_collection
      post :remove_collection
      post :comments
      delete :del_comment
    end

    collection do
      get :about_us
    end

  end

  resources :users do
    collection do # collection做所有物件的事件（不指定id）
      get :my_posts
      get :my_collections
      delete :del_my_post
    end
  end

  root "topics#index"
end