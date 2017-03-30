Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :topics do
  	member do # member做特定物件的事件(collection做所有物件的事件（不指定id）)
      post :comments
      delete :del_comment
    end

    collection do
      get :about_us
    end

  end

  resources :users do
    collection do
      get :my_posts
      delete :del_my_post
    end
  end

  root "topics#index"
end