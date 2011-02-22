# Class: sshauth::params
#
#
class sshauth::params {
	$keymaster_storage = $sshauth_keymaster_storage ? {
		""      => "/var/lib/keys",
		default => $sshauth_keymaster_storage
	}
}
