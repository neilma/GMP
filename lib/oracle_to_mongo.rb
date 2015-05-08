module OracleToMongo

  def mongify(policies)
    Mongify.pms_policies(policies)
  end

  def search_pms_policies(sql_query)
    OracleDbClient.new.query(sql_query)
  end

end