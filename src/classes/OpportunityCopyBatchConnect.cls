public with sharing class OpportunityCopyBatchConnect implements OpportunityCopyBatchSchedule.IScheduler {
    
    /**
     * execute
     */
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new OpportunityCopyBatch(), 200);
    }
}