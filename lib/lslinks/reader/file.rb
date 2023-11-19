module Lslinks::Reader::File
  class << self
    def open(resource_name, **, &block)
      return File.open(resource_name, &block)
    end
  end
end
