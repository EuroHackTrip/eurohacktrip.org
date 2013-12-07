EurohacktripOrg::Application.routes.draw do
  resources :images

  get "images/create"
  get "images/update"
  get "image/create"
  get "image/update"
  resources :pages

  resources :home_page_contents

  resources :events

  #resources :post_settings, except: :create
  resources :post_settings

  get 'tags/:tag', to: 'posts#index', as: :tag

  devise_for :admins

  resources :countries
  resources :cities
  resources :people

  resources :categories

  get "dashboard/index"
  get "home/index"

  resources :users

  #ping our eventbrite client:
  get 'eventbrite/:id' => 'events#pingeventbrite'

  resources :comments

  resources :posts do
    resources :comments
  end

  match "comment/:id" => "comments#approve", :as => "comment_approve", via: [:post]

  match "country/:id" => "countries#show_in_nav", :as => "country_show", via: [:post]

  match "post/:id" => "posts#publish", :as => "post_publish", via: [:post]

  match "admin/:id" => "users#toggle_admin", :as => "toggle_admin", via: [:post]

  root to: "home#index"

  mount Ckeditor::Engine => "/ckeditor"

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

  #citiez apis like a boss....
  get 'citiez/:id' => 'cities#single'
  get 'citiez/country/:id' => 'cities#byCountry'
  get 'citiez/post/:id' => 'cities#byPost'
  get 'citiez' => 'cities#all'
end
