class StaffForm < Netzke::Basepack::PagingFormPanel
  js_property :title, "staff Paging Form With Custom Layout And File Upload"

  def default_config
    super.merge(:model => "Staff")
  end

  def configuration

    super.tap do |s|
      s[:file_upload] = true
      s[:items] = [
        {
          :layout => :hbox, :border => false,
          :items => [
            {:flex => 1, :border => false, :defaults => {:anchor => "-8"}, :items => [
            {:name => :staff_name, :field_label => 'Name'},
            {:name => :staff_email, :field_label => 'Email'},
            {:name => :staff_current_address,:field_label => 'Current Address'},
            {:name =>  :active},
            {:name => :image_link, :xtype => :displayfield, :display_only => true, :getter => lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}},
            {:name => :image, :field_label => "Upload image", :xtype => :fileuploadfield, :getter => lambda {|r| ""}, :display_only => true}
            ]},
            {:flex => 1, :border => false, :defaults => {:anchor => "100%"}, :items => [
            {:name => :staff_category, :field_label => 'Designation'},
            {:name => :staff_salary, :field_label => 'Salary'},
            {:name => :staff_permanent_address,:field_label => 'Permanent Address'},
            {:name => :joining_date},
            {:name => :society__society_name, :field_label => 'Society Name'}
            ]}
          ]
        },
      ]
    end
  end

  def netzke_submit_endpoint(params)
    # ::Rails.logger.debug "!!! params: #{params.inspect}\n"
    super
  end
end