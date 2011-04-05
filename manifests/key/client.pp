# sshauth::key::client
#
# Install a key pair into a user's account.
# This definition is private, i.e. it is not intended to be called directly by users.

define sshauth::key::client ($ensure, $filename, $group, $home, $user, $managed) {
	include sshauth::params
	
	# Introduce dependencies on the user and home directory only if we are managed
	if $managed {
		File {
			owner   => $user,
			group   => $group,
			mode    => 600,
			require => [ User[$user], File[$home] ]
		}
	}

	$key_src_file        = "${sshauth::params::keymaster_storage}/${name}/key" # on the keymaster
	$key_tgt_file        = "${home}/.ssh/${filename}" # on the client
	$key_src_content_pub = file("${key_src_file}.pub", '/dev/null')
	
	if ( $ensure == 'absent' or $key_src_content_pub =~ /^(ssh-...) ([^ ]+)/ ) {
		$keytype = $1
		$modulus = $2
		file { $key_tgt_file:
				ensure  => $ensure,
				content => file($key_src_file, '/dev/null')
		}
		
		file { "${key_tgt_file}.pub":
			ensure  => $ensure,
			content => "${keytype} ${modulus} ${name}\n",
			mode    => 644
		}
	} else {
		notify { "Private key file ${key_src_file} for key ${name} not found on keymaster; skipping ensure => present": }
	}
}
