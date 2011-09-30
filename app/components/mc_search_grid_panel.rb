
class McSearchGridPanel < ::Netzke::Basepack::GridPanel
  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'mc_search_field',
    :enable_key_events => true,
    :ref => '../mc_search_field',
    :empty_text => 'Search'
  }],
      :persistence => true,
      :border =>false,
      :header => false, 
      :width => 820, :height => 350,
      :title => 'Manage Committee Detail',
      :model => "CommitteeMember",
      :bbar =>  [:add.action, :edit.action, :apply.action, :del.action],
      :columns => [ 
      {:name => :designation, :width => 130,:label => 'Designation',:renderer => "uppercase" },
      {:name => :member__member_name, :width => 240,:label => 'Member Name',:renderer => "uppercase" },
      {:name => :signatory, :width => 80,:label => 'Is Signatory?' },
      {:name => :elected, :width => 60,:label => 'Elected ?', :tooltip => "Select box if member is elected/Un select if member is nominated"},
      {:name => :mc_start_date, :format => "d/m/y",:width => 100,:label => 'Committee In date',:tooltip => "The date when member became committe member"},
      {:name => :mc_end_date, :format => "d/m/y",:width => 110,:label => 'Committee Out date',},
      {:name => :duty, :width => 100, :label => 'Duty'}, ]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.mcSearchBuffer = '';
      this.down('#mc_search_field').on('keydown', function() {this.onMcSearch(); }, this, { buffer: 500 });
      this.down('#mc_search_field').on('blur', function() {this.onMcSearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_mc_search, <<-JS
    function() {

      var search_text = this.down('#mc_search_field').getValue();
      if (search_text == this.mcSearchBuffer) return;
      this.mcSearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('mc_search', search_text);
      this.getStore().load({params:{mc_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:mc_search_scope] || :mc_search
    data_class.send(search_scope, params && params[:mc_search] || '').scoping do
      super
    end
  end

end
