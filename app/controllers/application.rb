class ApplicationController < ActionController::Base
  before_filter :find_authenticated, :block_access
  
  protected

  def find_authenticated
    if session[:authenticated]
      @authenticated = User.find_by_id(session[:authenticated])
    else
      @authenticated = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
    end
  end

  # Access was forbidden to client requesting the resource. React to that appropriately. Note that this reply is very
  # bare bones and you might want to return more elaborate responses in a real application.
  def access_forbidden
    # if @authenticated.nil?
    #   request_http_basic_authentication "Accounting"
    # else
    #   head :forbidden
    # end
    head :forbidden
  end
end
