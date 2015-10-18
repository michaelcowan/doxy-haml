[![GitHub version](https://badge.fury.io/gh/michaelcowan%2Fdoxy-haml.svg)](http://badge.fury.io/gh/michaelcowan%2Fdoxy-haml)
[![Build Status](https://travis-ci.org/michaelcowan/doxy-haml.svg?branch=master)](https://travis-ci.org/michaelcowan/doxy-haml)
[![Coverage Status](https://coveralls.io/repos/michaelcowan/doxy-haml/badge.svg?branch=master&service=github)](https://coveralls.io/github/michaelcowan/doxy-haml?branch=master)

# doxy-haml
Ruby script to parse Doxygen XML and render it using HAML

## Prerequisites
### Ruby
[Ruby](https://www.ruby-lang.org) must be available on the command line.

Currently doxy-haml has only been tested on OSX using Ruby 2.1.0 installed via [rbenv](http://rbenv.org):
See [rbenv readme](https://github.com/sstephenson/rbenv#homebrew-on-mac-os-x) for details.

### Doxygen
The [doxygen](http://www.stack.nl/~dimitri/doxygen) command must be available on the command line.

Currently doxy-haml has only been tested on OSX using Doxygen 1.8.9.1 installed via [brew](http://brew.sh/):
```
brew update
brew install doxygen
```

## Quickstart
```
ruby doxy-haml --in /path/to/some/cpp/source --out /path/where/you/want/the/docs
```

### Just show me what it does!
To run doxy-haml against the included spec cpp source:

1.  Checkout the project
2.  Change to the project directory
3.  Install the dependancies ```bundle install``` (only need to do this once)
4.  Run ```ruby doxy-haml.rb --in spec/src```

The generated HTML will be in the ```doc/api``` folder
