class MeetingTypeGrid < ::Netzke::Basepack::GridPanel

  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'meetingtype_search_field',
    :enable_key_events => true,
    :ref => '../meetingtype_search_field',
    :empty_text => 'Search'
  }],
      :persistence => true,
      :header => false, 
      :title => 'Meeting Type',
      :model => "MeetingType",
      :bbar => [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action], 
      :columns => [
      {:name => :types, :width => 150,:label => 'Type Name',:renderer => "capitalize" },
      {:name => :updated_bulb, :width => 50,:label => "<div class='bulb-off' />", :getter => lambda { |r| bulb = r.updated_meeting ? "on" : "off"
            "<div class='bulb-#{bulb}' />"}},

      ]

  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.meetingtypeSearchBuffer = '';
      this.down('#meetingtype_search_field').on('keydown', function() {this.onMeetingtypeSearch(); }, this, { buffer: 500 });
      this.down('#meetingtype_search_field').on('blur', function() {this.onMeetingtypeSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_meetingtype_search, <<-JS
    function() {

      var search_text = this.down('#meetingtype_search_field').getValue();
      if (search_text == this.meetingtypeSearchBuffer) return;
      this.meetingtypeSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('meetingtype_search', search_text);
      this.getStore().load({params:{meetingtype_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:meetingtype_search_scope] || :meetingtype_search
    data_class.send(search_scope, params && params[:meetingtype_search] || '').scoping do
      super
    end
  end

end
