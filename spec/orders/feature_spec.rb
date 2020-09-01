RSpec.describe 'Ordering, paying and fulfilling'do
  it 'can process the ordering of items which can be paid for and fulfilled' do
    order_id = rand(36**10).to_s(36)
    Orders::Commands::AddItem.call(order_id: order_id, barcode: '001', pence: 10000)
    Orders::Commands::AddItem.call(order_id: order_id, barcode: '002', pence: 20050)
    Payments::Commands::ChargeCreditCard.call(order_id: order_id,
                                              number: '444444444444',
                                              expiry: '03/22',
                                              cvv: 123,
                                              name: 'MR M JACKSON',
                                              address: '24 North St.',
                                              postcode: 'US1 A23',
                                              pence: 30050)
    Fulfillment::Commands::ScanOrderItem.call(order_id: order_id, barcode: '001')
    Fulfillment::Commands::ScanOrderItem.call(order_id: order_id, barcode: '002')

    expect(
      Order::OrderItems.where(order_id: order_id).pluck(:state).first
    ).to eq 'fulfilled'
  end
end
