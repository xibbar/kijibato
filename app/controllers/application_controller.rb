class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def authenticate
    authenticate_or_request_with_http_basic('Enter Password') do |u, p|
      u == 'admin' && Digest::MD5.hexdigest(p) == "d32452cb867fafec6179158051e9c980" 
    end
  end
end
