define statemachine::set(
  $ensure  = present,
  $base    = $name,
  $state   = undef,
  $backend = $statemachine::config::backend,
) {
  if $state {
    ensure_resource($backend, $name, {
      "ensure" => $ensure,
      "base"   => $base,
      "state"  => $state,
    })
  } else {
    statemachine::log { "Unable to set state for ${base}. Missing state. Skipping...": }
  }
}
