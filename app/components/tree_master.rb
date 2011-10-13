class TreeMaster < Netzke::Basepack::SimpleApp

  # Initial layout of the app.
  # <tt>status_bar_config</tt>, <tt>menu_bar_config</tt>, and <tt>main_panel_config</tt> are defined in SimpleApp.
  def configuration
    sup = super
    sup.merge(
      :items => [{
        :region => :north,
        :tbar => nil,
        :border => false,
        :height => 93,
      },{
        :region => :center,
        :layout => :border,
        :border => false,
        :items => [status_bar_config, {
          :region => :center,
          :layout => :border,
          :items => [menu_bar_config, main_panel_config, {

            # Navigation
            :region => :west,
            :width => 200,
            :split => true,
            :xtype => :treepanel,
            :title => "Navigation",
            :root_visible => false,
            :item_id => :navigation,
            :root => {
              :text => "Navigation",
              :expanded => true,
              :children => [{
                :text => "Society Master",
                :expanded => true,
                :children => [{
                  :text => "Main Setup",
                  :expanded => true,
                  :children => [{
                    :text => "Society Info",
                    :icon => uri_to_icon(:user_suit),
                    :leaf => true,
                    :component => "society_search_grid_panel"
                  },{
                   :text => "Members",
                    :icon => uri_to_icon(:user),
                    :leaf => true,
                    :component => "member_search_grid_panel"
                  },{
                   :text => 'Assign Unit to Member',
                    :leaf => true,
                    :component => "member_property_inspector"
                  },{
                     
                        :text => "Unit Setup",
                        :expanded => true,
                        :children => [{
                        :text => "Units",
                        :icon => uri_to_icon(:user),
                        :leaf => true,
                        :component => "unit_search_grid_panel",
                      },{
                        :text => "Type of Units",
                        :icon => uri_to_icon(:user),
                        :leaf => true,
                        :component => "unit_type_search_grid_panel"
                      },{
                        :text => "Bill Setup",
                        :icon => uri_to_icon(:user),
                        :leaf => true,
                        :component => "bill_setup_search_grid_panel"}]}]
               
 
                },{
                  :text => "Office Setup",
                  :expanded => true,
                  :children => [{
                    :text => "Managing Committee ",
                    :icon => uri_to_icon(:user),
                    :leaf => true,
                    :component => "mc_search_grid_panel"
                  },{
 
                    :text => "Staff Inspector",
                    :icon => uri_to_icon(:user),
                    :leaf => true,
                    :component => "staff_inspector"
                  },{
                    :text => "Vendors",
                    :icon => uri_to_icon(:user),
                    :leaf => true,
                    :component => "vendor_inspector"
                  }]
                }]
              }]
            }
          }]
        }]
      }]
    )
  end

  # Components
  component :society_search_grid_panel
  component :unit_search_grid_panel
  component :member_search_grid_panel
  component :unit_type_search_grid_panel
  component :member_property_inspector
  component :mc_search_grid_panel
  component :bill_setup_search_grid_panel
  component :vendor_inspector,:border => false, :title => "Vendor Inspector"
  component :staff_inspector, :border => false, :title => "Staff Inspector"

  # A simple panel thit will render a page with links to different Rails views that have embedded widgets in them

  # Overrides SimpleApp#menu

  js_method :on_about, <<-JS
    function(e){
      var msg = [
        '',
        'Source code for this demo: <a href="https://github.com/skozlov/netzke-demo">GitHub</a>.',
        '', '',
        '<div style="text-align:right;">Why follow <a href="http://twitter.com/nomadcoder">NomadCoder</a>?</div>'
      ].join("<br/>");

      Ext.Msg.show({
        width: 300,
         title:'About',
         msg: msg,
         buttons: Ext.Msg.OK,
         animEl: e.getId()
      });
    }
  JS

  # Overrides Ext.Component#initComponent to set the click event on the nodes
  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.navigation = this.query('panel[itemId="navigation"]')[0];
      this.navigation.getView().on('itemclick', function(e,r,i){
        if (r.raw.component) {
          this.appLoadComponent(r.raw.component);
        }
      }, this);
    }
  JS

  # Overrides SimpleApp#process_history, to initially select the node in the navigation tree
  js_method :process_history, <<-JS
    function(token){
      if (token) {
        var node = this.navigation.getStore().getRootNode().findChildBy(function(n){
          return n.raw.component == token;
        }, this, true);

        if (node) this.navigation.getView().select(node);
      }

      this.callParent([token]);
    }
  JS

end
