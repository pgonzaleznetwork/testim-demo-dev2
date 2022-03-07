@IsTest
public class ParkServiceMock implements WebServiceMock{
    
     public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        String[] arrayResp = new List<String>();
        arrayResp.add('park1');
        response_x.return_x = arrayResp;
        // end
        response.put('response_x', response_x); 
   }

}