public virtual class APIFactory{

	public static APIFactory getFactory(String provider){
        
        APIFactory factory;

		if(provider == 'marketo'){
            System.debug('marketo here');
			factory = new MarketoAPI();
		}

		if(provider == 'salesforce'){
            System.debug('salesforce here');
			factory =  new SalesforceAPI();
		}
        
        return factory;

	}
    
    public virtual APIEndpoint getEndpoint(){
        
        return null;
        
    }
}