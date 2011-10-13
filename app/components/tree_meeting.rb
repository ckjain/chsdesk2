class TreeMeeting < Netzke::Basepack::SimpleApp

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
            :width => 180,
            :split => true,
            :xtype => :treepanel,
            :title => "Navigation",
            :root_visible => false,
            :item_id => :navigation,
            :root => {
              :text => "Navigation",
                :expanded => true,
                :children => [{
                  :text => "Meetings",
                  :expanded => true,
                  :children => [{
                    :text => "Meetings",
                    :icon => uri_to_icon(:user_suit),
                    :leaf => true,
                    :component => "meeting_agenda"
                  },{
                   :text => 'Meeting Types',
                    :leaf => true,
                    :component => "meeting_type_grid"
              
 
               }]
            }]
            }
          }]
        }]
      }]
    )
  end

  # Components
  component :meeting_agenda
  component :meeting_type_grid
  # A simple panel thit will render a page with links to different Rails views that have embedded widgets in them

  # Overrides SimpleApp#menu



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
