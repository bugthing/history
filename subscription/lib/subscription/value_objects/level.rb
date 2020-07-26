module Subscription
  module ValueObjects
    class Level
      STATES = %s[signup premium cancelled]
      class << self
        def signup; new(:signup); end
        def premium; new(:premium); end
        def cancelled; new(:cancelled); end
      end

      def initialize(state)
        raise Error if STATES.exclude?(state)
        @state = value
      end
    end
  end
end
