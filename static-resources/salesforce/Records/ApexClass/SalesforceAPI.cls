public class SalesforceAPI extends APIFactory{

	public override APIEndpoint getEndpoint(){
		return new SalesforceEndpoint();
	}
}