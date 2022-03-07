public class CompareTranslationFilesApex {
    
    @AuraEnabled
    public static void compareTranslationFiles(String untranslatedFile,String layoutInfoFile){
        
        //map representing the keys and values from the untranslated file
        Map<String,String> unTranslatedFileKeys = new Map<String,String>();
        //Split the untranslated file into lines
        List<String> unTranslatedFileLines = untranslatedFile.split('\r\n');
        
        for(String line: unTranslatedFileLines){
            System.debug('Line: '+line);
            String key = line.substringBeforeLast('\t');
            System.debug('key after first substring: '+key);
            key = key.substringAfter('\t');
            System.debug('key after second substring: '+key);
            
            String value = line.substringAfterLast('\t');
            
            unTranslatedFileKeys.put(key,value);
                       
        }
        
        //System.debug(unTranslatedFileKeys.keySet()); 
        //System.debug(unTranslatedFileKeys.values()); 
        
        //map representing the keys and values from the layout info file
        Map<String,String> layoutInfoFileKeys = new Map<String,String>();
        //Split the file into lines
        List<String> layoutInfoFileLines = layoutInfoFile.split('\r\n');
        
      
        
        
        
        
    }

}