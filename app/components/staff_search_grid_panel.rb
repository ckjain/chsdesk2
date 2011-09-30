
class StaffSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'staff_search_field',
    :enable_key_events => true,
    :ref => '../staff_search_field',
    :empty_text => 'Search'
  }],
     :persistence => true,
     :border =>false,
     :header => false, 
     :width => 820, :height => 350,
     :title => 'Manage Staff Detail',
     :model => "Staff",
     :bbar =>  [:add.action, :edit.action, :apply.action, :del.action],
      :columns => [
      {:name => :staff_name, :width => 120,:label => 'Employee Name',:renderer => "uppercase"},
      {:name => :gender, :width => 50,:label => 'Gender',:renderer => "uppercase" },
      {:name => :age, :width => 40,:label => 'Age'},
      {:name => :staff_phone, :width => 90,:label => 'Phone'},
      {:name => :staff_email, :width => 90, :label => 'Email'},
      {:name => :staff_category, :width => 90, :label => 'Duty Category',:renderer => "uppercase"},
      {:name => :staff_current_address, :width => 120, :label => 'Current Address',:renderer => "uppercase"},
      {:name => :staff_permanent_address, :width => 120, :label => 'Permanent Address',:renderer => "uppercase"},
      {:name => :active, :width => 60, :label => 'Is Active?'},
      {:name => :joining_date, :format => "d/m/y", :width => 90, :label => 'Date of Joining'},
      {:name => :staff_salary, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 60, :label => 'Salary'},
      {:name => :photo_id, :width => 40, :label => 'Photo'},
      {:name => :society__society_name, :width => 120, :label => 'Society Name',:renderer => "uppercase"},
    ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.staffSearchBuffer = '';
      this.down('#staff_search_field').on('keydown', function() {this.onStaffSearch(); }, this, { buffer: 500 });
      this.down('#staff_search_field').on('blur', function() {this.onStaffSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_staff_search, <<-JS
    function() {

      var search_text = this.down('#staff_search_field').getValue();
      if (search_text == this.staffSearchBuffer) return;
      this.staffSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('staff_search', search_text);
      this.getStore().load({params:{staff_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:staff_search_scope] || :staff_search
    data_class.send(search_scope, params && params[:staff_search] || '').scoping do
      super
    end
  end

end
