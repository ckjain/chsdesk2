class AssignSearchGridPanel < ::Netzke::Basepack::GridPanel
 css_include :main
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'assign_search_field',
    :enable_key_events => true,
    :ref => '../assign_search_field',
    :empty_text => 'Search'
  }],
     :model => "MemberProperty",
    :title => 'Assign Flat to Members',
    :header => false,
    :bbar =>  [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action], 
    :columns => [
    {:name => :start_date, :width => 90,:format => "d/m/y",:label => 'Start Date'},
    {:name => :updated_bulb, :width => 30,:label => "<div class='bulb-off' />", :tooltip => "Recently updated",
      :getter => lambda { |r| bulb = r.updated_status ? "on" : "off"
           "<div class='bulb-#{bulb}' />"}},
    {:name => :unit__unit_name, :width => 100, :label => 'Unit',:renderer => "capitalize" },
    {:name => :member_id, :width => 70, :align => 'center',:label => 'Member ID'},
    {:name => :member__member_name, :read_only => true, :width => 270, :label => 'Member--View only (Edit By Member ID)'},
    {:name => :member_type, :width => 105,:label => 'Member Type',:renderer => "capitalize"},
    {:name => :status, :width => 45,:display_only => true},
    {:name => :end_date, :format => "d/m/y", :width => 90, :label => 'End Date'},
     ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.assignSearchBuffer = '';
      this.down('#assign_search_field').on('keydown', function() {this.onAssignSearch(); }, this, { buffer: 500 });
      this.down('#assign_search_field').on('blur', function() {this.onAssignSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_assign_search, <<-JS
    function() {

      var search_text = this.down('#assign_search_field').getValue();
      if (search_text == this.assignSearchBuffer) return;
      this.assignSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('assign_search', search_text);
      this.getStore().load({params:{assign_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:assign_search_scope] || :assign_search
    data_class.send(search_scope, params && params[:assign_search] || '').scoping do
      super
    end
  end

end
