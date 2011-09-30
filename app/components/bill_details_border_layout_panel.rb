class BillDetailsBorderLayoutPanel < Netzke::Basepack::BorderLayoutPanel
 def configuration
  super.merge(
      :header => false,
      :items => [{
          :name => "bills",
          :class_name => "Netzke::Basepack::GridPanel",
          :model => "Bill",
          :region => :center,
          :title => "Bills"
        },{
          :name => "info",
          :class_name => "Netzke::Basepack::Panel",
          :region => :east,
          :title => "Info",
          :width => 240,
          :split => true
        },{
          :name => "bill_details",
          :class_name => "Netzke::Basepack::GridPanel",
          :model => "BillDetail",
          :region => :south,
          :title => "Bill Details",
          :height => 150,
          :split => true
      }]
    )
  end
    js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);

      // setting the 'rowclick' event
      this.getChildComponent("bills").on('rowclick', function(self, rowIndex){
        // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
        this.selectBill({bill_id: self.store.getAt(rowIndex).get('id')});
        this.getChildComponent('bill_details').getStore().reload();
        this.getChildComponent('bill_details').updateStats();
      }, this);
    }
  JS

  endpoint :select_bill do |params|
    # store selected boss id in the session for this component's instance
    component_session[:selected_bill_id] = params[:bill_id]
  end

  component :bill_details do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :model => "BillDetail",
      :load_inline_data => false,
      :scope => {:bill_id => component_session[:selected_bill_id]},
      :strong_default_attrs => {:bill_id => component_session[:selected_bill_id]}
    }
  end

  component :bill_details do
    {
      :class_name => "BossDetails",
      :boss_id => component_session[:selected_boss_id]
    }
  end


end