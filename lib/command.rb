class Command < Dry::Struct
  module Types
    include Dry::Types(default: :nominal)
  end

  def self.stream_prefix(str)
    self.instance_variable_set(:@stream_prefix, str)
  end

  def self.aggregate(klass)
    self.instance_variable_set(:@aggregate, klass)
  end

  def self.ident_attr(attr)
    self.instance_variable_set(:@ident_attr, attr)
  end

  def self.call(**args)
    cmd = new(**args)
    cmd.call if cmd.valid?
  end

  def repository
    @repository ||= AggregateRoot::Repository.new(App[:event_store])
  end

  def call
    agg_method = self.class.name.split('::').last.gsub(/(.)([A-Z])/,'\1_\2').downcase
    with_aggregate(id) do |agg|
      agg.send(agg_method, self)
    end
  end

  def valid?
    # TODO: user dry schema to validate the command 
    true
  end

  def id
    public_send self.class.instance_variable_get(:@ident_attr)
  end

  private

  def aggregate
    self.class.instance_variable_get(:@aggregate)
  end

  def stream_name(id)
    "#{self.class.instance_variable_get(:@stream_prefix)}$#{id}"
  end

  def with_aggregate(id, &block)
    repository.with_aggregate(aggregate.new(id), stream_name(id), &block)
  end
end
