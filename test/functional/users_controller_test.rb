require File.expand_path('../../test_helper', __FILE__)

describe "UsersController" do
  tests UsersController
  
  it "should show a new page" do
    get :new
    status.should.be :success
    template.should.be 'new'
    assigns(:user).should.be.new_record
  end
  
  it "should create a user with valid params" do
    lambda {
      post :create, :username => 'd-ru', :password => 'secret'
    }.should.differ("User.count", +1)
    assigns(:user).username.should == 'd-ru'
    assigns(:user).password.should == Digest::SHA1.hexdigest('secret')
  end
end