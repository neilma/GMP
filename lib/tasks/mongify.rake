task :mongify do
  include OracleToMongo
  mongify("SELECT DISTINCT P.PLCY_SMBL, P.PLCY_NO, P.PLCY_MODL_NO, R.MAJR_PERL_CD, R.UNIT_NO, R.UNIT_SEQ_NO, P.TS_PLCY_STRT, P.TS_PLCY_END, P.ISSUE_STATE, P.AGNCY_NO , A.AGNCY_PRFT_CNTR, A.AGNCY_BRANCH, R.TYPE_BUREAU, A.IAG_DSTRBTN_CHNL, R.RISK_STRT_DT, R.RISK_EXPRY_DT
  FROM PMS1DBA.PMS_TRISK_ITEM R,
       PMS1DBA.PMS_TPLCY      P,
       PMS1DBA.PMS_TAGNCY A
    WHERE P.PLCY_SMBL     = R.PLCY_SMBL
    AND P.PLCY_NO       = R.PLCY_NO
    AND P.PLCY_MODL_NO  = R.PLCY_MODL_NO
    AND P.DS_PLCY_STATUS = 'CURRENT'
    AND A.AGNCY_NO  = P.AGNCY_NO
    FETCH FIRST 10 ROWS ONLY;")
end