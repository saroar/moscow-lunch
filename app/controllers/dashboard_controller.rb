class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:week_day_menu]

  def home
  end

  def week_day_menu
    @first_day = Date.today.at_beginning_of_week
  end
end
