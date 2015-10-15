module Mongify

  class << self
    attr_accessor :policy

    def pms_policies(policies)
      policies.inject([]) do |memo, obj|
        transformed_policy = pms_policy(obj)
        memo << transformed_policy
      end
    end

    def pms_policy(policy)
      @policy = Hash[policy.map do |k, v|
                       k = schema_mapper[k], v
                     end]
      forge_risk_unit.forge_time.forge_coverage.forge_policy_no
      @policy.tap { |rec| puts rec }
    end

    def schema_mapper
      {PLCY_SMBL: 'symbol', PLCY_NO: 'policy', PLCY_MODL_NO: 'module',
       MAJR_PERL_CD: 'major_peril', UNIT_NO: 'unit_number', UNIT_SEQ_NO: 'seq_no',
       TS_PLCY_STRT: 'start', TS_PLCY_END: 'end', ISSUE_STATE: 'issue_state',
       AGNCY_NO: 'agency_number', AGNCY_PRFT_CNTR: 'profit_centre', AGNCY_BRANCH: 'branch_number',
       TYPE_BUREAU: 'type_bureau', IAG_DSTRBTN_CHNL: 'distribution_channel',
       RISK_STRT_DT: 'risk_start_date', RISK_EXPRY_DT: 'risk_end_date'}.with_indifferent_access
    end

    def forge_risk_unit
      self.tap { |i| @policy['risk_unit'] = policy['unit_number'] + policy['seq_no'] }
    end

    def forge_coverage
      self.tap do |i|
        keys = %w(major_peril risk_unit risk_start_date risk_end_date type_bureau)
        @policy['coverages'] = [@policy.extract!(*keys)]
      end
    end

    def forge_policy_no
      self.tap do |i|
        @policy['policy_number'] = policy['symbol'] + policy['policy'] + policy['module']
      end
    end

    def forge_time
      self.tap do |i|
        policy.keys.each { |key| @policy[key] = @policy[key].to_time.utc if key =~ /date|start|end/ }
      end
    end

    def model_upsert(record)
      dup_rec = record.dup
      Policy.where(policy_number: dup_rec['policy_number']).tap do |query|
        if query.exists?
          dup_rec['coverages'] += query.first.coverages
          dup_rec['coverages'].uniq!
          query.update(dup_rec)
        else
          Policy.create(dup_rec)
        end
      end
    end

  end

end