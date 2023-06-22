Rails.application.routes.draw do

  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do

    root 'homes#top'

    resources :items, only: [:index, :show]

    resources :customers, only: [:show, :edit, :update,]
      resources :customers do
        collection do
          get 'quit'
          patch 'unsubscribe'
        end
      end

    resources :cart_items, only: [:index, :update, :destroy, :create]
      resources :cart_items do
        collection do
          delete 'destroy_all'
        end
      end

    resources :orders, only: [:new, :index, :show, :create]
      resources :orders do
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

  namespace :admin do

    root 'homes#top'

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update]

    resources :order_details, only: [:update]

  end

end
