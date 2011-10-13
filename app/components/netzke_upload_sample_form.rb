class Netzke::UploadSampleForm < ::Netzke::Basepack::FormPanel
        #
    # Endpoints
    #
        endpoint :netzke_submit do |params|
                data = ActiveSupport::JSON.decode(params[:data])
                success = create_or_update_record(data)

                if success
                        filename = params[:staff_photo].path
                        user = Staff.find(params[:id] || params['id'])
                        File.move(filename, user.upload_dir)
                end

                if success
                        x = {:set_form_values => values, :set_result => "ok"}
                        {:set_form_values => values, :set_result => "ok"}
                else
                        # flash eventual errors
                        @record.errors.each_full do |msg|
                                flash :error => msg
                        end
                        {:feedback => @flash}
                end
        end

        def self.include_js
                [
                        "#{File.dirname(__FILE__)}/javascript/FileUploadField.js"
                ]
        end

        def config
                {
                        :model => 'Staff',
                        :file_upload => true,
                        :bbar => false,
                        :tbar => false,
                        :fields => [
                                :staff_name, :staff_email,
                                { :name => :joining_date, :format => I18n.translate('ext.date', :default => 'Y-m-d') },
                                { :name => :staff_photo, :xtype => 'fileuploadfield' }
                        ]
                }.deep_merge super
        end
end 