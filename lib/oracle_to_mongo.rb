module OracleToMongo

  def mongify(policies)
    Mongify.pms_policies(policies)
  end

  def search_pms_policies(username, password, sql_query)
    OracleDbClient.new(username, password).query(sql_query)
  end

end