# sshauth::client
#
# Install generated key pairs onto clients

define sshauth::client ($ensure="", $filename="", $group="", $home="", $user="") {
	# Collect the exported client keys.
	# Override the defaults set in sshauth::key, as needed.
	if $ensure { 
		Sshauth::Key::Client <| tag == $name |> { 
			ensure => $ensure 
		}
	}

	if $filename {
		Sshauth::Key::Client <| tag == $name |> {
			filename => $filename
		}
	}

	if $group {
		Sshauth::Key::Client <| tag == $name |> {
			group => $group
		}
	}

	if $user {
		Sshauth::Key::Client <| tag == $name |> {
			user => $user,
			home => "/home/$user"
		}
	}

	if $home {
		Sshauth::Key::Client <| tag == $name |> {
			home => $home
		}
	}                       

	Sshauth::Key::Client <<| tag == $name |>>
}
