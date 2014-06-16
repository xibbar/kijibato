require 'uri'
module ArticlesHelper
  def string_to_link(html_string)
    URI.extract(html_string).uniq.each do |url|
      html_string.gsub!(/(#{url}$|#{url}[^a-zA-z0-9_\/])/){|s| "<a href='#{url}' target='_blank'>#{url}</a>"}
    end
    html_string
  end
end
