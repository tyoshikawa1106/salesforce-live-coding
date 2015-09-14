public with sharing class OpportunityCopyBatchDao {

    /**
     * コンストラクタ
     */
	public OpportunityCopyBatchDao() {
		
	}

    /**
     * 商談情報取得
     */
    public Database.QueryLocator getOpportunities() {
        String query = '';
        query += ' SELECT ';
        query += ' Id ';
        query += ' ,Name ';
        query += ' ,StageName ';
        query += ' ,CloseDate ';
        query += ' FROM ';
        query += ' Opportunity ';
        query += ' WHERE ';
        query += ' IsWon = true';
        query += ' AND ';
        query += ' IsCopy__c = false ';
        return Database.getQueryLocator(query);
    }
}