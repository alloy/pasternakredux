require File.expand_path('../../test_helper', __FILE__)

describe "User" do
  before do
    @user = User.create :username => 'Eloy', :password => 'secret'
  end
  
  it "should digest the password before saving" do
    @user.password.should.not == 'secret'
    @user.password.should.not.be.blank
  end
  
  it "should authenticate" do
    User.authenticate('Eloy', 'secret').should == @user
    User.authenticate('Eloy', 'notsecret').should.be nil
    User.authenticate('', 'secret').should.be nil
    User.authenticate('Eloy', '').should.be nil
  end
end
