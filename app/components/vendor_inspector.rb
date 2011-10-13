# Displays a grid panel on the left, and the form on the right. When a row in the grid panel is clicked, the form panel dynamically loads the corresponding record.
class VendorInspector < Netzke::Basepack::BorderLayoutPanel

  component :vendor_grid
  component :vendor_form 

  def default_config
    super.tap do |c|
      c[:items] = [
        :vendor_grid.component(:region => :west, :width => 400, :split => true, :title => "List"),
        :vendor_form.component(:region => :center, :title => "Details")
      ]
    end
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.vendorGrid = this.getComponent('vendor_grid');
      this.vendorForm = this.getComponent('vendor_form');

      // When a row is clicked in the vendor grid, make the vendor form load the corresponding record
      this.vendorGrid.on('itemclick', function(view, record){
        this.vendorForm.netzkeLoad({id: record.getId()});
      }, this);
    }
  JS
end