require File.expand_path('../simple_oracle_jdbc', __FILE__)

class OracleDbClient
  include SimpleOracleJDBC
  include ApplicationHelper
  attr_accessor :db_config, :username, :password

  def initialize(username, password)
    @db_config = load_config
    @username = username
    @password = password
  end

  def conn
    Java::JavaClass.for_name(db_config[:driver])
    begin
      conn = java.sql.DriverManager.getConnection("#{db_config[:conn_path]}#{db_config[:database]}",
                                                  username, password)
    rescue => e
      return {error: humanize_pms_error_msg(e.message)}
    end
    yield(conn)
  end

  def query(statement)
    result_set = nil
    rval = conn { |cursor| result_set = db_query(cursor, statement) }
    return rval if rval.is_a?(Hash)
    to_hash(result_set)
  end

  def to_hash(result_set)
    [].tap { |hash_result| each_row(result_set) { |row| hash_result << row } }
  end

  private
  def load_config
    HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../config/pms_policy.yml', __FILE__))))
  end

  def humanize_pms_error_msg(msg)
    if msg.include?('invalid database address')
      msg + ' or incorrect credentials.'
    else
      msg
    end
  end

end
