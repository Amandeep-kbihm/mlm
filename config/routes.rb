Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords' }

  namespace 'api', defaults: {format: :json}  do
    namespace 'v1' do
      get 'pages/index' => 'pages#index'

      # User Sessions
      #post 'users/login' => 'sessions#create'

      #   UsersController
      post 'users' => 'users#create'
      patch 'users' => 'users#update'
      get 'sponsors' => 'users#sponsors'
      get 'users/authenticate' => 'users#authenticate'
      post 'users/complete-profile' => 'users#complete_profile'

      #   LimitsController
      get 'limits' => 'limits#index'
      post 'limits/ppc' => 'limits#ppc'
      post 'limits/ppv' => 'limits#ppv'
      post 'limits/ppv2' => 'limits#ppv2'
      post 'limits/ppi' => 'limits#ppi'

      #   LevelController
      get 'levels/general' => 'levels#general'
      get 'levels/upline' => 'levels#upline'
      get 'levels/:level' => 'levels#show'
      get 'levels/get-first/:user_id' => 'levels#get_first_level'

      #   TransactionsController
      get 'transactions/unapproved' => 'transactions#unapproved'
      get 'transactions/approved' => 'transactions#approved'
      get 'transactions/pending' => 'transactions#pending'

      #   PaymentTransactionController
      post 'payment_transactions/paytm' => 'payment_transactions#transaction_by_paytm'
      post 'payment_transactions/bank' => 'payment_transactions#transaction_by_bank'
      post 'payment_transactions/recharge' => 'payment_transactions#transaction_by_recharge'
      get 'payment_transactions/operators' => 'payment_transactions#recharge_operators'

      #   SettingsController
      get 'settings' => 'settings#index'

      # ManualApp
      get 'manual-app' => 'manual_app#index'

      # Ads
      post 'user-actions' => 'user_actions#create'

      # Enquiries
      post 'enquiries' => 'enquiries#create'

      #WalletsController
      get 'wallets/balance'

      #NotificationsController
      get 'notifications' => 'notifications#index'

      #   TrackingsController
      get 'trackings/icubeswire' => 'trackings#icubeswire'
      get 'trackings/conversionx' => 'trackings#conversionx'
      get 'trackings/vcommission' => 'trackings#vcommission'

      #   OffersController
      get 'offers' => 'offers#index'

      #   DealsController
      get 'deals' => 'deals#index'

    end
  end

  namespace 'admin' do

    get '/' => 'dashboards#index', as: :admin_dashboard

    #UsersController
    get 'users' => 'users#index', as: :user_details
    get 'users/:id' => 'users#show', as: :show_user
    get 'users/:id/earnings' => 'users#earnings', as: :user_earnings
    delete 'users/:id' => 'users#delete', as: :user_delete
    patch 'users/:id' => 'users#change_status', as: :change_user_status
    get 'user-tree/:id' => 'users#user_tree', as: :users_tree
    get 'user-tree/:id/:level' => 'users#user_tree_level', as: :users_tree_level
    post 'users/:id/activate-boost' => 'users#activate_boost', as: :activate_boost
    get 'users/search' => 'users#search', as: :user_search
    get 'users/:id/edit' => 'users#edit', as: :edit_user
    patch 'users/:id/update' => 'users#update', as: :update_user
    post 'users/:id/reset-device' => 'users#reset_device', as: :reset_user_device

    #SettingController
    get 'settings' => 'settings#index', as: :setting_details
    post 'setting' => 'settings#update', as: :update_setting

    #ChangePassword
    get 'password' => 'passwords#index', as: :password_index
    get 'change/password/:id' => 'passwords#new', as: :password_form
    patch 'change/password/:id' => 'passwords#update', as: :update_password

    #TransactionsController
    get 'transactions/status/' => 'transactions#transaction_status', as: :transaction_status
    get 'transactions/show/' => 'transactions#show', as: :show_record
    get 'transactions/refund/:user_id' => 'transactions#refund', as: :refund_transaction
    get 'transactions/deduct/:user_id' => 'transactions#deduct', as: :deduct_transaction
    post 'transactions/refund/:user_id' => 'transactions#refund_post'
    post 'transactions/deduct/:user_id' => 'transactions#deduct_post'


    #ECPMController
    get 'ecpm' => 'ecpm#new', as: :ecpm_form
    post 'ecpm' => 'ecpm#create', as: :ecpm_record_create
    get 'ecpms' => 'ecpm#index', as: :ecpm_records
    delete 'ecpm/:id' => 'ecpm#delete', as: :delete_ecpm

    #PaymentTransactionsController
    get 'payment-transactions' => 'payment_transactions#payment_type', as: :payment_transaction
    get 'payment-transactions/show-all' => 'payment_transactions#show_all', as: :show_all_payment_type
    patch 'payment-transactions/:id' => 'payment_transactions#payment_approved', as: :approved_payment_transaction
    delete 'payment-transactions/:id' => 'payment_transactions#decline', as: :decline_payment_transaction
    get 'payment-transactions/transactions/:user_id' => 'payment_transactions#show_transactions', as: :show_transactions

    #EnquiriesController
    get 'enquiries' => 'enquiries#index', as: :enquiries
    patch 'enquiries/:id' => 'enquiries#update', as: :enquiry

    #NotificationsController
    get 'notifications/new' => 'notifications#new', as: :new_notification
    post 'notifications' => 'notifications#create', as: :notifications

    #   DealsController
    get 'deals' => 'deals#index', as: :deals
    post 'deals' => 'deals#create'
    get 'deals/new' => 'deals#new', as: :new_deal
    get 'deals/:id' => 'deals#show', as: :deal
    get 'deals/:id/edit' => 'deals#edit', as: :edit_deal
    patch 'deals/:id' => 'deals#update'
    delete 'deals/:id' => 'deals#destroy'

    #   OffersController
    get 'offers' => 'offers#index', as: :offers
    post 'offers' => 'offers#create'
    get 'offers/new' => 'offers#new', as: :new_offer
    get 'offers/:id' => 'offers#show', as: :offer
    patch 'offers/:id' => 'offers#update'
    get 'offers/:id/edit' => 'offers#edit', as: :edit_offer
    delete 'offers/:id' => 'offers#destroy'

     #   ConversionsController
     get 'conversions' => 'conversions#index', as: :conversions
     post 'conversions/:id/approve' => 'conversions#approve', as: :approve_conversion

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
