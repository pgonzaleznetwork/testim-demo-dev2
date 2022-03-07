@IsTest
public class AnimalLocatorMockNegative implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"result":"error"}');
        response.setStatusCode(400);
        return response;
    }

}