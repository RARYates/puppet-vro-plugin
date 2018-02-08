# puppet_vro_plugin::user
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppet_vro_plugin::user
class puppet_vro_plugin::user (
  String $plugin_user   = $puppet_vro_plugin::plugin_user,
  String $password      = $puppet_vro_plugin::password,
) {

  $password_hash = pw_hash($password, 6)

  $ruby_mk_vro_plugin_user = epp('vro_plugin_user/create_user_role.rb.epp', {
    'username'    => $plugin_user,
    'password'    => $password,
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

  user { $plugin_user:
    ensure     => present,
    shell      => '/bin/bash',
    password   => $password_hash,
    groups     => ['pe-puppet'],
    managehome => true,
  }

}
