module Subscription
  class Services
    def sign_up(**args)
      command = init_command(Commands::SignUp, **args)
      Aggregates::Subscription.new(email: command.email).sign_up
    end

    private

    def init_command(klass, **args)
      command = klass.new(**args)
      command.validate!
      command
    end
  end
end
