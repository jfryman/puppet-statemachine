module Puppet::Parser::Functions
  newfunction(:does_manifest_exist, :type => :rvalue,
              :doc => 'Determine if the manifest exists') do |args|
    manifest_lookup = args[0]
    module_path     = File.expand_path('..', Puppet::Module.find('statemachine', compiler.environment.to_s).path)
    
    Puppet::Module.find(manifest_lookup, compiler.environment.to_s) ? true : false
  end
end
