class VendorSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'vendor_search_field',
    :enable_key_events => true,
    :ref => '../vendor_search_field',
    :empty_text => 'Search'
  }],
     :persistence => true,
     :border =>false,
     :header => false, 
     :width => 820, :height => 350,
     :class_name => "VendorSearchGridPanel",
     :title => 'Vendors Detail',
     :model => "Vendor",
     :bbar =>  [:add.action, :edit.action, :apply.action, :del.action],
     :columns => [
      {:name => :vendor_name, :width => 120,:label => 'Vendor Name',:renderer => "uppercase"},
      {:name => :contact_name, :width => 80,:label => 'Contact Person',:renderer => "uppercase" },
      {:name => :vendor_phone, :width => 90,:label => 'Phone'},
      {:name => :vendor_email, :width => 90, :label => 'Email'},
      {:name => :service_type, :width => 90, :label => 'Type of Service',:renderer => "uppercase"},
      {:name => :tds_rate, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 60, :label => 'TDS Rate'},
      {:name => :service_tax_rate, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 80, :label => 'Service Tax Rate'},
      {:name => :is_recurring, :width => 60, :label => 'Is recurring?'},
      {:name => :stax_reg_number, :width => 80, :label => 'S.tax No.'},
      {:name => :pan_number, :width => 60, :label => 'PAN No'},
      {:name => :vat_number, :width => 60, :label => 'VAT No'},
      {:name => :section_code, :width => 60, :label => 'Section Code'},
      {:name => :payee_name, :width => 100, :label => 'Payee Name'},
      {:name => :address, :width => 140, :label => 'Address'},
      {:name => :society__society_name, :width => 120, :label => 'Society Name',:renderer => "uppercase"},
      ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.vendorSearchBuffer = '';
      this.down('#vendor_search_field').on('keydown', function() {this.onVendorSearch(); }, this, { buffer: 500 });
      this.down('#vendor_search_field').on('blur', function() {this.onVendorSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_vendor_search, <<-JS
    function() {

      var search_text = this.down('#vendor_search_field').getValue();
      if (search_text == this.vendorSearchBuffer) return;
      this.vendorSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('vendor_search', search_text);
      this.getStore().load({params:{vendor_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:vendor_search_scope] || :vendor_search
    data_class.send(search_scope, params && params[:vendor_search] || '').scoping do
      super
    end
  end

end
