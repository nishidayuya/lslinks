require "open-uri"
require "optparse"
require "pathname"
require "uri"

require "nokogiri"

module Lslinks
  class << self
    def debug?
      return "1" == ENV["LSLINKS_DEBUG"]
    end
  end
end

require "lslinks/version"
(Pathname(__dir__).glob("**/*.rb") - [Pathname(__FILE__)]).map { |path|
  path.sub_ext("")
}.sort.each do |path|
  require(path.relative_path_from(__dir__))
end
