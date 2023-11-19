module Lslinks::Parser
  class << self
    def each_link(resource_stream, **)
      document = Nokogiri::HTML(resource_stream.read) # TODO: to stream reading
      document.css("a[href]").each do |element|
        link = Lslinks::Link.from_nokogiri_element(element)
        yield(link)
      end
    end
  end
end
