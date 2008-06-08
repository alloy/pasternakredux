require File.expand_path('../../test_helper', __FILE__)

describe "User" do
  it "should digest the password before saving" do
    user = User.create :username => 'Dionne', :password => 'secret'
    user.password.should.not == 'secret'
    user.password.should.not.be.blank
  end
  
  it "should authenticate" do
    User.authenticate('alloy', 'secret').should == users(:eloy)
    User.authenticate('alloy', 'notsecret').should.be nil
    User.authenticate('', 'secret').should.be nil
    User.authenticate('alloy', '').should.be nil
  end
end
