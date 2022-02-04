require 'open-uri'
require 'json'

class Cargo
  def initialize
    puts cargo_parameters
  end

  def distancematrix(origin, destination) 
    url = URI.parse(
          "https://api.distancematrix.ai/maps/api/distancematrix/json?origins=" \
          "#{origin}&destinations=#{destination}&key=uEzyWl4iTN6UQp8yDyly67vOae8Z1"
      )
  
    response = open(url).read
    result = JSON.parse(response)

    status = result["status"]
    
    puts "status: #{status}"

    if status != "OK"
      return 0
    end
    
    distance = result["rows"].first["elements"].first["distance"]["text"]

    distance = distance.chomp(" km")

    distance.to_f
  end

  def cargo_parameters
    print "Enter weight(kg): "
    weight = gets.to_f
    print "Enter length(cm): "
    length = gets.to_f
    print "Enter width(cm): "
    width = gets.to_f
    print "Enter height(cm): "
    height = gets.to_f
    print "Enter origin location: "
    origin = gets

    if origin.nil? 
      origin = ""
    end

    origin.chomp

    print "Enter destination location: "
    destination = gets
    
    if destination.nil? 
      destination = ""
    end

    destination.chomp

    volume = length * width * height

    price_per_km = 
      if volume <= 100
        1
      elsif volume > 100 && weight <= 10
        2
      else
        3
      end
    
    distance = distancematrix(origin, destination)
    price = (distance * price_per_km).round(2)

    {weight: weight, length: length, width: width, height: height, distance: distance, price: price}
  end
end

cargo = Cargo.new