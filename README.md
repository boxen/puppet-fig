# Fig Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-fig.svg)](https://travis-ci.org/boxen/puppet-fig)

Installs [Fig](http://www.fig.sh), fast and isolated development environments
using [Docker](https://www.docker.io/).

## Usage

```puppet
include fig
```

This module supports data bindings via hiera. See the parameters to the fig class
for overridable values.

## Updating the fig version

The fig version is something you should be managing in your own boxen repository,
rather than depending on this module to update for you. You can update fig by
overriding the version value with Hiera:

``` yaml
fig::version: '1.0.0'
```

You can find a list of releases for fig [here](https://github.com/docker/fig/releases).

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
