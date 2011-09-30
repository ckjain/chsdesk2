class BillHeaderSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'billheader_search_field',
    :enable_key_events => true,
    :ref => '../billheader_search_field',
    :empty_text => 'Search'
  }],
     :persistence => true,
 
     :header => false, 
     :width => 720, :height => 330,
     :title => 'Manage Bill Headings',
     :model => "BillHeader",
     :bbar =>  [ :add.action, :edit.action, :apply.action, :del.action,],
     :columns => [
      {:name => :bill_date, :format => "d/m/y", :width => 70,:label => 'Bill Date'},
      {:name => :from_date, :format => "d/m/y", :width => 70,:label => 'From Date'},
      {:name => :to_date, :format => "d/m/y", :width => 70,:label => 'To Date'},
      {:name => :bill_cycle, :width => 85,:label => 'Bill Cycle'},
      {:name => :grace_period, :xtype => 'numbercolumn',:align => 'right',:format =>'0,000',:width => 80,:label => 'Grace Period'},
      {:name => :days_to_discount, :xtype => 'numbercolumn',:align => 'right',:format =>'0,000',:width => 80, :label => 'Discount Days'},
      {:name => :bill_number_start, :xtype => 'numbercolumn',:align => 'right',:format =>'0,000',:width => 70, :label => 'Bill Number Start'},
      {:name => :bill_number_end, :xtype => 'numbercolumn',:align => 'right',:format =>'0,000',:width => 85,:label => 'Bill Number End'},
      {:name => :bill_number_format, :width => 80,:label => 'Bill Number Format'},
      {:name => :locked_period, :width => 80, :label => 'Done'},
      {:name => :society__society_name, :width => 70, :label => 'Society Name'}, 

      ]

  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.billheaderSearchBuffer = '';
      this.down('#billheader_search_field').on('keydown', function() {this.onBillheaderSearch(); }, this, { buffer: 500 });
      this.down('#billheader_search_field').on('blur', function() {this.onBillheaderSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_billheader_search, <<-JS
    function() {

      var search_text = this.down('#billheader_search_field').getValue();
      if (search_text == this.billheaderSearchBuffer) return;
      this.billheaderSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('billheader_search', search_text);
      this.getStore().load({params:{billheader_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:billheader_search_scope] || :billheader_search
    data_class.send(search_scope, params && params[:billheader_search] || '').scoping do
      super
    end
  end

end
