# Displays a grid panel on the left, and the form on the right. When a row in the grid panel is clicked, the form panel dynamically loads the corresponding record.
class BillInspector < Netzke::Basepack::BorderLayoutPanel
  component :bill_grid, :class_name => "Netzke::Basepack::GridPanel", :model => "Bill", :columns => [:bill_number]
  component :bill_form, :class_name => "Netzke::Basepack::FormPanel", :model => "Bill"

  def default_config
    super.tap do |c|
      c[:items] = [
        :bill_grid.component(:region => :west, :width => 250, :split => true, :title => "List"),
        :bill_form.component(:region => :center, :title => "Details"),
      ]
    end
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.billGrid = this.getComponent('bill_grid');
      this.billForm = this.getComponent('bill_form');

      this.billGrid.on('itemclick', function(view, record){
        this.billForm.netzkeLoad({id: record.getId()});
      }, this);
    }
  JS
end