# puppet_vro_plugin::autosign_psk
#
# This class places an autosign rule on the Puppet Master that accepts
# a Pre-Shared Key (PSK) password to allow the vRO plugin to sign
# certificate requests to the Puppet Master
#
# @summary Assigns a Pre-Shared Key style authentication method for
# autosigning Puppet Certificates
#
# @example
#   include puppet_vro_plugin::autosign_psk
class puppet_vro_plugin::autosign_psk (
  String $shared_secret = $puppet_vro_plugin::autosign_shared_secret,
) {

  file { '/etc/puppetlabs/puppet/autosign.rb' :
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0700',
    content => template('autosign_example/autosign.rb.erb'),
    notify  => Service['pe-puppetserver'],
  }

  ini_setting { 'autosign script setting':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'autosign',
    value   => '/etc/puppetlabs/puppet/autosign.rb',
    notify  => Service['pe-puppetserver'],
  }

}
