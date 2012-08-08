class WelcomeController < ApplicationController
  def index
  end
  
  def order_beer   
    if(params[:zip].length <= 0) #No Zip
      @js_error = "Trouble's abrewin! " + params[:address] + " could be anywhere! How about adding that zipcode?"
    end

    if(params[:address].length <= 0)  #No Address
      @js_error = "Trouble's abrewin! We can't bring you beer without an address.  GUH!"
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
  		puts response
  		
  		case response['code']
		    when 502  
		      @js_email_error = "Have you been drinking? Because that doesn't look like a real email address."
		    when 214
		      @js_email_error = "I love that enthusiasm! You already signed up. Check your email for the confirmation."
		  else
		    @js_email_error = response['error']
	    end
	    
  		@js_email_success = nil
  	else
  	  @js_email_success = "You're in! The second a delightful draft delivery driver enters your area, we'll send you an email here " + params[:email] + "."
  	  @js_email_error = nil
  	end
  end
end
