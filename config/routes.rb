require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root to: 'admin/dashboard#index'
  devise_for :'admin/users', ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :admin_user, -> (u) { u.is_admin? || u.permission_names.include?('read_jobs') } do |u|
    mount Sidekiq::Web => '/admin/sidekiq'
  end
  get '/health' => 'status#healthcheck', defaults: { format: 'json' }
  get '/health/readiness' => 'status#healthcheck', defaults: { format: 'json' }
  get '/health/liveness' => 'status#healthcheck', defaults: { format: 'json' }
end
