class WelcomeController < ApplicationController
  def index
  end
  
  def order_beer   
    if(params[:zip].length <= 0) #No Zip
      @js_error = "Unfortunately, " + params[:address] + " means nothing to me without a Zip Code"
    end

    if(params[:address].length <= 0)  #No Address
      @js_error = "We can't bring you beer without an address.  GUH!"
    end 
    
    if(params[:address].length > 0 && params[:zip].length > 0)
      @js_error = nil;
      response = Geokit::Geocoders::GoogleGeocoder.geocode params[:zip]
      @js_city = response.city
      session[:zip] = params[:zip]
      session[:city] = @js_city
    else
      @js_city = nil;
    end
  end
  
  def signup
  	g = Gibbon.new("50315026ceb67f8096a4a4357a36f0df-us4")
  	
  	merge_vars = {
  	          'ZIPCODE' => session[:zip],
  	 }
  	        
  	response = g.listSubscribe({:id => "d50fff0094", 
  	          :email_address => params[:email], 
  	          :merge_vars => merge_vars,
  	          :double_optin => false,
  	          :send_welcome => true})
  	if(response.is_a?(Hash))
  		puts "error present"
  		@js_email_error = response['error']
  		@js_email_success = nil
  	else
  	  @js_email_success = "You're signed up with the address: " + params[:email] + "!"
  	  @js_email_error = nil
  	end
  end
end
