module Orders
  class Subscriptions
    #Application.event_store.subscribe(to: [Payments::ChargeCreditCardSucceeded]) do |event|
    #  Orders::Commands::MarkOrderPaid.call()
    #end
    #Application.event_store.subscribe(to: [Fulfilment::ReleaseOrderSucceeded]) do |event|
    #  Orders::Commands::MarkOrderFulfilled.call()
    #end
    Application.event_store.subscribe(to: [Orders::Events::AddOrderItemSucceeded]) do |event|
      create_user = RubyEventStore::ROM.env.rom_container.commands[:order_items][:create]
      create_user.call([{ order_id: event.data[:order_id],
                          barcode: event.data[:barcode],
                          pence: event.data[:pence],
                          state: 'new' }])
    end
  end
end
