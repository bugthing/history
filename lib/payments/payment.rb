module Payments
  class Payment
    include AggregateRoot

    Error = Class.new(StandardError)

    def initialize(id)
      @id = id
      @charged_credit_cards = []
    end

    def charge_credit_card(cmd)
      apply(Events::ChargeCreditCardSucceeded.new(data: cmd.attributes.to_hash))
    end

    def apply_charge_credit_card_succeeded(event)
      @charged_credit_cards << event.data
    end
  end
end
