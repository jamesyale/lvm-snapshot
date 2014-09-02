class lvm-snapshot ($lv, $vg) {

	file { "/mnt/$lv-snapshot":
		ensure => directory
	}

	file { "/usr/sbin/lvm-snapshot.sh":
		ensure => present,
		source => 'puppet:///lvm-snapshot/lvm-snapshot.sh',
		mode => '700',
		owner => 'root',
		group => 'root',
	}

	Cron { 
		ensure => present,
		user => 'root',
		minute => '0',
	}

	cron { 'lvm-snapshot::create':
		hour => '0',
		command => "/usr/sbin/lvm-snapshot.sh create $vg $lv",
	}

	cron { 'lvm-snapshot::mount':
		hour => '0',
		minute => '1',
		command => "/usr/sbin/lvm-snapshot.sh mount $vg $lv",
	}

	cron { 'lvm-snapshot::umount':
		hour => '07',
		command => "/usr/sbin/lvm-snapshot.sh umount $vg $lv",
	}

	cron { 'lvm-snapshot::remove':
		hour => '07',
		minute => '1',
		command => "/usr/sbin/lvm-snapshot.sh remove $vg $lv",
	}

}
