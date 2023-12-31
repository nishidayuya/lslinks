# lslinks

[![License X11](https://img.shields.io/badge/license-X11-blue.svg)](https://raw.githubusercontent.com/nishidayuya/lslinks/master/LICENSE.txt)
[![Gem Version](https://badge.fury.io/rb/lslinks.svg)](https://rubygems.org/gems/lslinks)
[![Build Status](https://github.com/nishidayuya/lslinks/workflows/test/badge.svg)](https://github.com/nishidayuya/lslinks/actions?query=workflow%3Atest)

A command line tool to list links. ls-like.

## Installation

```console
$ gem install lslinks
```

## Usage

### list links

```console
$ lslinks https://www.ruby-lang.org/
/en/
```

### list links with text

```console
$ lslinks -l https://www.ruby-lang.org/
/en/	Click here
```

### list links as Full URL

```console
$ lslinks -k https://www.ruby-lang.org/
https://www.ruby-lang.org/en/
```

### more options

```console
$ lslinks --help
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nishidayuya/lslinks .
