# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :uv do
  def uv_dir
    if @uv_dir.nil?
      env = YAML.load(`gem environment`)["RubyGems Environment"]
      gem_paths = env.find { |pair| !pair["GEM PATHS"].nil? }["GEM PATHS"]
      gem_paths.each do |dir|
        matches = Dir.glob(File.join(dir, 'gems', 'ultraviolet*')).sort
        unless matches.empty?
          @uv_dir = matches.last
          break
        end
      end
    end
    @uv_dir
  end

  def languages_config
    @languages_config ||= File.join(RAILS_ROOT, 'config', 'pasternak_languages.yml')
  end

  desc "Copy the ultraviolet stylesheets to public and process them so the selectors get changed appropriately"
  task :copy_themes => :environment do
    css_dir = File.join(RAILS_ROOT, 'public', 'stylesheets', 'themes')
    mkdir_p css_dir
    
    Dir.glob(File.join(uv_dir, 'render', 'xhtml', 'files', 'css', '*.css')).each do |file|
      basename = File.basename(file)
      File.open(File.join(css_dir, basename), 'w') { |f| f << File.read(file).gsub(/#{basename[0..-5]}/, 'highlighted_code') }
    end
  end

  desc "Create a pasternak_languages.yml file in #{languages_config} which can be used to load languages into the db"
  task :create_languages_config => :environment do
    if File.exist? languages_config
      puts "#{languages_config} already exists."
      exit 1
    end
    
    languages = Dir.glob(File.join(uv_dir, 'syntax', '*')).map { |f| File.basename(f)[0..-8] }
    File.open(languages_config, 'w') { |f| f << { 'Languages' => languages }.to_yaml }
    puts "Edit #{languages_config} and run: $ rake uv:add_languages_to_db"
  end

  desc "Delete all languages and add the languages defined in #{languages_config} to the db"
  task :add_languages_to_db => :environment do
    unless File.exist? languages_config
      puts "#{languages_config} doesn't exist, first run: $ rake uv:create_languages_config"
      exit 1
    end
    
    languages = YAML.load(File.read(languages_config))['Languages']
    Language.transaction do
      Language.destroy_all
      languages.each { |lang| Language.create :name => lang }
      puts "Loaded #{Language.count} languages into the db."
    end
  end
end