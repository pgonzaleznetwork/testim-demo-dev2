public class AnimalLocator {
    
    public static String getAnimalNameById(Integer animalId){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            Map<String,Object> jsonResponse = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            Map<String,Object> animalDetails = (Map<String,Object>)jsonResponse.get('animal');
            return (String)animalDetails.get('name');
        }
        
        return response.getBody();
    }

}