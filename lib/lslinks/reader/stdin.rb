require "lslinks"

module Lslinks::Reader::Stdin
  class << self
    def open(resource_name, stdin: $stdin, **, &block)
      raise Lslinks::Error::UnsupportedResource if "-" != resource_name

      return block.(stdin)
    end
  end
end
