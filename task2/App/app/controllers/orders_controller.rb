require 'open-uri'
require 'json'

class OrdersController < ApplicationController
  def index
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new order_params
  	response = cargo_parameters
    @order.distance = response[:distance]
    @order.price = response[:price]
  	
  	if @order.distance == 0
  	  render :new
  	elsif @order.save
      flash[:alert] = @order.id
  	  redirect_to new_order_path
  	else
  	  render :new
  	end
  end

  def show
    @order = Order.find_by id: params[:id]
  end

  private

  def order_params
    params.require(:order).permit(:last_name, :first_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :origin_location, :destination_location)
  end

  def distancematrix(origin, destination) 
    url = URI.parse(
          "https://api.distancematrix.ai/maps/api/distancematrix/json?origins=" \
          "#{origin}&destinations=#{destination}&key=uEzyWl4iTN6UQp8yDyly67vOae8Z1"
      )
  
    response = open(url).read
    result = JSON.parse(response)
    
    puts "RESULT: #{result}"

    status = result["status"]
    
    puts status

    if status != "OK"
      return 0
    end
    
    status = result["rows"].first["elements"].first["status"]

    puts status

    if status != "OK"
      return 0
    end

    distance = result["rows"].first["elements"].first["distance"]["text"]

    distance = distance.chomp(" km")

    distance.to_f
  end

  def cargo_parameters
    if @order.origin_location.nil? 
      @order.origin_location = ""
    end
    
    if @order.destination_location.nil? 
      @order.destination_location = ""
    end

    volume = @order.length * @order.width * @order.height

    price_per_km = 
      if volume <= 100
        1
      elsif volume > 100 && @order.weight <= 10
        2
      else
        3
      end
    
    @order.distance = distancematrix(@order.origin_location, @order.destination_location)
    @order.price = (@order.distance * price_per_km).round(2)

    {weight: @order.weight, length: @order.length, width: @order.width, height: @order.height, distance: @order.distance, price: @order.price}
  end
end