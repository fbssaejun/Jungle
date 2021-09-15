class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USER_NAME"], password: ENV["PASSWORD"]

  def show
    @num_product = Product.count
    @num_categories = Category.count
  end
end
