@IsTest
public class CompareTranslationFilesApex_Test {
    
    public static testMethod void testCompareFiles(){
        String file1 = 'file1';
        String file2 = 'file2';
        
        CompareTranslationFilesApex.compareTranslationFiles(file1, file2);
    }

}