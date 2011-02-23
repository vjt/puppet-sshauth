# sshauth::server
#
# Install public keys onto clients

define sshauth::server ($ensure = "", $group = "", $home = "", $options = "", $user = "") {
	# Realize the virtual server keys.
	# Override the defaults set in sshauth::key, as needed.
	if $ensure {
		Sshauth::Key::Server <| tag == $name |> {
			ensure => $ensure
		}
	}
	
	if $group {
		Sshauth::Key::Server <| tag == $name |> {
			group => $group
		}
	}
	
	if $options {
		Sshauth::Key::Server <| tag == $name |> {
			options => $options
		}
	}

	if $user {
		Sshauth::Key::Server <| tag == $name |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Sshauth::Key::Server <| tag == $name |> {
			home => $home
		}
	}                       

	Sshauth::Key::Server <<| tag == $name |>>
}
