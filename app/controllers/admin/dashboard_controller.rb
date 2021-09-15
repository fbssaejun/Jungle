class Admin::DashboardController < ApplicationController
  def show
    @num_product = Product.count
    @num_categories = Category.count
  end
end
