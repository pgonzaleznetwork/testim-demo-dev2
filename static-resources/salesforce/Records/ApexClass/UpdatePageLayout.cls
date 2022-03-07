public class UpdatePageLayout {

  //add custom field to page layout

  public Metadata.Layout buildLayout(){

    //retrieve account layout and section
    List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout,new List<String>{'Account-Account Layout'});
    Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
    Metadata.LayoutSection layoutSectionToEdit = null;
    List<Metadata.LayoutSection> layoutSections = layoutMd.layoutSections;
    for(Metadata.LayoutSection section : layoutSections){
      if(section.label == 'Account Information'){
        layoutSectionToEdit = section;
        break;
      }
    }

    //add the field under account info section in the left column
    List<Metadata.LayoutColumn> layoutColumns = layoutSectionToEdit.layoutColumns;
    List<Metadata.LayoutItem> layoutItems = layoutColumns.get(0).layoutItems;

    //create a new layout item for the custom field
    Metadata.LayoutItem item = new Metadata.LayoutItem();
    item.behavior = Metadata.UiBehavior.Edit;
    item.field = 'Active_Subscriptions__c';
    layoutItems.add(item);
    return layoutMd;


  }

}