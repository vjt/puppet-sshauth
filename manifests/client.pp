# sshauth::client
#
# Install generated key pairs onto clients

define sshauth::client ($ensure="", $filename="", $group="", $home="", $user="") {
	# Realize the virtual client keys.
	# Override the defaults set in sshauth::key, as needed.
	if $ensure { 
		Sshauth::Key::Client <| title == $title |> { 
			ensure => $ensure 
		}
	}

	if $filename {
		Sshauth::Key::Client <| title == $title |> {
			filename => $filename
		}
	}

	if $group {
		Sshauth::Key::Client <| title == $title |> {
			group => $group
		}
	}

	if $user {
		Sshauth::Key::Client <| title == $title |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Sshauth::Key::Client <| title == $title |> {
			home => $home
		}
	}                       

	Sshauth::Key::Client <<| title == $title |>>
}
