
class SocietySearchGridPanel < ::Netzke::Basepack::GridPanel
      action :show_details, :text => "Show details"

  config :tbar => ['->', {
    :xtype => 'textfield',
    :id => 'society_search_field',
    :enable_key_events => true,
    :ref => '../society_search_field',
    :empty_text => 'Search'
  }],
   :persistence => true,
   :header => false, 
   :title => 'Manage Society Detail',
   :model => "Society",
    :bbar =>  [:show_details.action, "-",:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action], 
   :columns => [ 
    {:name => :society_name, :width => 160, :label => 'Society Name', :renderer => "capitalize"},
    {:name => :number_of_flats, :width => 90, :label => 'Total no of Flats'},
    {:name => :society_address_line1, :width => 100, :label => 'Address line-1', :renderer => "capitalize"},
    {:name => :society_address_line2, :width => 100, :label => 'Address line-2', :renderer => "capitalize"},
    {:name => :society_city, :width => 100, :label => 'City', :renderer => "capitalize"},
    {:name => :society_state, :width => 100, :label => 'State', :renderer => "capitalize"},
    {:name => :society_country, :width => 100, :label => 'Country', :renderer => "capitalize"},
    {:name => :society_pincode, :width => 100,  :label => "Pincode"},
    {:name => :govt_address_line1, :width => 100, :label => 'Address line-1', :renderer => "capitalize"},
    {:name => :govt_address_line2, :width => 100, :label => 'Address line-2', :renderer => "capitalize"},
    {:name => :govt_address_city, :width => 100, :label => 'Government City', :renderer => "capitalize"},
    {:name => :govt_address_pincode, :width => 100, :label => 'Government Pincode'},
    {:name => :govt_address_plotnumber, :width => 100, :label => 'Plotnumber'},
    {:name => :registration_number, :width => 100, :label => 'Registration Number'},
    {:name => :govt_ward_number, :width => 100, :label => 'Ward Number'},
    {:name => :active, :width => 100, :label => 'Is Active ?'},]


  js_method :init_component, <<-JS
    function() {
      #{js_full_class_name}.superclass.initComponent.call(this);
      
      this.societySearchBuffer = '';
      this.down('#society_search_field').on('keydown', function() {this.onSocietySearch(); }, this, { buffer: 500 });
      this.down('#society_search_field').on('blur', function() {this.onSocietySearch(); }, this, { buffer: 500 });
    }
  JS

  js_method :on_society_search, <<-JS
    function() {

      var search_text = this.down('#society_search_field').getValue();
      if (search_text == this.societySearchBuffer) return;
      this.societySearchBuffer = search_text;
      this.getStore().proxy.extraParams = ('society_search', search_text);
      this.getStore().load({params:{society_search: search_text,start:0,limit:10}});
    }
  JS

  def get_data(*args)
    params = args.first
    search_scope = config[:society_search_scope] || :society_search
    data_class.send(search_scope, params && params[:society_search] || '').scoping do
      super
    end
  end

end
