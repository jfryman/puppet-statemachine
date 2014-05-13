define statemachine::logger::console (
  $message = $name,
) {
  $config = {}
  
  notify { $message: }
}
