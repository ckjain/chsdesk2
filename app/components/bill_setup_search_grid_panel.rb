
class BillSetupSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'billsetup_search_field',
    :enable_key_events => true,
    :ref => '../billsetup_search_field',
    :empty_text => 'Search'
  }],
     :persistence => true,
 
     :header => false, 
     :title => 'Manage BillSetup',
     :model => "BillSetup",
     :bbar =>  [ :edit.action, :apply.action],
     :columns => [
      {:name => :head_name, :read_only => true, :width => 130,:label => 'Categories of charges',:renderer => "capitalize"},
      {:name => :sub_head_name, :width => 150,:label => 'Sub Category',:renderer => "capitalize"},
      {:name => :rate_sqft_month, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 65,:label => 'Rate/sq.Ft' },
      {:name => :rate_unit_month, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 85,:label => 'Per Unit/month'},
      {:name => :service_tax_pct, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 80,:label => 'Service Tax %'},
      {:name => :days_to_discount, :xtype => 'numbercolumn',:align => 'right',:xtype => 'numbercolumn',:align => 'right',:format =>'0,000',:width => 80, :label => 'Discount Days'},
      {:name => :discount_pct, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 70, :label => 'Discount %'},
      {:name => :updated_bulb, :width => 40,:label => "<div class='bulb-off' />", :tooltip => "Recently updated",
      :getter => lambda { |r| bulb = r.updated ? "on" : "off"
           "<div class='bulb-#{bulb}' />"}},

      ]

  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.billsetupSearchBuffer = '';
      this.down('#billsetup_search_field').on('keydown', function() {this.onBillsetupSearch(); }, this, { buffer: 500 });
      this.down('#billsetup_search_field').on('blur', function() {this.onBillsetupSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_billsetup_search, <<-JS
    function() {

      var search_text = this.down('#billsetup_search_field').getValue();
      if (search_text == this.billsetupSearchBuffer) return;
      this.billsetupSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('billsetup_search', search_text);
      this.getStore().load({params:{billsetup_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:billsetup_search_scope] || :billsetup_search
    data_class.send(search_scope, params && params[:billsetup_search] || '').scoping do
      super
    end
  end

end
