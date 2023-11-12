require "lslinks"

module Lslinks::Reader
  class << self
    def open(resource_name, **options, &block)
      READER_CLASSES.each do |reader_class|
        return reader_class.open(resource_name, **options, &block)
      rescue Lslinks::Error::UnsupportedResource
        # nop
      end
    end
  end

  require "lslinks/reader/file"
  require "lslinks/reader/http"
  require "lslinks/reader/stdin"
  READER_CLASSES = [
    Lslinks::Reader::Http,
    Lslinks::Reader::Stdin,
    Lslinks::Reader::File,
  ]
end
