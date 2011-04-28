# Class: sshauth
#
# This module manages sshauth
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class sshauth {
	Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin' }
	Notify { withpath => false }
}
