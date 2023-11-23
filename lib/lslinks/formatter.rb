module Lslinks::Formatter
  class << self
    def output(resource_name, link, stdout: $stdout, **options)
      link_uri = if options[:convert_links]
                   URI(options[:base] || resource_name) + link.url
                 else
                   link.uri
                 end

      output_record = [link_uri]
      output_record << squeeze_text(link.text) if options[:list_mode]

      stdout.puts(output_record.join("\t"))
    end

    private

    def squeeze_text(text) = text.gsub(/\s+/, " ").strip
  end
end
