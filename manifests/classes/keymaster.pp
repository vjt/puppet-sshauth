# ssh::auth::keymaster
#
# Keymaster host:
# Create key storage; create, regenerate, and remove key pairs

class ssh::auth::keymaster {
	# Set up key storage
	file { $ssh::auth::keymaster_storage:
		ensure => directory,
		owner  => puppet,
		group  => puppet,
		mode   => 644,
	}

	# Realize all virtual master keys
	Ssh_auth_key_master <| |>

}
