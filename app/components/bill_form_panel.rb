class BillForm < Netzke::Basepack::PagingFormPanel
  js_property :title, "bill Paging Form With Custom Layout And File Upload"

  def default_config
    super.merge(:model => "Bill")
  end

  def configuration
    bill_contact = [
      {:field_label => "net_amount", :name => :bill_detail__head, :read_only => true},
      {:field_label => "Last name", :name => :bill_detail__head, :read_only => true},
    ]

    bill_details = [
      {:field_label => "Salary", :name => :bill_detail__service_tax, :read_only => true},
      {:field_label => "Amount of bills", :name => :bill_detail__gross_amount, :read_only => true}
    ]

    super.tap do |s|
      s[:file_upload] = true
      s[:items] = [
        {
          :layout => :hbox, :border => false,
          :items => [
            {:flex => 1, :layout => :form, :border => false, :defaults => {:anchor => "-8"}, :items => [
              :maintenance_charges,
              :other_charges,
              {:name => :image_link, :xtype => :displayfield, :display_only => true, :getter => lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}},
              {:name => :image, :field_label => "Upload image", :xtype => :fileuploadfield, :getter => lambda {|r| ""}, :display_only => true}
            ]},
            {:flex => 1, :layout => :form, :border => false, :defaults => {:anchor => "100%"}, :items => [
              :penalty_interest,
           ]}
          ]
        },
        {
          :xtype => :fieldset, :title => "bill info",
          :items => [
            {
              :xtype => :tabpanel, :padding => 5, :plain => true, :active_tab => 0,
              :items => [
                {:title => "Contact", :layout => :form, :items => bill_contact},
                {:title => "Details", :layout => :form, :items => bill_details}
              ]
            }
          ]
        }
      ]
    end
  end

  def netzke_submit_endpoint(params)
    # ::Rails.logger.debug "!!! params: #{params.inspect}\n"
    super
  end
end