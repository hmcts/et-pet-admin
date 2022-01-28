class StatusController < ApplicationController
  skip_before_action :show_maintenance_page
end
