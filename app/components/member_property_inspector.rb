# Displays a grid panel on the left, and the form on the right. When a row in the grid panel is clicked, the form panel dynamically loads the corresponding record.
class MemberPropertyInspector < Netzke::Basepack::BorderLayoutPanel

  component :member_find
  component :assign_search_grid_panel 

  def default_config
    super.tap do |c|
      c[:items] = [
        :member_find.component(:region => :west, :width => 245, :split => true, :title => "Select Member ID"),
        :assign_search_grid_panel.component(:region => :center, :title => "Assign Member to Unit")
      ]
    end
  end

end