class AssignSearchGridPanel < ::Netzke::Basepack::GridPanel
 css_include :main
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'assign_search_field',
    :enable_key_events => true,
    :ref => '../assign_search_field',
    :empty_text => 'Search'
  }],
    :width => 820,
    :height => 400,
    :model => "MemberProperty",
    :title => 'Assign Flat to Members',
    :header => false,
    :bbar =>  [:add.action, :edit.action, :apply.action, :del.action], 
    :columns => [
    {:name => :start_date, :width => 90,:format => "d/m/y",:label => 'Start Date'},
    {:name => :unit__unit_name, :width => 110, :label => 'Unit',:renderer => "uppercase" },
    {:name => :member_id, :width => 70, :label => 'Member ID',:tooltip => "Select member ID to be assigned against a unit"},
    {:name => :member__member_name, :read_only => true, :width => 230, :label => 'Member--View only (Edit By Member ID)', :renderer => "uppercase"},
    {:name => :member_type, :width => 135,:label => 'Member Type', :renderer => "uppercase"},
    {:name => :status, :width => 45,:read_only => true,:label => "Active?" },
    {:name => :updated_bulb, :width => 30,:label => "<div class='bulb-off' />", :getter => lambda { |r| bulb = r.updated ? "on" : "off"
            "<div class='bulb-#{bulb}' />"}},
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
