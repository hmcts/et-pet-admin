class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :show_maintenance_page

  private

  def show_maintenance_page(config = Rails.application.config)
    return if !config.maintenance_enabled || config.maintenance_allowed_ips.include?(request.remote_ip)

    render 'static_pages/maintenance', layout: false, status: :service_unavailable
  end
end
