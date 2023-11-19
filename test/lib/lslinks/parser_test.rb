require "test_helper"

class Lslinks::ParserTest < Lslinks::TestCase
  sub_test_case(".each_link") do
    test("call block with parsed links arg") do
      html_path = TEST_DATA_PATH / "various_urls.html"
      html_path.open do |f|
        assert_equal(
          [
            Lslinks::Link.new(url: "http://full-url.example.org/path/", text: "full URL"),
            Lslinks::Link.new(url: "//implicit-protocol.example.org/path/", text: "implicit protocol"),
            Lslinks::Link.new(url: "/implicit/domain/name.html", text: "implicit domain name"),
            Lslinks::Link.new(url: "sub/resources", text: "sub-resources"),
            Lslinks::Link.new(url: "../back.html", text: "going back in the directory tree"),
          ],
          Lslinks::Parser.to_enum(:each_link, f).to_a,
        )
      end
    end
  end
end
