define statemachine::backend::local(
  $ensure = present,
  $base   = $name,
  $state  = undef,
) {
  include statemachine::backend::local::config
  $settings = $statemachine::backend::local::config::settings
  validate_hash($settings)

  validate_re($ensure, '^(absent|present)$')
  validate_string($base, $state)

  $state_file = regsubst($base, '::', '_', 'G')

  file { "${settings['base_dir']}/${state_file}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${state}\n",
  }
}
