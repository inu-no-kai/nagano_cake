Rails.application.routes.draw do

  namespace :public do
    get 'products/index'
    get 'products/show'
  end
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do

    root 'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
    get "search" => "searches#search"

    resources :products, only: [:index, :show]

    resources :customers, only: [:show, :edit, :update]

    get '/customers/:id/quit' => 'customers#quit', as: 'quit'

    patch 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'

    resources :cart_items, only: [:index, :update, :destroy, :create]
      resources :cart_items do
        collection do
          delete 'destroy_all'
        end
      end

    resources :orders, only: [:new, :index, :show, :create] do
        collection do
          post 'confirm'
          get 'thanks'
        end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  get "search" => "searches#search"
  namespace :admin do

   get "/" => "homes#top"

    resources :products, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update]

    resources :order_details, only: [:update]

  end

end
