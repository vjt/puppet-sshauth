# sshauth::keymaster
#
# Keymaster host:
# Create key storage; create, regenerate, and remove key pairs
#
class sshauth::keymaster {
	include sshauth::params
	
	# Set up key storage
	file { $sshauth::params::keymaster_storage:
		ensure => directory,
		owner  => 'pe-puppet',
		group  => 'pe-puppet',
		mode   => '0755',
	}

	# Collect all exported master keys
	Sshauth::Key::Master <<| |>>
}
