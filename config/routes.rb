Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/books/:id" => "books#show"
  resources :publishers

  resource :profile, only: %i{show edit update}

  # 以下のようにresourcesの中に入れ子で親子関係をルーティングできる
  # resources :publishers do
  #   resources :books

  #   member do
  #     get 'detail'
  #   end

  #   collection do
  #     get 'search'
  #   end
  # end
end
