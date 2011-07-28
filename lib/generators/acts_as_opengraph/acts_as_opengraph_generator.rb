require 'rails/generators'

class ActsAsOpengraphGenerator < Rails::Generators::Base

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

	def create_config
		copy_file "config/facebook.yml", "config/facebook.yml"
	end

	def create_initializer
		copy_file "initializers/acts_as_opengraph.rb", "config/initializers/acts_as_opengraph.rb"
	end

end
