class EcommerceController < ApplicationController
  def index
    render json: { message: "Welcome to Ecommerce API" }
  end

  def buy
    render json: { message: "Create a new product" }
  end
end
