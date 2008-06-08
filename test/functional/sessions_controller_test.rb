require File.expand_path('../../test_helper', __FILE__)

describe "SessionsController" do
  tests SessionsController
  
  it "should show a login page" do
    get :new
    status.should.be :success
    template.should.be 'new'
  end
  
  it "should create a session with valid user credentials" do
    post :create, :username => 'alloy', :password => 'secret'
    assigns(:authenticated).should == users(:eloy)
    session[:authenticated].should == users(:eloy).id
    should.redirect_to pastes_url
  end
  
  it "should not create a session without valid user credentials" do
    post :create, :username => 'alloy', :password => 'notsecret'
    assigns(:authenticated).should.be nil
    session[:authenticated].should.be nil
    template.should.be 'new'
  end
  
  it "should show errors if the credentials were wrong" do
    post :create, :username => 'alloy', :password => 'notsecret'
    user = assigns(:user)
    user.username.should == 'alloy'
    user.password.should.be.blank
    user.errors.on(:base).should == 'The username/password combination you entered is invalid.'
  end
end
