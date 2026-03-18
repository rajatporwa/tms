Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "home#index"
  devise_for :users

  resources :houses do
    resources :house_rooms do
      resources :tenants do
        resources :rents do
          resources :payments
        end
        resources :tenant_partners, only: [:new, :create]
        resources :monthly_bills do
          resources :utility_bills
          resources :payments
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
