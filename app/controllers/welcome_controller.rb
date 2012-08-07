class WelcomeController < ApplicationController
  def index
  end
  
  def order_beer    
      if(params[:address].length <= 0)  #No Address
        flash[:error] = "We can't bring you beer without an address.  GUH!"
        redirect_to :root
      else 
        if(params[:zip].length <= 0) #No Zip
          flash[:error] = "Unfortunately, " + params[:address] + " means nothing to me without a Zip Code"
          redirect_to :root
        else #Success!
          response = Geokit::Geocoders::GoogleGeocoder.geocode params[:zip]
          flash[:city] = response.city
          
          redirect_to :root
        end
    end
  end
end
