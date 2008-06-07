class String
  def unindent
    dup.unindent!
  end
  def unindent!
    if m = match(/^(\n*)(\s*)/) or m = match(/([^\n]+)\n(\s*)/)
      spaces = m[2].length
      gsub!(/(^|\n)\s{#{spaces}}/, "\n").strip!
    end
    self
  end
end

if __FILE__ == $0
  require 'test/unit'
  
  class TestUnindent < Test::Unit::TestCase
    def test_result
      assert_conversions([
        # ["\n  word\n  word", "\nword\nword"],
        # ["\n  word\n   word", "\nword\n word"],
        # ["\n word\n  word", "\nword\n word"],
        # ["word\n  word\n  word", "word\nword\nword"],
        ["  word\n    word\n  word", "word\n  word\nword"] # Eloy: I wanted this behaviour...
      ])
    end
    
    private
    
    def assert_conversions(conversion)
      conversion.each do |from, to|
        assert_equal to, from.unindent
      end
    end
  end
end