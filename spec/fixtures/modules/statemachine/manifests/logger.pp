class statemachine::logger (
  $load_config = false,
  $logger      = $statemachine::config::logger,
) {
  if $load_config {
    $config_manifest = "${logger}::config"
    include $config_manifest

    $config = getvar("${logger}::config")
    $config_json = sorted_json($config)

    file { "/etc/statemachine/logger.conf":
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('statemachine/etc/statemachine/config.conf.erb'),
    }
  }
}
