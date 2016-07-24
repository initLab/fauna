Rails.application.routes.draw do
  resources :members_fees, only: [:index, :create, :destroy]

  resource :user, only: [] do
    resources :network_devices, only: [:index, :create, :update, :destroy]
  end

  authenticated do
    devise_scope :user do
      get 'users/edit' => 'devise/registrations#edit', as: :user_root
    end
  end

  namespace :fauna do
    resources :users, only: [:index, :edit, :update, :show, :destroy] do
      resources :role_assignments, only: [:create] do
        collection do
          delete ':role_name', action: 'destroy', as: 'role_assignment'
        end
      end
    end
  end

  namespace :door do
    resource :status, only: [:show, :update]
    resources :status_notifications, only: [:create]
  end

  namespace :lights do
    resource :status, only: [:show] do
      member do
        resource :policy, only: [:update]
      end
    end
  end

  devise_for :users, controllers: {registrations: 'registrations'}
  get "users/present"
  get "users/present_embeddable"
  root "users#present"
end
