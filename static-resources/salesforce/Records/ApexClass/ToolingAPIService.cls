public class ToolingAPIService {
    
    public static void getPageLayout(){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        String serviceURL = 'https://resourceful-moose-448750-dev-ed.my.salesforce.com/services/data/v42.0/tooling/query/?q=';
        String query = 'SELECT+FullName,+ErrorMessage+FROM+ValidationRule+WHERE+FullName+IN+(+\'uno\',\'dos\')';
        
        req.setEndpoint(serviceURL+query);
		req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        system.debug(res.getBody()); 
    }

}