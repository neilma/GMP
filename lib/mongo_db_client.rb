class MongoDbClient
  attr_accessor :client, :db, :config, :collection, :collection_names, :record
  def initialize(opts={})
    default_config
    @collection = db.collection(opts[:collection]) if opts[:collection].present?
  end

  def destroy(record)
    @record = record
    @collection.remove(policy_number: record['policy_number'], lob: record['lob'])
  end

  def upsert(record)
    @record = record
    @record['updated_at'] = Time.now.utc
    collection.find(policy_number: record['policy_number'], lob: record['lob']).tap do |cursor|
      if cursor.count == 0
        collection.insert(record)
      else
        record_to_update = cursor.next
        @record['coverages'] += record_to_update['coverages']
        @record['coverages'].uniq! { |i| i['risk_unit'] && i['major_peril'] }
        collection.update({ "_id" => record_to_update['_id'] }, record)
      end
    end
  end

  def default_config
    @config = YAML::load_file("#{Rails.root}/config/mongo.yml").with_indifferent_access
    @client = Mongo::MongoClient.new(config[:sessions][:hostname],
                                     config[:sessions][:port])
    @db = client.db(config[:sessions][:database])
    db.authenticate(config[:sessions][:username], config[:sessions][:password])
    @collection_names = db.collection_names
    @collection = db.collection(config[:sessions][:collection])
  end
end