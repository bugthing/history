App.boot(:db) do
  init do
    require 'rom'

    conf = ROM::Configuration.new(:sql, ENV['DATABASE_URL']) do |config|
      config.register_relation(Orders::ReadModels::OrderItems)
    end

    register('db.config', conf)
  end

  start do |app|
    register(:db, ROM.container(app['db.config']))
  end
end
