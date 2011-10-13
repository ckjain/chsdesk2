class UnitSearchGridPanel < ::Netzke::Basepack::GridPanel
      action :show_details, :text => "Show details"

  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'unit_search_field',
    :enable_key_events => true,
    :ref => '../unit_search_field',
    :empty_text => 'Search'
  }],
   :border => false,
   :persistence => false,
   :header => false,
   :height => 515,
    :bbar =>  [:show_details.action, "-", :add.action, "-", :edit.action, "-", :apply.action, "-", :del.action], 
   :title => 'Unit Details',
   :model => "Unit",
    :columns => [ 
    {:name => :unit_number, :width => 70, :label => 'Unit Number',:align => 'right'},
    {:name => :updated_bulb, :width => 25,:label => "<div class='bulb-off' />", :getter => lambda { |r| bulb = r.updated_unit ? "on" : "off"
            "<div class='bulb-#{bulb}' />"}},
    {:name => :building_name, :width => 45, :align => 'center',:label => 'Building', :renderer => "capitalize"},
    {:name => :wing_name, :width => 35, :label => 'Wing', :align => 'center',:renderer => "uppercase"},
    {:name => :floor_name, :width => 35, :label => 'Floor', :align => 'center'},
    {:name => :unit_type__type_name, :width => 100, :label => 'Unit Type',:renderer => "capitalize"}, 
    {:name => :noc_charges,  :width => 40, :label => 'NOC', :xtype => 'numbercolumn',:align => 'right',:format =>'0.00'}, 
    {:name => :parking_charges, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 50, :label => 'Parking'}, 
    {:name => :bill_amount, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 70, :label => 'BillAmount'}, 
    {:name => :property_tax, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 70, :label => 'PropertyTax'}, 
    {:name => :maintenance_charge, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 70, :label => 'Maintenance'}, 
    {:name => :sinking_fund, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 65, :label => 'SinkingFund'}, 
    {:name => :repair_fund, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 65, :label => 'RepairFund'}, 
    {:name => :other_charge, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 70, :label => 'OtherCharges'}, 
    {:name => :service_tax, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 50, :label => 'S.Tax'}, 
    {:name => :discount, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00', :width => 50, :label => 'discount'}, 
    {:name => :society__society_name, :width => 160, :label => 'Society Name', :renderer => "capitalize"},

    ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
            this.unitSearchBuffer = '';
      this.down('#unit_search_field').on('keydown', function() {this.onUnitSearch(); }, this, { buffer: 500 });
      this.down('#unit_search_field').on('blur', function() {this.onUnitSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_unit_search, <<-JS
    function() {

      var search_text = this.down('#unit_search_field').getValue();
      if (search_text == this.unitSearchBuffer) return;
      this.unitSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('unit_search', search_text);
      this.getStore().load({params:{unit_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:unit_search_scope] || :unit_search
    data_class.send(search_scope, params && params[:unit_search] || '').scoping do
      super
    end
  end

end
