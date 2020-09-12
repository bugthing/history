App.boot(:db) do
  init do
    require 'rom'
  end

  start do
    rom = ROM.container(:sql, ENV['DATABASE_URL']) do |config|
      config.register_relation(Orders::ReadModels::OrderItems)
    end

    register(:db, rom)
  end
end
