public with sharing class OpportunityCopyBatchHelper {

    /**
     * コンストラクタ
     */
	public OpportunityCopyBatchHelper() {
		
	}

    /**
     * 登録用の商談コピーリスト取得
     */
    public List<OpportunityCopy__c> getOpportunityCopyList(List<Opportunity> opportunities) {
        List<OpportunityCopy__c> oppCopyList = new List<OpportunityCopy__c>();
        for (Opportunity opp : opportunities) {
            OpportunityCopy__c oppCopy = new OpportunityCopy__c(
                 Name = opp.Name
                ,StageName__c = opp.StageName
                ,CloseDate__c = opp.CloseDate
            );
            // Add List
            oppCopyList.add(oppCopy);
            // Check IsCopy 
            opp.IsCopy__c = true;
        }

        return oppCopyList;
    }
}