public class quoteTriggerHelper {

    public static void createEmailMessage(list<Quote> newlist){
      Set<id> oset = new Set<id>();
        for(Quote q: newlist){
            oset.add(q.OpportunityId);
        }
    }
}