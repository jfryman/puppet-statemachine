class statemachine::config (
  $logger   = 'statemachine::logger::console',
  $backend  = 'statemachine::backend::local',
) {
  validate_string($logger, $backend)

  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/statemachine':
    ensure => directory,
  }
  file { '/etc/facter/facts.d/statemachine':
    source => 'puppet:///modules/statemachine/etc/facter/facts.d/statemachine', 
  }
  file { '/usr/local/bin/statemachine':
    source => 'puppet:///modules/statemachine/usr/local/bin/statemachine',
  }
}
