define statemachine::log (
  $message = $name,
  $base    = undef,
  $logger  = $statemachine::config::logger,
) {
  $prefix = "[statemachine][${::hostname}][${::base}]"

  if $base == undef {
    notify { '[statemachite] Missing base. Skipping...': }
  } else {
    ensure_resource($logger, $name, {
      "message" => "${prefix} ${message}",
    })
  }
}

