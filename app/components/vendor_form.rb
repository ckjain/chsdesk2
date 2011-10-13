class VendorForm < Netzke::Basepack::PagingFormPanel
  js_property :title, "vendor Paging Form With Custom Layout And File Upload"

  def default_config
    super.merge(:model => "Vendor")
  end

  def configuration

    super.tap do |s|
      s[:file_upload] = true
      s[:items] = [
        {
          :layout => :hbox, :border => false,
          :items => [
            {:flex => 1, :border => false, :defaults => {:anchor => "-8"}, :items => [
            {:name => :vendor_name, :field_label => 'Name'},
            {:name => :service_type, :field_label => 'Type of Service',:renderer => "capitalize"},
            {:name => :contact_name, :field_label => 'Contact Person',:renderer => "capitalize" },
            {:name => :vendor_phone, :field_label => 'Phone'},
            {:name => :vendor_email, :field_label => 'Email'},
            {:name => :address,:field_label => 'Address'},
            {:name => :vendor_city,:field_label => 'City'},
            {:name => :vendor_state,:field_label => 'State'},
            {:name => :is_recurring, :field_label => 'Is recurring?'},
            {:name => :image_link, :field_label => "Download Link",:xtype => :displayfield, :getter => lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}},
            {:name => :image, :field_label => "Upload Business Card", :xtype => :fileuploadfield, :getter => lambda {|r| ""}, :display_only => true},
            {:name => :image_profile_link, :field_label => "Download Link",:xtype => :displayfield, :getter => lambda {|r| %Q(<a href='#{r.image_profile.url}'>Download</a>) if r.image_profile.url}},
            {:name => :image_profile, :field_label => "Upload Company Profile", :xtype => :fileuploadfield, :getter => lambda {|r| ""}, :display_only => true}
             ]},
            {:flex => 1, :border => false, :defaults => {:anchor => "100%"}, :items => [
            {:name => :tds_rate, :align => 'right',:format =>'0.00', :field_label => 'TDS Rate'},
            {:name => :service_tax_rate, :align => 'right',:format =>'0.00', :field_label => 'Service Tax Rate'},
            {:name => :stax_reg_number,  :field_label => 'S.tax No.'},
            {:name => :pan_number, :field_label => 'PAN No'},
            {:name => :vat_number,  :field_label => 'VAT No'},
            {:name => :section_code,:field_label => 'Section Code'},
            {:name => :vendor_country,:field_label => 'Country'},
            {:name => :vendor_pincode,:field_label => 'Pincode'},
            {:name => :payee_name, :field_label => 'Payee Name'},
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