module ApplicationHelper
  AVAILABLE_THEMES = Dir.glob(File.join(RAILS_ROOT, 'public', 'stylesheets', 'themes', '*.css')).map do |f|
    File.basename(f)[0..-5]
  end.map { |t| [t.gsub('_', ' '), t] }
  
  def themes_options
    options_for_select(AVAILABLE_THEMES, @theme)
  end
end
