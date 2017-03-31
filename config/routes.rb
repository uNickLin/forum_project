Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :topics do
  	member do # member做特定物件的事件
      post :comments
      # put :edit_comment
      delete :del_comment
    end

    collection do
      get :about_us
    end

  end

  resources :users do
    collection do # collection做所有物件的事件（不指定id）
      get :my_posts
      get :my_collection
      delete :del_my_post
    end
  end

  root "topics#index"
end