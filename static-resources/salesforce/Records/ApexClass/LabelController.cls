public class LabelController {
    
    @AuraEnabled
    public static String getLabelValue(){
        String labelValue = System.Label.Thank_you_for_the_feedback;
        return labelValue;
    }

}