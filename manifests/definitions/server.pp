# ssh::auth::server
#
# Install public keys onto clients
define ssh::auth::server ($ensure = "", $group = "", $home = "", $options = "", $user = "") {
	# Realize the virtual server keys.
	# Override the defaults set in ssh::auth::key, as needed.
	if $ensure {
		Ssh_auth_key_server <| title == $title |> {
			ensure  => $ensure
		}
	}
	
	if $group {
		Ssh_auth_key_server <| title == $title |> {
			group => $group
		}
	}
	
	if $options {
		Ssh_auth_key_server <| title == $title |> {
			options => $options
		}
	}

	if $user {
		Ssh_auth_key_server <| title == $title |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Ssh_auth_key_server <| title == $title |> {
			home => $home
		}
	}                       

	realize Ssh_auth_key_server[$title]
}
