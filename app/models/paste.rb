class Paste < ActiveRecord::Base
  def syntax_highlight(language, lines = nil)
    Uv.parse((lines.nil? ? code : code.split("\n").first(lines).join("\n")), "xhtml", language, true, 'twilight')
  end
end
