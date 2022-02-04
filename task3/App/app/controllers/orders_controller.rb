require 'open-uri'
require 'json'
include ActiveJob::TestHelper

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    case params[:sort]
    when '1'
      @orders=current_user.orders.all.order("created_at ASC").page params[:page]
    when '2'
      @orders=current_user.orders.all.order("created_at DESC").page params[:page]
    when '3'
      @orders=current_user.orders.all.order("price ASC").page params[:page]
    when '4'
      @orders=current_user.orders.all.order("price DESC").page params[:page]
    when '5'
      @orders=current_user.orders.all.order("distance ASC").page params[:page]
    when '6' 
      @orders=current_user.orders.all.order("distance DESC") .page params[:page]
    else
      @orders=current_user.orders.all.page params[:page]
    end
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new order_params

  	response = cargo_parameters(@order)
    
    case response[:status]
    when 'NOT_FOUND'
      flash[:notice] = "Origin and/or destination of this pairing could not be geocoded"
      render :new
    when 'ZERO_RESULTS'
      flash[:notice] = "No route could be found between the origin and destination"
      render :new
    when 'MAX_ROUTE_LENGTH_EXCEEDED'
      flash[:notice] = "The requested route is too long and cannot be processed"
      render :new
    else
      @order.price = response[:price]
      @order.origin_location = response[:origin_location]
      @order.destination_location = response[:destination_location]
    
      puts "STATUS: #{response[:status]}"
  	  @user = User.find_by id: @order.user_id

  	  if @order.save
        flash[:created] = @order.id
        OrderStatusMailer.with(user: @user, order: @order).order_status.deliver_later
  	    redirect_to new_order_path
  	  else
  	    render :new
  	  end
    end
  end

  def show
    @order = Order.find_by id: params[:id]
    if current_user.id == @order.user_id
      @order
    else
      redirect_to new_order_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:weight, :length, :width, :height, :origin_location, :destination_location).merge(user_id: current_user.id)
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
      return {origin: origin, destination: destination, distance: 0, status: status}
    end
    
    status = result["rows"].first["elements"].first["status"]

    puts status

    if status != "OK"
      return {origin: origin, destination: destination, distance: 0, status: status}
    end
    
    origin = result["origin_addresses"]
    destination = result["destination_addresses"]
    distance = result["rows"].first["elements"].first["distance"]["text"]
    distance = distance.chomp(" km").to_f

    {origin: origin, destination: destination, distance: distance, status: status}
  end

  def cargo_parameters(order)
    if order.origin_location.nil? 
      order.origin_location = ""
    end
    
    if order.length.nil? || order.width.nil? || order.height.nil? || order.weight.nil? 
      order.height = 0
      order.length = 0
      order.width = 0
      order.weight = 0
    end

    if order.destination_location.nil? 
      order.destination_location = ""
    end

    volume = order.length * order.width * order.height

    price_per_km = 
      if volume <= 100
        1
      elsif volume > 100 && order.weight <= 10
        2
      else
        3
      end
    
    response = distancematrix(order.origin_location, order.destination_location)

    order.distance = response[:distance]
    order.origin_location = response[:origin]
    order.destination_location = response[:destination]

    order.price = (order.distance * price_per_km).round(2)
    
    {weight: order.weight, length: order.length, width: order.width, height: order.height, distance: order.distance, price: order.price,
     origin_location: response[:origin], destination_location: response[:destination], status: response[:status]}
  end
end