# Displays a grid panel on the left, and the form on the right. When a row in the grid panel is clicked, the form panel dynamically loads the corresponding record.
class StaffInspector < Netzke::Basepack::BorderLayoutPanel

  component :staff_grid
  component :staff_form 

  def default_config
    super.tap do |c|
      c[:items] = [
        :staff_grid.component(:region => :west, :width => 400, :split => true, :title => "List"),
        :staff_form.component(:region => :center, :title => "Details")
      ]
    end
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.staffGrid = this.getComponent('staff_grid');
      this.staffForm = this.getComponent('staff_form');

      // When a row is clicked in the staff grid, make the staff form load the corresponding record
      this.staffGrid.on('itemclick', function(view, record){
        this.staffForm.netzkeLoad({id: record.getId()});
      }, this);
    }
  JS
end