if defined?(::ActionController)
  require 'ensure-privileges/example_builder'
  module RSpec
    module Rails
      module ControllerExampleGroup
        include EnsurePrivileges::PrivilegesExampleGroup
      end
    end
  end
end
