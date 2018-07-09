require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :'admin/users', ActiveAdmin::Devise.config
  # get 'admin/acas_searches/*id', as: :admin_acas_search_id, to: 'admin/acas_searches#show'
  # get 'admin/acas_searches', as: :admin_acas_search, to: 'admin/acas_searches#show'
  ActiveAdmin.routes(self)
  authenticate :admin_user, -> (u) { u.is_admin? || u.permission_names.include?('read_jobs') } do |u|
    mount Sidekiq::Web => '/admin/sidekiq'
  end
end
