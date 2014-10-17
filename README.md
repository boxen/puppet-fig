# Fig Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-fig.svg)](https://travis-ci.org/boxen/puppet-fig)

Installs [Fig](http://www.fig.sh), fast and isolated development environments using [Docker](https://www.docker.io/).

## Usage

```puppet
include fig
```

## Required Puppet Modules

* `boxen`
* `docker`
* `homebrew`
* `ripienaar/puppet-module-data`
* `stdlib`
* `virtualbox`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
