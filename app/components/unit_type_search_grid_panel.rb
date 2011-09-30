
class UnitTypeSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'unittype_search_field',
    :enable_key_events => true,
    :ref => '../unittype_search_field',
    :empty_text => 'Search'
  }],
      :persistence => true,
      :header => false, 
      :width => 820, :height => 400,
      :title => 'Unit Type',
      :model => "UnitType",
      :bbar =>  [:add.action, :edit.action, :apply.action, :del.action],
      :columns => [ 
      {:name => :type_name, :width => 150,:label => 'Type Name',:renderer => "uppercase" },
      {:name => :tax_area, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 120,:label => 'Property Tax Area',},
      {:name => :maintenance_area, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 120, :label => 'Maintenance Area'},  
      {:name => :carpet_area, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 120,:label => 'Carpet Area',},
      {:name => :built_area, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 120,:label => 'Built Up Area',},
      {:name => :super_built_area, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 120,:label => 'Super Built Up Area',},
      {:name => :updated_bulb, :width => 50,:label => "<div class='bulb-off' />", :getter => lambda { |r| bulb = r.updated_unit ? "on" : "off"
            "<div class='bulb-#{bulb}' />"}},

      ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.unittypeSearchBuffer = '';
      this.down('#unittype_search_field').on('keydown', function() {this.onUnittypeSearch(); }, this, { buffer: 500 });
      this.down('#unittype_search_field').on('blur', function() {this.onUnittypeSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_unittype_search, <<-JS
    function() {

      var search_text = this.down('#unittype_search_field').getValue();
      if (search_text == this.unittypeSearchBuffer) return;
      this.unittypeSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('unittype_search', search_text);
      this.getStore().load({params:{unittype_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:unittype_search_scope] || :unittype_search
    data_class.send(search_scope, params && params[:unittype_search] || '').scoping do
      super
    end
  end

end
