# sshauth::client
#
# Install generated key pairs onto clients

define sshauth::client ($ensure = '',
												$filename = '',
												$group = '',
												$home = '',
												$user= '') {
	# Collect the exported client keys.
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
		Sshauth::Key::Client <| tag == $name |> { 
			ensure => $ensure,
		}
	}

	if $filename {
		Sshauth::Key::Client <| tag == $name |> {
			filename => $filename,
		}
	}

	if $group {
		Sshauth::Key::Client <| tag == $name |> {
			group => $group,
		}
	}

	if $user {
		Sshauth::Key::Client <| tag == $name |> {
			user => $user,
		}
	}

	if $_home {
		Sshauth::Key::Client <| tag == $name |> {
			home => $_home,
		}
	}                       

	Sshauth::Key::Client <<| tag == $name |>>
}
