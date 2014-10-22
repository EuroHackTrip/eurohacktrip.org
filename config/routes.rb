EurohacktripOrg::Application.routes.draw do

  resources :stops

  resources :partners

  get "partnership" => 'home#partnership', as: :partnership
  get "partner" => 'home#partner' 

  root to: "home#index"
  get "home/index"

  get 'about' => "home#about"
  get 'team' => "home#team"
  get 'attendees' => "home#attendees"

  get 'concept', :to => redirect('assets/docs/Concept.pdf')
  get 'proposal', :to => redirect('assets/docs/Proposal.pdf')
  get 'content' => redirect('http://goo.gl/9X5RgM')
  get "budget" => redirect('http://goo.gl/C4Hwo6')
  get 'campaign' => redirect('https://onepercentclub.com/en/#!/projects/eurohacktrip-in-amsterdam')

  get ':id', to: "home#year", :constraints => { :id => /[0-9]+/ }

  #users api
  # get ':any/api' => 'application#api'
  get "dashboard/index"

  
  get 'users/api' => 'users#api'
  resources :users
  # resources :users, only: [:show, :index]
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register", :edit => "account/edit" }, :controllers => {:registrations => :registrations }

  resources :years

  resources :startups
    
  get "messages/create"
  resources :images

  get "images/create"
  get "images/update"
  get "image/create"
  get "image/update"


  #resources :post_settings, except: :create
  resources :post_settings

  get 'tags/:tag', to: 'posts#index', as: :tag
  
  resources :countries
  resources :cities

    # created_at:datetime updated_at:datetime event_link:string event_name:string event_venue:string event_id:integer city:references
  
  #ping our eventbrite client:
  get 'eventbrite/:id' => 'events#pingeventbrite'

  resources :comments

  resources :posts do
    resources :comments
  end

  # get "users/index"
  # get "users/show"

  match "comment/:id" => "comments#approve", :as => "comment_approve", via: [:post]

  match "country/:id" => "countries#show_in_nav", :as => "country_show", via: [:post]
  match "page/:id" => "pages#show_in_nav", :as => "page_show", via: [:post]

  match "post/:id" => "posts#publish", :as => "post_publish", via: [:post]

  match ":first_name-:last_name/posts" => "posts#post_by_author", :as => "post_by_author", via: [:get]
  
  # match ":first_name-:last_name" => "users#show", :as => "user", via: [:get]

  match "user/:id" => "users#toggle_admin", :as => "toggle_admin", via: [:post]
  match "user/:id/approve" => "users#approve", :as => "user_approve", via: [:post]
  match "user/:id/delete" => "users#delete", :as => "user_delete", via: [:delete]
  match 'users/:id/update' => 'users#update', :as => 'user_update', :via => :post
  match 'users/:id/edit' => 'users#edit', :as => 'user_edit', :via => :get

  match 'contact' => 'messages#create', :as => 'contact', :via => :post
  match '#contact' => 'messages#new', :as => 'new_contact', :via => :get

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


# rails g scaffold startup name:string logo:string city:string tagline:string description:text
#  rails g scaffold stops name:string description:text year:string dates:string link:string