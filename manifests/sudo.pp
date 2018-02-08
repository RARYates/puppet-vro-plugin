# puppet_vro_plugin::sudo
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppet_vro_plugin::sudo
class puppet_vro_plugin::sudo {

  file { '/etc/sudoers.d/vro-plugin-user':
    ensure  => file,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    content => epp('vro_plugin_user/vro_sudoer_file.epp'),
  }
}
