require File.expand_path('../../test_helper', __FILE__)

describe "PastesController" do
  tests PastesController
  
  it "should show a new page" do
    get :new
    status.should.be :success
    assigns(:paste).should.be.instance_of Paste
  end
  
  it "should create a new paste with the correct token" do
    lambda {
      post :create, :paste => { :code => 'def foo; puts "foo"; end' }, :patch_style => 'monkeypatch'
    }.should.differ('Paste.count', +1)
    
    paste = assigns(:paste)
    paste.should.not.be.new_record
    should.redirect_to paste_url(paste)
  end
  
  it "should NOT create a new paste without the correct token" do
    lambda {
      post :create, :paste => { :code => 'def foo; puts "foo"; end' }, :patch_style => 'bla'
    }.should.not.differ('Paste.count')
    should.redirect_to new_paste_url
  end
  
  it "should NOT create a new paste without a token" do
    lambda {
      post :create, :paste => { :code => 'def foo; puts "foo"; end' }, :patch_style => nil
    }.should.not.differ('Paste.count')
    should.redirect_to new_paste_url
  end
  
  it "should show a paste" do
    paste = pastes(:short_ruby_code)
    get :show, :id => paste.id
    status.should.be :success
    assigns(:paste).should == paste
  end
end
