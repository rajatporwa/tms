Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'houses#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get "dashboard/owner", to: "dashboard#owner", as: :dashboard_owner

  resources :houses do
    resources :expenses, only: [:new, :create, :index, :destroy]
    resources :house_rooms do
      resources :tenants do
        member do
          patch :vacate
        end
        resources :rents do
          resources :payments
        end
        resources :tenant_partners, only: [:new, :create]
        resources :payments, except: [:show, :edit, :update], controller: "tenant_payments"
        resources :monthly_bills do
          resources :utility_bills
          resources :payments, controller: "monthly_bill_payments"
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
