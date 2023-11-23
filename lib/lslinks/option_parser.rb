class Lslinks::OptionParser < OptionParser
  class << self
    def call(argv)
      parser = new
      parser.banner = "Usage: #{File.basename(Process.argv0)} [OPTIONS] URI_or_path"
      parser.version = Lslinks::VERSION
      parser.separator("")
      parser.separator("Basic options:")
      parser.on("-l", "list links with text.") # from ls
      parser.on("-k", "--convert-links", "convert links to full URL.") # from wget
      parser.separator("")
      parser.separator("HTTP input options:")
      parser.on("--user-agent=USER-AGENT", "specify User-Agent header. same as '--user-agent=USER-AGENT'.") # from curl wget
      parser.on("--referer=REFERER", "specify Referer header. same as '--referer=REFERER'.") # from curl wget
      parser.on("-H", "--header=HEADER-LINE", "specify various headers in HTTP request. e.g.: --header='Accept-Language: ja'") # from curl wget
      parser.on("--compressed", "ignore. no effect.") # from curl
      options = {
        http_headers: {},
      }
      rest_args = parser.permute(argv, into: options)
      resource_name = rest_args.shift
      if !resource_name
        $stderr.puts(parser.help)
        exit(1)
      end
      return options, resource_name
    end
  end

  def order!(argv, into:, &nonopt)
    setter = ->(name, val) do
      symbolized_name = name.gsub("-", "_").to_sym
      case symbolized_name
      when :l
        into[:list_mode] = true
      when :user_agent
        into[:http_headers]["User-Agent"] = val
      when :referer
        into[:http_headers]["Referer"] = val
      when :header
        key, value = *val.split(/:\s*/, 2)
        into[:http_headers][key] = value
      else
        into[symbolized_name] = val
      end
    end
    parse_in_order(argv, setter, &nonopt)
  end
end
