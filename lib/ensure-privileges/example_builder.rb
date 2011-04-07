module EnsurePrivileges
  class ExamplesBuilder
    # Case is the pair of expectations and user set for which those expectations apply.
    class Case
      attr_reader :users, :expectations_after, :expectations_around, :should_text

      def initialize
        @expectations_after = []
        @expectations_around = []
        @users = []
        @should_text = ""
      end

      def when_performed_by(*users)
        @users = users
        self
      end

      def expecting(&expectations_block)
        @expectations_after << expectations_block
        self
      end

      def it_should_be_allowed
        it("should be allowed")
      end
      def it_should_be_disallowed
        it("should be disallowed")
      end
      def it(should_text)
        @should_text = should_text
        self
      end
    end


    def initialize(rspec_example_group, privileges_examples_block)
      @rspec_example_group = rspec_example_group
      @privileges_examples_block = privileges_examples_block
      @definitions = []
    end

    # The main method of builder.
    def build
      read_definitions_block
      define_examples
    end

    def for_action(&action_block)
      @action_block = action_block
    end

    protected

    def read_definitions_block
      self.instance_eval &@privileges_examples_block
    end

    def define_examples
      @definitions.each do |definition|
        definition.users.each do |user|
          @rspec_example_group.it "#{definition.should_text} when performed by #{user}" do
            login_as(user)
            self.instance_eval &@action_block
            definition.expectations_after.each do |expectation|
              self.instance_eval &expectation
            end
          end
        end
      end
    end

    def method_missing(name, *args)
      @definitions << Case.new
      @definitions.last.send(name, *args)
    end
  end
end




#####

class EnsurePrivilegesRunner

  def initialize(context)
    @context = context
    @checks = []
  end


  def for_action(&action_block)
    @checks.each do |user, pass_or_fail, expectation_block|
      @context.it "should #{pass_or_fail ? "pass" : "fail"} for #{user}" do
        user_obj = user_for(user)
        login_as(user_obj)
        self.instance_eval &action_block
        self.instance_eval &expectation_block
      end
    end
  end

  private

  def apply_case(users, pass_or_fail, expectation_block)
    users.each do |u|
      @checks << [u, pass_or_fail, expectation_block]
    end
    self
  end

end

def user_for(who)
  case who
  when 'admin'
    :admin
  when 'stranger'
    :user
  when 'anonymous'
    nil
  when /\A@.+/
    instance_variable_get who
  end
end

def ensure_privileges
  EnsurePrivilegesRunner.new(self)
end
