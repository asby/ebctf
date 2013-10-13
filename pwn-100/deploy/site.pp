node "default" {
    file { "/tmp/level1.ssh.key":
	ensure => present,
	source => "puppet:///files/level1.ssh.key",
    }
}
