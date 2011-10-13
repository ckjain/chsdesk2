class TreeBilling < Netzke::Basepack::SimpleApp

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
            :title => "BillNavigation",
            :root_visible => false,
            :item_id => :navigation,
            :root => {
              :children => [{
                :text => "Billing",
                :expanded => true,
                :children => [{
                  :text => "Bills",
                  :icon => uri_to_icon(:user_user_suit),
                  :leaf => true,
                  :component => "bill_search_grid_panel",
                },{
                  :text => "Bill Header",
                  :icon => uri_to_icon(:user),
                  :leaf => true,
                  :component => "bill_header_search_grid_panel"
                },{
                  :text => "Bill Verification",
                  :icon => uri_to_icon(:user),
                  :leaf => true,
                  :component => ""
                },{
                  :text => "Bill Finalise and send",
                  :icon => uri_to_icon(:user),
                  :leaf => true,
                  :component => ""
                  }]
            }]
            }
          }]
        }]
      }]
    )
  end

  # Components
  component :bill_header_search_grid_panel
  component :bill_search_grid_panel

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
