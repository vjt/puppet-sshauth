import "classes/*.pp"
import "definitions/*.pp"
import "definitions/private/*.pp"

# Class: sshauth
#
# This module manages ssh::auth
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh::auth {
	$keymaster_storage = "/var/lib/keys" 

	Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }
	Notify { withpath => false }
}
