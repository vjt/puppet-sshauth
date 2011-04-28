# sshauth::server
#
# Install public keys onto clients

define sshauth::server ($ensure  = '',
												$group   = '',
												$home    = '',
												$options = '',
												$user    = '') {
	# Collect the exported server keys.
	# Override the defaults set in sshauth::key, as needed.
	
	# Sanitize user and home
	$_home = $home ? {
		''      => $user ? {
			''      => '',
			default => "/home/${user}",
		},
		default => $home,
	}
	
	if $ensure {
		Sshauth::Key::Server <| tag == $name |> {
			ensure => $ensure,
		}
	}
	
	if $group {
		Sshauth::Key::Server <| tag == $name |> {
			group => $group,
		}
	}
	
	if $options {
		Sshauth::Key::Server <| tag == $name |> {
			options => $options,
		}
	}

	if $user {
		Sshauth::Key::Server <| tag == $name |> {
			user => $user,
		}
	}

	if $_home {
		Sshauth::Key::Server <| tag == $name |> {
			home => $_home,
		}
	}                       

	Sshauth::Key::Server <<| tag == $name |>>
}
