class MongoDbClient
  attr_accessor :client, :db, :config, :collection, :collection_names

  def initialize(opts={})
    default_config
  end

  def upsert(record, input_collection=nil)
    @collection = db.collection(input_collection) if input_collection
    dup_rec = record.dup
    collection.find(policy_number: dup_rec['policy_number'], lob: dup_rec['lob'], type_bureau: dup_rec['type_bureau']).tap do |cursor|
      if cursor.count == 0
        collection.insert(dup_rec)
      else
        record_to_update = cursor.next
        dup_rec['coverages'] += record_to_update['coverages']
        dup_rec['coverages'].uniq! { |i| i['risk_unit'] && i['major_peril'] }
        collection.update({"_id"=>record_to_update['_id']}, dup_rec)
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