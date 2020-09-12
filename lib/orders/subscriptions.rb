module Orders
  class Subscriptions
    App[:event_store].subscribe(to: [Payments::Events::ChargeCreditCardSucceeded]) do |event|
      Orders::Commands::RecordAmountPaid.call(
        order_id: event.data[:order_id],
        pence: event.data[:pence]
      )
    end

    App[:event_store].subscribe(to: [Orders::Events::OrderPaidFor]) do |event|
      Fulfillment::Commands::PrepareOrder.call(
        order_id: event.data[:order_id],
        barcodes: event.data[:barcodes]
      )
    end

    App[:event_store].subscribe(to: [Orders::Events::AddOrderItemSucceeded]) do |event|
      App[:db].relations[:order_items].create(
        event.data[:order_id],
        event.data[:barcode],
        event.data[:pence]
      )
    end

    App[:event_store].subscribe(to: [Fulfillment::Events::OrderFulfillmentComplete]) do |event|
      App[:db].relations[:order_items].set_fulfilled(event.data[:order_id])
    end
  end
end
