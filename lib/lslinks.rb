require "open-uri"
require "optparse"
require "pathname"
require "uri"

require "nokogiri"

module Lslinks
  VERSION = "0.1.1"

  class << self
    def debug?
      return "1" == ENV["LSLINKS_DEBUG"]
    end
  end
end

(Pathname(__dir__).glob("**/*.rb") - [Pathname(__FILE__)]).map { |path|
  path.sub_ext("")
}.sort.each do |path|
  require(path.relative_path_from(__dir__))
end
