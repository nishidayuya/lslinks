module Lslinks::Reader::Http
  class << self
    DEFAULT_HTTP_HEADERS = {
      "User-Agent" => "Ruby/#{RUBY_VERSION} lslinks/#{Lslinks::VERSION}",
    }

    def open(resource_name, **options, &block)
      begin
        uri = URI(resource_name)
      rescue URI::InvalidURIError
        raise Lslinks::Error::UnsupportedResource
      end
      raise Lslinks::Error::UnsupportedResource if !uri.is_a?(URI::HTTP)

      http_headers = DEFAULT_HTTP_HEADERS.merge(options[:http_headers])
      return uri.open(http_headers, &block)
    end
  end
end
