class AddSubscriptionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false, index: { unique: true }
      t.timestamp :signed_up_at, null: false
      t.string :level, null: false, default: 'base'
      t.timestamp :cancelled_at
      t.timestamps
    end
  end
end
