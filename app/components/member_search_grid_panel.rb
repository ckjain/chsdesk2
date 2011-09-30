
class MemberSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'member_search_field',
    :enable_key_events => true,
    :ref => '../member_search_field',
    :empty_text => 'Search'
  }],
    :persistence => true,
    :border => false,
    :header => false, 
    :width => 820, :height => 500,
    :bbar => [:add.action, :edit.action, :apply.action, :del.action], 
    :title => 'Members',
    :model => "Member",
    :columns => [
      {:name => :mem_id, :width => 30, :read_only => true, :label => 'ID' },
      {:name => :prefix, :width => 60,:label => 'Mr/Mrs'},
      {:name => :first_name, :width => 100,:label => 'First Name',:renderer => "uppercase" },
      {:name => :last_name, :width => 100,:label => 'Surname',:renderer => "uppercase"},
      {:name => :email_id, :width => 130,:label => 'Email Id',:renderer => "lowercase" },
      {:name => :mobile_phone, :width => 100, :label => 'Contact Number'},
      {:name => :is_owner, :width => 50, :label => 'Owner?'},
      {:name => :live_here, :width => 60, :label => "Live Here?"},
      {:name => :email_bills, :width => 60, :label => 'Email Bills?'},
      {:name => :sms_bills, :width => 60, :label => 'SMS Bills?'},
      {:name => :sms_receipt, :width => 80, :label => "SMS Receipt?"}, ]


   js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.memberSearchBuffer = '';
      this.down('#member_search_field').on('keydown', function() {this.onMemberSearch(); }, this, { buffer: 500 });
      this.down('#member_search_field').on('blur', function() {this.onMemberSearch(); }, this, { buffer: 500 });
    }
  JS
 js_method :on_member_search, <<-JS
    function() {

      var search_text = this.down('#member_search_field').getValue();
      if (search_text == this.memberSearchBuffer) return;
      this.memberSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('member_search', search_text);
      this.getStore().load({params:{member_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:member_search_scope] || :member_search
    data_class.send(search_scope, params && params[:member_search] || '').scoping do
      super
    end
  end
end
