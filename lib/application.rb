
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir(File.dirname(__FILE__))
loader.setup

require 'ruby_event_store'
require 'ruby_event_store/rom/sql'

module Application

  def self.event_store
    @event_store ||= begin

      RubyEventStore::ROM.env = RubyEventStore::ROM.setup(:sql, ENV['DATABASE_URL']) do |config|
        config.register_relation(Orders::ReadModels::OrderItems)
      end

      RubyEventStore::Client.new(
        repository: RubyEventStore::ROM::EventRepository.new
      )
    end
  end

  def self.rom_container
    RubyEventStore::ROM.env.rom_container
  end

  def self.test
    event_store.publish(EventTested.new(data: {
        order_id: 1,
        customer_id: 771,
        amount: Float("20.00"),
      }),
      stream_name: "Order-1",
    )
  end
  EventTested = Class.new(RubyEventStore::Event)
  private_constant :EventTested

  require_relative 'orders/subscriptions'
end
