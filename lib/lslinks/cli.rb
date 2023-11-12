require "lslinks"

module Lslinks::Cli
  class << self
    def run(argv)
      options, resource_name = *Lslinks::OptionParser.(argv)
      Lslinks::Reader.open(resource_name, **options) do |resource_stream|
        Lslinks::Parser.each_link(resource_stream, **options) do |link|
          Lslinks::Formatter.output(resource_name, link, **options)
        end
      end
    rescue => e
      raise if Lslinks.debug?

      $stderr.puts(e.message)
    end
  end
end
