require "test_helper"

class Lslinks::FormatterTest < Lslinks::TestCase
  sub_test_case(".output") do
    data(
      "full URL" => "http://full-url.example.org/path/",
      "implicit protocol" => "//implicit-protocol.example.org/path/",
      "implicit domain name" => "/implicit/domain/name.html",
      "sub-resources" => "sub/resources",
      "going back in the directory tree" => "../back.html",
    )
    test("output link url") do |url|
      stdout = StringIO.new
      Lslinks::Formatter.output(
        "https://example.org/base/url",
        Lslinks::Link.new(url:, text: "link text"),
        stdout:,
      )
      assert_equal("#{url}\n", stdout.string)
    end

    data(
      "full URL" => "http://full-url.example.org/path/",
      "implicit protocol" => "//implicit-protocol.example.org/path/",
      "implicit domain name" => "/implicit/domain/name.html",
      "sub-resources" => "sub/resources",
      "going back in the directory tree" => "../back.html",
    )
    test("output link url and text if :list_mode is true") do |url|
      stdout = StringIO.new
      Lslinks::Formatter.output(
        "https://example.org/base/url",
        Lslinks::Link.new(url:, text: "\t   multi line\nlink text\n  many space\ttext"),
        stdout:,
        list_mode: true,
      )
      assert_equal("#{url}\tmulti line link text many space text\n", stdout.string)
    end

    data(
      "full URL" => [
        "http://full-url.example.org/path/",
        "http://full-url.example.org/path/",
      ],
      "implicit protocol" => [
        "//implicit-protocol.example.org/path/",
        "https://implicit-protocol.example.org/path/",
      ],
      "implicit domain name" => [
        "/implicit/domain/name.html",
        "https://example.org/implicit/domain/name.html",
      ],
      "sub-resources" => [
        "sub/resources",
        "https://example.org/base/sub/resources",
      ],
      "going back in the directory tree" => [
        "../back.html",
        "https://example.org/back.html",
      ],
    )
    test("output full link url if :convert_links is true") do |test_pattern|
      url, converted_url = *test_pattern
      stdout = StringIO.new
      Lslinks::Formatter.output(
        "https://example.org/base/url",
        Lslinks::Link.new(url:, text: "link text"),
        stdout:,
        convert_links: true,
      )
      assert_equal("#{converted_url}\n", stdout.string)
    end

    test("output full link from :base if :convert_links is true") do
      stdout = StringIO.new
      Lslinks::Formatter.output(
        "-", # stdin
        Lslinks::Link.new(url: "sub/resources", text: "link text"),
        stdout:,
        convert_links: true,
        base: "https://example.org/base/url",
      )
      assert_equal("https://example.org/base/sub/resources\n", stdout.string)
    end
  end
end
