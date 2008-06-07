class Paste < ActiveRecord::Base
  belongs_to :language
  
  before_save :unindent
  
  def syntax_highlight(lines = nil)
    Uv.parse(
      lines.nil? ? code : code.split("\n").first(lines).join("\n"),
      "xhtml",
      language.name,
      true,
      'twilight'
    ).try(:sub, /^<pre class="twilight"/, '<pre class="highlighted_code"')
  end
  
  private
  
  def unindent
    write_attribute :code, code.unindent
  end
  
  validates_presence_of :language_id
end
