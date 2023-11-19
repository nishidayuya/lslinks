require "test_helper"

class Lslinks::OptionParserTest < Lslinks::TestCase
  sub_test_case(".call") do
    data(
      "non special case" => [
        %w[-k],
        {http_headers: {}, convert_links: true},
      ],
      "only -l" => [
        %w[-l],
        {http_headers: {}, list_mode: true},
      ],
      "only --user-agent" => [
        ["--user-agent=user agent string"],
        {http_headers: {"User-Agent" => "user agent string"}},
      ],
      "only --referer" => [
        ["--referer=http://referer-test.example.org/"],
        {http_headers: {"Referer" => "http://referer-test.example.org/"}},
      ],
      "only --header" => [
        ["--header=Custom-Header-Key: a value"],
        {http_headers: {"Custom-Header-Key" => "a value"}},
      ],
      "override case" => [
        [
          "--header=User-Agent: user agent 1",
          "--header=Custom-Header-Key: custom header value",
          "--user-agent=user agent 2",
        ],
        {
          http_headers: {
            "Custom-Header-Key" => "custom header value",
            "User-Agent" => "user agent 2",
          },
        },
      ],
    )
    test("returns parsed options") do |test_pattern|
      resource_name = "http://dummy.example.org/"
      argv_options, expected_options = *test_pattern
      actual_options, actual_resource_name = *Lslinks::OptionParser.(argv_options + [resource_name])
      assert_equal(expected_options, actual_options)
      assert_equal(resource_name, actual_resource_name)
    end
  end
end
