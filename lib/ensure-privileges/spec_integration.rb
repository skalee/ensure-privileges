module EnsurePrivileges
  module SpecIntegration
    def ensure_privileges(&privileges_examples)
      ExampleBuilder.new(self, privileges_examples).build
    end
  end
end
