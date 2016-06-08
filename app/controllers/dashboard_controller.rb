class DashboardController < ApplicationController
  def home
  end

  def week_day_menu
    @first_day = Date.today.at_beginning_of_week
  end
end
