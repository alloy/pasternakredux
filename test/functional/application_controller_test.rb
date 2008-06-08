require File.expand_path('../../test_helper', __FILE__)

class TestApplicationController < ApplicationController
  allow_access :authenticated
  
  def index
    render :nothing => true
  end
end
ActionController::Routing::Routes.add_route('/test_application_controller', :controller => 'test_application', :action => 'index')

describe "ApplicationController" do
  tests TestApplicationController
  
  it "should set the @authenticated variable if a session[:authenticated] exists" do
    get :index, {}, { :authenticated => users(:eloy).id }
    status.should.be :success
    assigns(:authenticated).should == users(:eloy)
  end
end
