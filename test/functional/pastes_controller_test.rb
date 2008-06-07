require File.expand_path('../../test_helper', __FILE__)

describe "PastesController" do
  tests PastesController
  
  before do
    @paste = pastes(:short_ruby_code)
    @valid_params = { :code => 'def foo; puts "foo"; end', :language_id => languages(:ruby).id }
  end
  
  it "should show a new page" do
    get :new
    status.should.be :success
    assigns(:paste).should.be.instance_of Paste
  end
  
  it "should create a new paste with the correct token" do
    lambda {
      post :create, :paste => @valid_params, :patch_style => 'monkeypatch'
    }.should.differ('Paste.count', +1)
    
    paste = assigns(:paste)
    paste.should.not.be.new_record
    should.redirect_to paste_url(paste)
  end
  
  it "should NOT create a new paste without the correct token" do
    lambda {
      post :create, :paste => @valid_params, :patch_style => 'bla'
    }.should.not.differ('Paste.count')
    should.redirect_to new_paste_url
  end
  
  it "should NOT create a new paste without a token" do
    lambda {
      post :create, :paste => @valid_params, :patch_style => nil
    }.should.not.differ('Paste.count')
    should.redirect_to new_paste_url
  end
  
  it "should show a paste" do
    get :show, :id => @paste.id
    status.should.be :success
    assigns(:paste).should == @paste
  end
  
  it "should return the raw code of a paste" do
    get :show, :id => @paste.id, :format => 'txt'
    status.should.be :success
    response.body.should == @paste.code
  end
  
  it "should by default use the twilight theme" do
    get :show, :id => @paste.id
    assigns(:theme).should == 'twilight'
  end
  
  it "should show the given theme if one is specified" do
    get :show, :id => @paste.id, :theme => 'amy'
    assigns(:theme).should == 'amy'
  end
end
