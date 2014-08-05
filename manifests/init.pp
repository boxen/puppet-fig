# Public: Install Fig
#
# Examples
#
#   include fig

class fig(
  $ensure = undef,

  $executable = undef,
  $kernel = downcase($::kernel),
  $version = undef,
) {

  validate_re($ensure, '^(present|absent)$')
  validate_re($kernel, '^(darwin|linux)$')

  if $ensure == 'present' {
    $download_url = "https://github.com/orchardup/fig/releases/download/${version}/${kernel}"

    exec {
      'install-fig':
        command => "curl -L ${download_url} > ${executable}",
        user    => $::boxen_user,
        unless  => "test -x ${executable} && ${executable} --version | grep '\\b${version}\\b'",
        notify  => Exec['fix-fig-permissions'];

      'fix-fig-permissions':
        command     => "chmod a+x ${executable}",
        user        => 'root',
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
