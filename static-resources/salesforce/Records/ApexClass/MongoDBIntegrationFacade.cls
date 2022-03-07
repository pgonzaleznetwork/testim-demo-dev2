public class MongoDBIntegrationFacade {
    
    public static void syncToMongo(){
        
        Deduplicator.dedupeAgainstDB();
        MongoDBAPI.sendObjectToDB();
        MDBIntegrationValidator.validateAllReferences();
    }

}