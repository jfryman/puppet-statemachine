class statemachine::backend::local::config(
  $settings = {
    'backend'  => 'local',
    'base_dir' => '/etc/statemachine/states'
  },
) {
  validate_hash($settings)

  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $settings['base_dir']:
    ensure => directory,
  }
  file { '/usr/local/bin/statemachine-list':
    content => template('statemachine/backend/local/statemachine-list'),
  }
  file { '/usr/local/bin/statemachine-show':
    content => template('statemachine/backend/local/statemachine-show'),
  }
  file { '/usr/local/bin/statemachine-set':
    content => template('statemachine/backend/local/statemachine-set'),
  }
  file { '/usr/local/bin/statemachine-generate':
    content => template('statemachine/backend/local/statemachine-generate'),
  }
}
