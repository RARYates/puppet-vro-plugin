# puppet_vro_plugin
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppet_vro_plugin
class puppet_vro_plugin (
  Optional[String] $autosign_shared_secret,
  String           $plugin_password,
  Boolean          $manage_ssh                               = false,
  Boolean          $manage_sudo                              = false,
  Boolean          $manage_root_login                        = true,
  Boolean          $manage_password_authentication           = true,
  Boolean          $manage_challenge_response_authentication = true,
  Boolean          $permit_root_login                        = true,
  Boolean          $password_authentication                  = true,
  Boolean          $challenge_response_authentication        = false,
  String           $plugin_user                              = 'vro-plugin-user',
) {

  include puppet_vro_plugin::user

  if $autosign_shared_secret != nil {
    include puppet_vro_plugin::autosign_psk
  }

  if $manage_ssh == true {
    include puppet_vro_plugin::ssh
  }

  if $manage_sudo == true {
    include puppet_vro_plugin::sudo
  }

}
