# puppet_vro_plugin::ssh
#
# Sets up sane default SSH settings for the vRO Plugin when none are provided.
# These settings should be somewhere else in a puppet codebase, but is available
# in case an organization is not currently managing SSH and needs to manage it
# on the Puppet Master specifically for the vRO plugin.
#
# @summary Sane Defaults for the vRO Plugin for Puppet Enterprise. Should be
# used only if SSH is not already managed by another profile or module.
#
# @example
#   include puppet_vro_plugin::ssh
class puppet_vro_plugin::ssh (
  $manage_root_login                        = $puppet_vro_plugin::manage_root_login,
  $manage_password_authentication           = $puppet_vro_plugin::manage_password_authentication,
  $manage_challenge_response_authentication = $puppet_vro_plugin::manage_challenge_response_authentication,
  $permit_root_login                        = $puppet_vro_plugin::permit_root_login,
  $password_authentication                  = $puppet_vro_plugin::password_authentication,
  $challenge_response_authentication        = $puppet_vro_plugin::challenge_response_authentication
) {

  if $manage_root_login == true {
    sshd_config { 'PermitRootLogin':
      ensure => present,
      value  => bool2str($permit_root_login, 'yes', 'no'),
    }
  }

  if $manage_password_authentication == true {
    sshd_config { 'PasswordAuthentication':
      ensure    => present,
      value     => bool2str($password_authentication, 'yes', 'no'),
    }
  }

  if $manage_challenge_response_authentication == true {
    sshd_config { 'ChallengeResponseAuthentication':
      ensure    => present,
      value     => bool2str($challenge_response_authentication, 'yes', 'no'),
    }
  }

}
