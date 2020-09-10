class Command < Dry::Struct
  module Types
    include Dry::Types(default: :nominal)
  end

  def self.stream_prefix(str)
    @@stream_prefix = str
  end

  def self.aggregate(klass)
    @@aggregate = klass
  end

  def self.ident_attr(attr)
    @@ident_attr = attr
  end

  def self.call(**args)
    cmd = new(**args)
    cmd.call if cmd.valid?
  end

  def repository
    @repository ||= AggregateRoot::Repository.new(Application.event_store)
  end

  def call
    agg_method = self.class.name.split('::').last.gsub(/(.)([A-Z])/,'\1_\2').downcase
    with_aggregate(id) do |agg|
      agg.send(agg_method, self)
    end 
  end

  def valid?
    true
    #attributes = to_hash
    #schema = WorldContract.new.call(attributes)
    #@errors = schema.errors(locale: I18n.locale).to_h.values.flatten
    #return false unless errors.empty?
    #@world = attributes[:id] ? World.find_by(id: attributes[:id]) : World.new
    #world.attributes = attributes.except(:id)
    #world.save
  end

  def id
    public_send @@ident_attr
  end

  private

  def aggregate
    @@aggregate
  end

  def stream_name(id)
    "#{@@stream_prefix}$#{id}"
  end

  def with_aggregate(id, &block)
    repository.with_aggregate(aggregate.new(id), stream_name(id), &block)
  end
end
