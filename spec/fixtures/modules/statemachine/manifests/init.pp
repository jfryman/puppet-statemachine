define statemachine(
  $base          = $name,
  $states        = [
    'provisioning',
    'config',
    'ready',
  ],
) {
  include statemachine::config
  include statemachine::backend
  include statemachine::logger

  validate_array($states)
  validate_string($base)

  $sanitized_base = regsubst($base, '::', '_', G)
  if $sanitized_base =~ /^[a-zA-Z_]+$/ { $valid_base = true }

  $current_state  = getvar("::statemachine_${sanitized_base}")
  $state_manifest = "${base}::state::${current_state}"
  $initial_state  = $states[0]

  case $current_state {
    undef: {
      if $valid_base {
        statemachine::log { "Initializing statemachine ${base} to ${initial_state}": }
        statemachine::set { "initialize ${base} with default value: ${initial_state}":
          base  => $base,
          state => $initial_state,
        }
      } else {
        statemachine::log { "${base} contains invalid characters. See README.md for more information. Ignoring...": }
      }
    }
    default: {
      $valid_state   = member($states, $current_state)

      if $valid_state {
        statemachine::log { "Activating state ${state_manifest}.": }
        include $state_manifest
      } else {
        statemachine::log { "In a weird place. Not in a known state (${base}/${current_state}). Skipping...": }
      }
    }
  }
}
