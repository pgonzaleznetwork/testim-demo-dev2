public class BusScheduleCache {
    
    private Cache.OrgPartition part;
    
    //constructor
    public BusScheduleCache(){
        part = Cache.Org.getPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule){
        
        part.put(busLine,schedule);
        
    }
    
    public Time[] getSchedule(String busLine){
        
        Time[] schedules = (Time[])part.get('busLine');
        
        if(schedules == null){
            
            schedules = new Time[]{};
            Time eightAM = Time.newInstance(8, 0, 0, 0);
            Time fivePM = Time.newInstance(17, 0, 0, 0);
            schedules.add(eightAM);
            schedules.add(fivePM);
        }
        
        return schedules;
    }

}