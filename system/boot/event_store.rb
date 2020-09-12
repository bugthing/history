App.boot(:event_store) do
  init do
    require 'aggregate_root'
    require 'ruby_event_store'
    require 'ruby_event_store/rom/sql'
  end

  start do
    RubyEventStore::ROM.env = RubyEventStore::ROM.setup(:sql, ENV['DATABASE_URL'])

    client = RubyEventStore::Client.new(
      repository: RubyEventStore::ROM::EventRepository.new
    )
    register(:event_store, client)
  end
end
