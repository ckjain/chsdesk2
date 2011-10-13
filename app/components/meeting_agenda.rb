class MeetingAgenda < Netzke::Basepack::BorderLayoutPanel
  js_property :header, false

  def configuration
    super.merge(
      :persistence => true,
      :items => [
        :meetings.component(
          :region => :center,
          :width => 300,
          :title => "Meetings"
        ),
        :agenda_meeting_mamber_grid.component(
          :region => :east,
          :width => 300,
          :split => true,
          :title => "Attending Members"
        ),
        :meeting_type_grid.component(
          :region => :west,
          :width => 300,
          :split => true,
          :title => "Meeting Type"

        ),
        :agendas.component(
          :region => :south,
          :title => "Agendas",
          :height => 250,
          :split => true
        )
      ]
    )
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
      function(){
      // calling superclass's initComponent
      this.callParent();
      
      // setting the 'rowclick' event
      var view = this.getComponent('meetings').getView();
      view.on('itemclick', function(view, record){

      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectMeeting({meeting_id: record.get('id')});
      this.getComponent('agendas').getStore().load();
      this.getComponent('agenda_meeting_mamber_grid').getStore().load();
      }, this);
      }
  JS

  endpoint :select_meeting do |params|
    # store selected boss id in the session for this component's instance
    component_session[:selected_meeting_id] = params[:meeting_id]
  end

  component :meetings do
    {
      :class_name => "Basepack::GridPanel",
      :bbar =>  [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action], 
      :model => "Meeting",
            :columns => [
      {:name => :meeting_date, :format => "d-m-y", :width => 80,:label => 'Meeting date'},
      {:name => :meeting_time, :width => 80,:label => 'Meeting time'},
      {:name => :meeting_type__types, :width => 120,:label => 'Meeting type'},
      {:name => :called_by, :width => 120,:label => 'Called By'},
      {:name => :updated_bulb, :width => 40,:label => "<div class='bulb-off' />", :tooltip => "Recently updated",
          :getter => lambda { |r| bulb = r.updated ? "on" : "off"
            "<div class='bulb-#{bulb}' />" }},
    ]

    }
  end

  component :agendas do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :height => 250,
      :bbar =>  [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action,:add_in_form.action, :edit_in_form.action], 
      :model => "Agenda",
      :load_inline_data => false,
      :scope => {:meeting_id => component_session[:selected_meeting_id]},
      :strong_default_attrs => {:meeting_id => component_session[:selected_meeting_id]},
            :columns => [
      {:name => :agenda, :width => 400,:label => 'Agenda Items'},
      {:name => :resolution, :width => 445,:label => 'Resolution Items'},
      {:name => :proposed_by,:label => "proposed_by" },
      {:name => :seconded_by,:label => "seconded_by" },
      {:name => :updated_bulb, :width => 40,:label => "<div class='bulb-off' />", :tooltip => "Recently updated",
          :getter => lambda { |r| bulb = r.updated_agenda ? "on" : "off"
            "<div class='bulb-#{bulb}' />" }},
    ]

    }
  end

  component :agenda_meeting_mamber_grid do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :bbar =>  [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action,], 
      :model => "MeetingMember",
      :load_inline_data => false,
      :scope => {:meeting_id => component_session[:selected_meeting_id]},
      :strong_default_attrs => {:meeting_id => component_session[:selected_meeting_id]},
           :columns => [
      {:name => :member__member_name, :width => 180,:label => 'Attending members'},
      {:name => :committee_member__member_id, :width => 180,:label => 'Attending Committe members'}

      ]

    }
  end
  component :meeting_type_grid do
      {:class_name => "Netzke::Basepack::GridPanel",
      :bbar =>  [:add.action, "-", :edit.action, "-", :apply.action, "-", :del.action,], 
      :model => "MeetingType",
       :columns => [
      {:name => :types, :width => 150,:label => 'Type Name',:renderer => "capitalize" },
      {:name => :updated_bulb, :width => 50,:label => "<div class='bulb-off' />", :getter => lambda { |r| bulb = r.updated_meeting ? "on" : "off"
            "<div class='bulb-#{bulb}' />"}},

      ]

 }
  end
  
end