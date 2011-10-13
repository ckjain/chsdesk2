class StaffGrid < ::Netzke::Basepack::GridPanel
   action :show_details, :text => "Show details"
   action :link_button, :text => 'Link Button'

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
    :bbar =>  [:show_details.action, "-", :add.action, "-", :edit.action, "-", :apply.action, "-", :del.action, :link_button.action], 
     :width => 820, 
     :title => 'Manage Staff Detail',
     :model => "Staff",
      :columns => [
      {:name => :staff_name, :width => 120,:label => 'Employee Name',:renderer => "capitalize"},
      {:name => :gender, :width => 50,:label => 'Gender',:renderer => "capitalize" },
      {:name => :age, :width => 30,:label => 'Age'},
      {:name => :staff_phone, :width => 80,:label => 'Phone'},
      {:name => :staff_email, :width => 90, :label => 'Email'},
      {:name => :updated_bulb, :width => 40,:label => "<div class='bulb-off' />", :tooltip => "Recently updated",
          :getter => lambda { |r| bulb = r.updated ? "on" : "off"
            "<div class='bulb-#{bulb}' />" }},
      {:name => :staff_category, :width => 90, :label => 'Designation',:renderer => "capitalize"},
      {:name => :staff_current_address, :width => 120, :label => 'Current Address',:renderer => "capitalize"},
      {:name => :staff_permanent_address, :width => 120, :label => 'Permanent Address',:renderer => "capitalize"},
      {:name => :active, :width => 60, :label => 'Is Active?'},
      {:name => :joining_date, :format => "d/m/y", :width => 90, :label => 'Date of Joining'},
      {:name => :staff_salary, :xtype => 'numbercolumn',:align => 'right',:format =>'0.00',:width => 60, :label => 'Salary'},
      {:name => :image, :getter => lambda{ |r| "<a href='#{r.image.url}'>Download</a>" if r.image.url }},
      {:name => :society__society_name, :width => 120, :label => 'Society Name',:renderer => "capitalize"},
    ]

  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.staffSearchBuffer = '';
      this.down('#staff_search_field').on('keydown', function() {this.onStaffSearch(); }, this, { buffer: 500 });
      this.down('#staff_search_field').on('blur', function() {this.onStaffSearch(); }, this, { buffer: 500 });

      this.getSelectionModel().on('selectionchange', function(selModel){
      this.actions.showDetails.setDisabled(selModel.getCount() != 1);  }, this);

    }
  JS

  js_method :on_show_details, <<-JS
      function(){
      var tmpl = new Ext.Template("<b>{0}</b>: {1}<br/>"), html = "";
      Ext.iterate(this.getSelectionModel().selected.first().data, function(key, value)
      {html += tmpl.apply([key.humanize(), value]); }, this);
      
      Ext.Msg.show({
      title: "Details",
      width: 400,
      msg: html
      });
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
