require File.expand_path('../../test_helper', __FILE__)

describe "PastesController" do
  tests PastesController
  
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
end
