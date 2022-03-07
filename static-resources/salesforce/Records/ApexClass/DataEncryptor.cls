public class DataEncryptor {
    
    public static Map<String,String> recordKey = new Map<String,String>();
    public static Blob cryptKey;                                                                                                                                                               Blob cryptoKey;
    
    public static void encryptName(List<Account> accts){
        
        for(Account a : accts){
            cryptKey = Crypto.generateAesKey(256);
            recordKey.put(a.Name, EncodingUtil.base64Encode(cryptKey));
            Blob data = Blob.valueOf(a.Name);
            Blob encryptedData = Crypto.encryptWithManagedIV('AES256', cryptKey, data);
            String b64EncrpytedData = EncodingUtil.base64Encode(encryptedData);
            a.Name = b64EncrpytedData;
            
            
        }
        
        for(String recordName : recordKey.keySet()){
            System.debug('Data: '+recordName+' -- Key: '+recordKey.get(recordName));
        }
    }
    
    public static void decryptData(String encryptedData,String key){
        Blob encryptedDataBlob = EncodingUtil.base64Decode(encryptedData);
        Blob encryptionKey = EncodingUtil.base64Decode(key);
        
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', encryptionKey, encryptedDataBlob);
        System.debug('Decrypted Value: '+decryptedData.toString());
    }

}