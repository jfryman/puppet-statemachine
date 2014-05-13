class statemachine::backend(
  $load_config = true,
  $backend     = $statemachine::config::backend,
) {

  if $load_config {
    $config_manifest = "${backend}::config"
    include $config_manifest

    $config = getvar("${backend}::config::settings")
    validate_hash($config)
    $config_json = sorted_json($config)

    file { "/etc/statemachine/backend.conf":
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('statemachine/etc/statemachine/config.conf.erb'),
    }
  }
}
