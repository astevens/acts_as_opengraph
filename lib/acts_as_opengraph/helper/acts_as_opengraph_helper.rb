module ActsAsOpengraphHelper
  # Generates the opengraph meta tags for your views
  #
  # @param [Object, #opengraph_data] obj An instance of your ActiveRecord model that responds to opengraph_data
  # @return [String] A set of meta tags describing your graph object based on the {http://ogp.me/ opengraph protocol}
  # @raise [ArgumentError] When you pass an instance of an object that doesn't responds to opengraph_data (maybe you forgot to add acts_as_opengraph in your model)
  # @example
  #   opengraph_meta_tags_for(@movie)
  def opengraph_meta_tags_for(obj, options = {})
    raise(ArgumentError.new, "You need to call acts_as_opengraph on your #{obj.class} model") unless obj.respond_to?(:opengraph_data)


    tags = obj.opengraph_data.map do |att|
			if options.is_a?(Hash)
				key = att[:name].include?("og:") ? att[:name].split("og:")[1] : att[:name]
				if options.include?(key.to_sym)
					att[:value] = options.delete(key.to_sym)
				end
			end
      att_name = att[:name] == "og:site_name" ? att[:name] : att[:name].dasherize
      %(<meta property="#{att_name}" content="#{Rack::Utils.escape_html(att[:value])}"/>)
    end
		options.each do |key, value|
			tags.push( %(<meta property="og:#{key}" content="#{Rack::Utils.escape_html(value)}"/>))
		end
    tags = tags.join("\n")
    tags.respond_to?(:html_safe) ? tags.html_safe : tags
  end #opengraph_meta_tags_for
end #Module
