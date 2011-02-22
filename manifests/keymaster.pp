# sshauth::keymaster
#
# Keymaster host:
# Create key storage; create, regenerate, and remove key pairs

class sshauth::keymaster {
	include sshauth::params
	
	# Set up key storage
	file { $sshauth::params::keymaster_storage:
		ensure => directory,
		owner  => puppet,
		group  => puppet,
		mode   => 644
	}

	# Realize all virtual master keys
	Sshauth::Key::Master <| |>
}
