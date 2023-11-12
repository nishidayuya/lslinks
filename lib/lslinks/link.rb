require "lslinks"

class Lslinks::Link < Data.define(:url, :text)
  class << self
    def from_nokogiri_element(element)
      return new(url: element.attr("href"), text: element.text)
    end
  end

  def uri = URI(url)
end
