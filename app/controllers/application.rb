class ApplicationController < ActionController::Base
  # helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '8a0a65fac0f1b3e639a6349069f9e45c'
  
  before_filter :find_authenticated, :block_access
  
  protected

  def find_authenticated
    @authenticated = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
  end

  # Access was forbidden to client requesting the resource. React to that appropriately. Note that this reply is very
  # bare bones and you might want to return more elaborate responses in a real application.
  def access_forbidden
    if @authenticated.nil?
      request_http_basic_authentication "Accounting"
    else
      head :forbidden
    end
  end
end
