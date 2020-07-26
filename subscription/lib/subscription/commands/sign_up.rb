module Subscription
  module Commands
    class SignUp
      def initialize(email:)
        @email = email
      end
      attr_reader :email

      def validate!
        if email.exclude?('@')
          raise Error, "#{email} is not a valid email address"
        end
      end
    end
  end
end
