
module Orders
  class Order
    include ::AggregateRoot

    Error = Class.new(StandardError)

    def initialize(id)
      @id = id
      @items = []
      @total_paid = 0
      @atate = :open
    end

    def add_item(cmd)
      raise Error unless can_add_items?
      apply(Events::AddOrderItemSucceeded.new(data: cmd.attributes.to_hash))
    end

    def record_amount_paid(cmd)
      apply(Events::RecordAmountPaidSucceeded.new(data: cmd.attributes.to_hash))
      apply(Events::OrderPaidFor.new(data: { 
        order_id: @id,
        barcodes: @items.map { |i| i[:barcode] }
      })) if order_paid_for?
    end

    def apply_add_order_item_succeeded(event)
      @items << event.data
    end

    def apply_record_amount_paid_succeeded(event)
      @total_paid += event.data[:pence]
    end

    def apply_order_paid_for(event)
      @atate = :paid
    end

    def can_add_items?
      @atate == :open
    end

    def order_paid_for?
      @total_paid >= items_total
    end

    def items_total
      @items.inject(0) { |n,i| n+i[:pence] }
    end
  end
end
