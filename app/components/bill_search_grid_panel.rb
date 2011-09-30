class BillSearchGridPanel < ::Netzke::Basepack::GridPanel

 config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'bill_search_field',
    :enable_key_events => true,
    :ref => '../bill_search_field',
    :empty_text => 'Search'
  }],
     :persistence => true,
     :border =>false,
     :width => 820, :height => 600,
     :title => 'Manage Bills ',
     :model => "Bill",
     :bbar =>  [:add.action, :edit.action, :apply.action, :del.action],
     :columns => [
      {:name => :bill_number, :width => 60,:label => 'Bill number'},
      {:name => :member_property__property_name, :width => 160,:label => 'Flat No.- Member Name' },
      {:name => :property_tax, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 70,:label => 'Property Tax'},
      {:name => :maintenance_charges, :xtype => 'numbercolumn', :align => 'right',:format =>'0.00',:width => 70,:label => 'Maintenance'},
      {:name => :repair_fund, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 65, :label => 'RepairFund'},
      {:name => :sinking_fund, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 65, :label => 'SinkingFund'},
      {:name => :noc_charges, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 40, :label => 'NOC'},
      {:name => :parking_charges, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 43, :label => 'Parking'},
      {:name => :other_charges, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 45, :label => 'Others'},
      {:name => :service_tax, :width => 40, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:label => 'S.Tax'},
      {:name => :penalty_interest, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 45,:label => 'Penalty'},
      {:name => :discount_amount, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 47,:label => 'Discount'},
      {:name => :current_bill_charges, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 60, :label => 'Bill Amount'},
      {:name => :payable_amount, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 70, :label => 'Net Payable'},
      {:name => :from_date, :format => "d-m-y", :width => 70, :label => 'From'},
      {:name => :to_date, :format => "d-m-y", :width => 70, :label => 'To '},
      {:name => :bill_date, :format => "d-m-y",:width => 70, :label => 'Bill date'},
      {:name => :society__society_name, :width => 60, :label => 'Society Name',:renderer => "uppercase"},
      ]

  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.billSearchBuffer = '';
      this.down('#bill_search_field').on('keydown', function() {this.onBillSearch(); }, this, { buffer: 500 });
      this.down('#bill_search_field').on('blur', function() {this.onBillSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_bill_search, <<-JS
    function() {

      var search_text = this.down('#bill_search_field').getValue();
      if (search_text == this.billSearchBuffer) return;
      this.billSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('bill_search', search_text);
      this.getStore().load({params:{bill_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:bill_search_scope] || :bill_search
    data_class.send(search_scope, params && params[:bill_search] || '').scoping do
      super
    end
  end

end
