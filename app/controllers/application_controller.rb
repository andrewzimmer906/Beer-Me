class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :meta_defaults
    private

   def meta_defaults
      @meta_title = "Deliver Beer To Me"
      @meta_keywords = "Beer, Alcohol, Delivery, Service, Delivery Service, Party, Boulder"
      @meta_description = "Don't drive! Order beer online and have it delivered to your front door in time to keep the party alive."
    end
end
