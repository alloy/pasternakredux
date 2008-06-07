require File.expand_path('../../test_helper', __FILE__)

describe "Paste" do
  it "should have a language associated" do
    Paste.new(:code => 'bla', :language => nil).should.not.be.valid
    pastes(:long_ruby_code).language.name.should == 'ruby'
  end
  
  it "should call the ultraviolet parser with the correct language" do
    paste = pastes(:long_ruby_code)
    Uv.expects(:parse).with(paste.code, 'xhtml', 'ruby', true, 'twilight')
    paste.syntax_highlight
  end
  
  it "should return the code with syntax highlighting applied" do
    code = pastes(:long_ruby_code).syntax_highlight
    code.should.match /^<pre class="twilight">.+<\/pre>$/m
    code.should.match /class.+Foo.+def.+foo.+foo.+end.+end/m
  end
  
  it "should be able to return only a few lines with syntax highlighting" do
    code = pastes(:long_ruby_code).syntax_highlight(2)
    puts code
    code.should.not.match /class.+Foo.+def.+foo.+foo/m
    code.should.match /class.+Foo.+def.+foo/m
  end
  
  xit "should remove any unnecessary indentation before saving" do
    
  end
end
