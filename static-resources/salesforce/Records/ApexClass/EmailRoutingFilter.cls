/*
 * This class is a representation of the "Email Routing Rule Filter" custom object.
 * The object provides three fields that can be used to create filters against an incoming email, as follows:
 * 
 * Email Attribute: An email attribute such as Body, Subject, etc
 * Operator: An operator to compare the Email Attribute, for example Equals, Contains, Does not Contain, etc.
 * Value: The actual value to compare against the Email Attribute
 * 
 * Email Subject > Contains > HelloWorld
 * 
 * Each record of this object reprsents a filter, and this class provides the actual logic for said filter.
*/
public class EmailRoutingFilter {
    
    /*
     * Represents the Email Attribute field in the "Email Routing Rule Filter" custom object record
	*/
    private String emailAttributeToCompare;
    /*
     * Represents the Operator field in the "Email Routing Rule Filter" custom object record
	*/
    private String operatorToUse;
    /*
     * Represents the Value field in the "Email Routing Rule Filter" custom object record
	*/
    private String valueToMatchOn;
    /*
     * A map of operator types and their implementation
	*/
    private Map<String,ComparisonOperatorI> comparisonOperatorStrategies;
    /*
     * The email attribute from the Email Message object that will be used in the comparison
	*/
    private String actualEmailAttribute;
    

    
    /*********************************************PUBLIC METHODS********************************************************/
    
    
    /*Constructor*/
    public EmailRoutingFilter(Email_Routing_Rule_Filter__c filter){
        
        comparisonOperatorStrategies = new Map<String,ComparisonOperatorI>();
        this.emailAttributeToCompare = filter.Email_Attribute__c;
        this.operatorToUse = filter.Operator__c;
        this.valueToMatchOn = filter.Value__c;
        registerComparisonOperators();
    }
    
    /*
     * Gets an email message and retrieves the value that needs to be compared. Then
     * it gets a comparison strategy object based on the operatorToUse variable. Each strategy
     * represents a particular comparion type, like "Equals", "Not Equal To","Contains", etc.
     * 
     * The email attribute is then compared (using the comparison type) against the  valueToMatchOn variable.
     * The return value is a boolean flag that tells whether the comparison was successful or not. 
	*/
    public Boolean compareEmailAttributeAgainstValue(EmailMessage email){
     
        setTheEmailAttributeToCompare(email);
        ComparisonOperatorI comparison = comparisonOperatorStrategies.get(operatorToUse);
        System.debug('The comparison implementation we are going to use is: '+JSON.serialize(comparison));
        Boolean resultOfComparison = comparison.compare(actualEmailAttribute,valueToMatchOn);
        return resultOfComparison;
    }
    
    /*****************************************************PRIVATE METHODS******************************************/
    
    /*
     * Based on the value of emailAttributeToCompare, get a specific attribute from the email message.
     * This attribute will be used to do a comparison against a specific value. 
	*/
    private void setTheEmailAttributeToCompare(EmailMessage email){
        if(emailAttributeToCompare == 'Subject'){
            System.debug('We are comparing with the Subject field');
            actualEmailAttribute = email.Subject;
            System.debug('The actual subject is: '+email.Subject);
        }else if(emailAttributeToCompare == 'To Address'){
            System.debug('We are comparing with the To Address field');
            actualEmailAttribute = email.ToAddress;
            System.debug('The actual address is: '+email.ToAddress);
        }else if(emailAttributeToCompare == 'From Address'){
            actualEmailAttribute = email.FromAddress;
        }else if(emailAttributeToCompare == 'Body'){
            actualEmailAttribute = email.TextBody;
        }
    }
    
   /*
    * This method registers different implementations of the  ComparisonOperatorI against a specific
    * string, which represents the type of comparison. For example, the "Equals" String value is
    * mapped to an implementation of ComparisonOperatorI that matches two strings using the == operator.
    * 
    * This is done so that the caller simply needs to pass a string value representing the comparison type,
    * and the implementation of ComparisonOperatorI takes care of the actual comparison details. 
	*/
    private void registerComparisonOperators(){
        comparisonOperatorStrategies.put('Equals', new EqualsOperator());
        //comparisonOperatorStrategies.put('Contains', new ContainsOperator());
    }
    
    

	/*
	 * Because there are many types of comparison operators (equals, not equals, contains, etc), we define
	 * a common interaface. The caller simply references the interface and doesn't need to know
	 * the actual implementation details of a comparison type.
	*/    
    private interface ComparisonOperatorI{
        Boolean compare(String emailAttributeToCompare,String valueToMatchOn);
    }
    
    /*
     * Implementation of the ComparisonOperatorI interface representing how to compare
     * two strings using the "equals" operator.
	*/
    public class EqualsOperator implements ComparisonOperatorI{
        
        public Boolean compare(String emailAttributeToCompare,String valueToMatchOn){
            
            Boolean isThereAMatch = false;
            if(emailAttributeToCompare.equalsIgnoreCase(valueToMatchOn)){
                isThereAMatch = true;
            }
            
            return isThereAMatch;
        }
    }
    
    /*
     * Implementation of the ComparisonOperatorI interface representing how to compare
     * two strings using the "contains" operator.
	
    public class ContainsOperator implements ComparisonOperatorI{
        public Boolean compare(String emailAttributeToCompare,String valueToMatchOn){
            
            Boolean isThereAMatch = false;
            if(emailAttributeToCompare.containsIgnoreCase(valueToMatchOn)){
                isThereAMatch = true;
            }
            
            return isThereAMatch;
            
        }
    }*/

}