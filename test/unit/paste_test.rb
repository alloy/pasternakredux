require File.expand_path('../../test_helper', __FILE__)

describe "Paste" do
  it "should return the code with syntax highlighting applied" do
    code = pastes(:long_ruby_code).syntax_highlight('ruby')
    code.should.match /^<pre class="twilight">.+<\/pre>$/m
    code.should.match /class.+Foo.+def.+foo.+foo.+end.+end/m
  end
  
  it "should be able to return only a few lines with syntax highlighting" do
    code = pastes(:long_ruby_code).syntax_highlight('ruby', 2)
    code.should.not.match /class.+Foo.+def.+foo.+foo/m
    code.should.match /class.+Foo.+def.+foo/m
  end
end
