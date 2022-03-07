public class ToolingAPI {
    
    public static void getButtonLinkMetadata(){
        HttpRequest request = getHttpRequestObject();
        String endpointWithQuery = request.getEndpoint();
        endpointWithQuery = endpointWithQuery+'SELECT+MasterLabel+FROM+WebLink+WHERE+Name+= \'BhartiButton\'';
        request.setEndpoint(endpointWithQuery);
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        while (response.getStatusCode() == 302) {
            request.setEndpoint(response.getHeader('Location'));
            response = new Http().send(request);
   		}
        System.debug(response.getBody());
        
    }
    
    
    private static HttpRequest getHttpRequestObject(){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        req.setEndpoint('https://resourceful-moose-448750-dev-ed.lightning.force.com/services/data/v41.0/tooling/query/?q=');
        
        return req;
    }

}