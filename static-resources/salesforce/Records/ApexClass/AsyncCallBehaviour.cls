public class AsyncCallBehaviour {
    
    public static void callHerokuAPI(){
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://slowwly.robertomurray.co.uk/delay/9000/url/http://www.google.co.uk');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        
        // Log the XML content
        System.debug(res.getBody());
    }
    
    @Future(callout=true)
    public static void asyncCallHerokuAPI(){
        try{
            callHerokuAPI();
        }catch(Exception e){
            System.debug('Inserted log to DB');
        }
        
    }
    
}