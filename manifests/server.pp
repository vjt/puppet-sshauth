# sshauth::server
#
# Install public keys onto clients
define sshauth::server ($ensure = "", $group = "", $home = "", $options = "", $user = "") {
	# Realize the virtual server keys.
	# Override the defaults set in sshauth::key, as needed.
	if $ensure {
		Sshauth::Key::Server <| title == $title |> {
			ensure  => $ensure
		}
	}
	
	if $group {
		Sshauth::Key::Server <| title == $title |> {
			group => $group
		}
	}
	
	if $options {
		Sshauth::Key::Server <| title == $title |> {
			options => $options
		}
	}

	if $user {
		Sshauth::Key::Server <| title == $title |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Sshauth::Key::Server <| title == $title |> {
			home => $home
		}
	}                       

	realize Sshauth::Key::Server[$title]
}
