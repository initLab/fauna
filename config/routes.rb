Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: "oauth/applications"
  end

  resource :user, only: [] do
    resources :network_devices
  end

  authenticated do
    devise_scope :user do
      get "users/edit" => "devise/registrations#edit", :as => :user_root
    end
  end

  namespace :fauna do
    resources :users, only: [:index, :edit, :update, :show, :destroy] do
      resources :role_assignments, only: [:create] do
        collection do
          delete ":role_name", action: "destroy", as: "role_assignment"
        end
      end
    end
  end

  resources :doors, only: [:index] do
    post :open
    post :lock
    post :unlock
  end

  namespace :api, defaults: {format: "json"} do
    resources :users, only: [] do
      collection do
        get "present"
      end
    end

    resource :current_user, only: :show

    resources :doors, only: [:index] do
      post :open
      post :lock
      post :unlock
    end
  end

  get "spaceapi/status", to: "space_api#status"
  get "spaceapi/oauth_status", to: "space_api#oauth_status"

  get "manifest", to: "web_app_manifest#manifest"

  devise_for :users, controllers: {registrations: "registrations"}
  get "dashboard/index"
  get "users/present"
  get "users/present_embeddable"
  root "dashboard#index"

  resources :sensors, only: [:index]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
