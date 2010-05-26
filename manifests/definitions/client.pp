# ssh::auth::client
#
# Install generated key pairs onto clients

define ssh::auth::client ($ensure = "", $filename = "", $group = "", $home = "", $user = "") {
	# Realize the virtual client keys.
	# Override the defaults set in ssh::auth::key, as needed.
	if $ensure { 
		Ssh_auth_key_client <| title == $title |> { 
			ensure => $ensure 
		}
	}

	if $filename {
		Ssh_auth_key_client <| title == $title |> {
			filename => $filename
		}
	}

	if $group {
		Ssh_auth_key_client <| title == $title |> {
			group => $group
		}
	}

	if $user {
		Ssh_auth_key_client <| title == $title |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Ssh_auth_key_client <| title == $title |> {
			home => $home
		}
	}                       

	realize Ssh_auth_key_client[$title]
}
