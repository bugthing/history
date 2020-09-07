RSpec.describe 'Ordering, paying and fulfilling'do
  it 'can process the ordering of items which can be paid for and fulfilled' do
    order_id = rand(36**10).to_s(36)
    Services::Shop.add_item(order_id, '001', 10000)
    Services::Shop.add_item(order_id, '002', 2)
    Services::Shop.charge_card(order_id, '4111111111111111', '03/22', 123, 'MR M JACKSON', '24 North St.', 'US1 A23', 10002)
    Services::Shop.scan(order_id, '001')
    Services::Shop.scan(order_id, '002')

    expect(
      Orders::ReadModels::OrderItems.where(order_id: order_id).pluck(:state).first
    ).to eq 'fulfilled'
  end
end
