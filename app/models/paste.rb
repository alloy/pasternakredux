class Paste < ActiveRecord::Base
  belongs_to :language
  
  def syntax_highlight(lines = nil)
    Uv.parse(
      lines.nil? ? code : code.split("\n").first(lines).join("\n"),
      "xhtml",
      language.name,
      true,
      'twilight'
    ) #.sub(/^<pre class="twilight"/, '<pre class="highlighted_code"')
  end
  
  private
  
  validates_presence_of :language_id
end
