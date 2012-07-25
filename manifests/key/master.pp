# sshauth::key::master
#
# Create/regenerate/remove a key pair on the keymaster.
# This definition is private, i.e. it is not intended to be called directly by users.
# ssh::auth::key calls it to create virtual keys, which are realized in ssh::auth::keymaster.

define sshauth::key::master ($ensure,
														 $force,
														 $keytype,
														 $length,
														 $maxdays,
														 $mindate) {
	include sshauth::params
	
	Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin' }
	
	File {
		owner => 'pe-puppet',
		group => 'pe-puppet',
		mode  => '0600',
	}

	$keydir  = "${sshauth::params::keymaster_storage}/${name}"
	$keyfile = "${keydir}/key"

	file { $keydir:
		ensure => directory,
		mode   => '0644',
	}
	
	file { $keyfile:
		ensure => $ensure,
	}
	
	file { "${keyfile}.pub":
		ensure => $ensure,
		mode   => '0644',
	}

	if $ensure == 'present' {
    # Remove the existing key pair, if
    # * $force is true, or
    # * $maxdays or $mindate criteria aren't met, or
    # * $keytype or $length have changed
		$keycontent = file("${keyfile}.pub", '/dev/null')
		if $keycontent {
			if $force {
        $reason = 'force=true'
			}
			
			if !$reason and $mindate and generate('/usr/bin/find', $keyfile, '!', '-newermt', "${mindate}") {
				$reason = "created before ${mindate}"
			}
			
			if !$reason and $maxdays and generate('/usr/bin/find', $keyfile, '-mtime', "+${maxdays}") {
				$reason = "older than ${maxdays} days"
			}
			
			if !$reason and $keycontent =~ /^ssh-... [^ ]+ (...) (\d+)$/ {
				if $keytype != $1 {
					$reason = "keytype changed: $1 -> ${keytype}"
				} else {
					if $length != $2 {
						$reason = "length changed: $2 -> ${length}"
					}
				}
			}
			
			if $reason {
				exec { "Revoke previous key ${name}: ${reason}":
					command => "rm ${keyfile} ${keyfile}.pub",
					before  => Exec["Create key ${name}: ${keytype}, ${length} bits"],
				}
			}
		}

		# Create the key pair.
		# We "repurpose" the comment field in public keys on the keymaster to
		# store data about the key, i.e. $keytype and $length.  This avoids
		# having to rerun ssh-keygen -l on every key at every run to determine
		# the key length.
		exec { "Create key ${name}: ${keytype}, ${length} bits":
			command => "ssh-keygen -t ${keytype} -b ${length} -f ${keyfile} -C \"${keytype} ${length}\" -N \"\"",
			user    => 'pe-puppet',
			group   => 'pe-puppet',
			creates => $keyfile,
			before  => [ File[$keyfile], File["${keyfile}.pub"] ],
			require => File[$keydir],
		}
	} # if $ensure  == "present"
}
