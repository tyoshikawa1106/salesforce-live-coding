public with sharing class OpportunityCopyBatch implements Database.Batchable<sObject>, Database.Stateful {

    private OpportunityCopyBatchHelper helper = new OpportunityCopyBatchHelper();
    private OpportunityCopyBatchDao dao = new OpportunityCopyBatchDao();

    /**
     * コンストラクタ
     */
    public OpportunityCopyBatch() {
    
    }

    /**
     * Start
     */
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return this.dao.getOpportunities();
    }
    
    /**
     * Execute
     */
    public void execute(Database.BatchableContext BC, List<Opportunity> opportunities) {
        // 登録用の商談コピーリスト取得
        List<OpportunityCopy__c> oppCopyList = this.helper.getOpportunityCopyList(opportunities);
        // 商談コピーをINSERT
        insert oppCopyList;
        // 商談のコピー済みフラグをUPDATE
        update opportunities;
    }
    
    /**
     * Finish
     */
    public void finish(Database.BatchableContext BC) {
        
    }
}