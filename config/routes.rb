require 'sidekiq/web'
Rails.application.routes.draw do
  default_url_options :host => "https://freelance-a17100262.c9users.io" 
  post 'webhook' => 'home#webhook'
  
  resources :subcategories
  resources :categories
  resources :reservations
  resources :jobs,except: :index
  get 'jobs/express/:id', to: 'jobs#express',as: :express_job
  get 'jobs/payment/:id', to: 'jobs#payment',as: :payment_job
  post 'jobs/confirm_payment/:id', to: 'jobs#confirm_payment',as: :confirm_payment_job
  
  get 'reservations/express/:id', to: 'reservations#express',as: :express_reservation
  get 'reservations/payment/:id', to: 'reservations#payment',as: :payment_reservation
  post 'reservations/confirm_payment/:id', to: 'reservations#confirm_payment',as: :confirm_payment_reservation

  resources :variables
  get 'user_panel',to: 'user_panel#index', as: :user_panel
  get 'jobs_as_employer',to: 'user_panel#jobs_as_employer', as: :user_empjobs
  get 'jobs_as_worker',to: 'user_panel#jobs_as_worker', as: :user_workjobs
  get 'user_panel/payments', as: :user_payments
  get 'reservations_as_employer',to: 'user_panel#reservations_as_employer', as: :user_empreserves
  get 'reservations_as_worker',to: 'user_panel#reservations_as_worker', as: :user_workerreserves
  get 'notifications', to: 'user_panel#notifications', as: :user_notifications
  
  get 'admin_panel',to: 'admin_panel#index',as: :admin_panel
  get 'admin_panel/jobs',as: :admin_jobs
  get 'admin_panel/users',as: :admin_users
  get 'admin_panel/reservations', as: :admin_reservations
  get 'admin_panel/payments', as: :admin_payments
  get 'admin_panel/notifications', to: 'admin_panel#notifications', as: :admin_notifications
  devise_for :users,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html0
  root 'home#home'
  get '/jobs',to: 'home#jobs',as: :livejobs
  post '/jobs',to: 'home#jobs'
  get 'admin', to: 'home#admin', as: :admin
  get 'profiles/:id', to: 'home#profiles', as: :profiles
  resources :users do
    collection do
      get :complete_sign_up
      post :completed_sign_up
    end
  end
  
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount ChatEngine::Engine => "/messenger"
  # , path: '/users/profile'
  get "*path", to: redirect('/404.html')
end
