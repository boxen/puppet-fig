# Public: Install Fig
#
# Examples
#
#   include fig

class fig(
  $ensure = undef,

  $executable = undef,
  $user = undef,
  $version = undef,
) {

  validate_re($ensure, '^(present|absent)$')
  validate_re($::hardwaremodel, '^(x86_64)$')
  validate_re($::kernel, '^(Darwin|Linux)$')
  validate_string($executable, $user, $version)

  if $ensure == 'present' {
    $download_url = "https://github.com/docker/fig/releases/download/${version}"

    exec {
      'install-fig':
        command => "curl -L ${download_url}/fig-${::kernel}-${::hardwaremodel} > ${executable}",
        user    => $user,
        unless  => "test -x ${executable} && ${executable} --version | grep '\\b${version}\\b'",
        notify  => Exec['fix-fig-permissions'];

      'fix-fig-permissions':
        command     => "chmod a+x ${executable}",
        user        => $user,
        require     => Exec['install-fig'],
        refreshonly => true;
    }
  } else {
    file { $executable:
      ensure  => absent,
      recurse => true,
      force   => true,
    }
  }

}
