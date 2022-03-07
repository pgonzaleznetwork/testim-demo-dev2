public class MarketoAPI extends APIFactory{

	public override APIEndpoint getEndpoint(){
		return new MarketoEndpoint();
	}
}