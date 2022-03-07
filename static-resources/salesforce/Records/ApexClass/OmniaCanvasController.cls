public class OmniaCanvasController {
    
    Contact contact;
    
    public OmniaCanvasController(ApexPages.StandardController stdController) {
        this.contact = (Contact)stdController.getRecord();
    }
    
    public String getTabs(){
        
        List<Tab> tabs = new List<Tab>();
        Tab tab = new Tab();
        tab.label = 'Profile';
        tab.metabaseParams = new Map<String,String>{'Hello' => 'World'};
        tabs.add(tab);
        
        Map<String,List<Tab>> tabsMap = new Map<String,List<Tab>>();
        tabsMap.put('tabs',tabs);
        
        String tabsString = JSON.serialize(tabsMap);
        
        return tabsString;
    }
    
    public class Tab{
        public String label;
        public Map<String,String> metabaseParams;
        
     
    }

}