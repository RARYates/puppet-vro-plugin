# puppet_vro_plugin::user
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppet_vro_plugin::user
class puppet_vro_plugin::user (
  String $vro_plugin_user = 'vro-plugin-user',
  String $vro_password = 'puppetlabs',
  String $vro_password_hash = '$1$Fq9vkV1h$4oMRtIjjjAhi6XQVSH6.Y.', #puppetlabs
) {

  $ruby_mk_vro_plugin_user = epp('vro_plugin_user/create_user_role.rb.epp', {
    'username'    => $vro_plugin_user,
    'password'    => $vro_password,
    'rolename'    => 'VRO Plugin User',
    'touchfile'   => '/opt/puppetlabs/puppet/cache/vro_plugin_user_created',
    'permissions' => [
      { 'action'      => 'view_data',
        'instance'    => '*',
        'object_type' => 'nodes',
      },
    ],
  })

  exec { 'create vro user and role':
    command => "/opt/puppetlabs/puppet/bin/ruby -e ${shellquote($ruby_mk_vro_plugin_user)}",
    creates => '/opt/puppetlabs/puppet/cache/vro_plugin_user_created',
  }

##Create system user.

  user { $vro_plugin_user:
    ensure     => present,
    shell      => '/bin/bash',
    password   => $vro_password_hash,
    groups     => ['pe-puppet'],
    managehome => true,
  }

}
