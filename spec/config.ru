lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'dummy_server'
run Deustorb::Dummy