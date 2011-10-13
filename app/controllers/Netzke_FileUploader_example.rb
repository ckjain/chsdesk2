module Netzke
  class FileUploader < FormPanel
    INITIAL_UPLOAD_FIELDS_NUMBER = 5

    # Extra javascripts
    def self.include_js
      [
        "#{File.dirname(__FILE__)}/file_uploader_extras/file_uploader.js"
      ]
    end
    
    def actions
      super.merge( 
        :more => {:text => "More!", :icon => "/images/icons/add.png", :cls => "x-btn-text-icon"}, 
        :done => {:text => "Submit", :icon => "/images/icons/accept.png", :cls => "x-btn-text-icon"} 
      )
    end
    
    def default_config
      orig = super
      orig[:ext_config][:bbar] = ['more', 'done']
      orig[:columns] = INITIAL_UPLOAD_FIELDS_NUMBER.times.map do |i|
        {
          :xtype => 'filewithtype', 
          :name => "file_#{i}", 
          :file_types => @passed_config[:file_types], 
          :default_file_type => @passed_config[:doctype]
        }
      end
      orig[:ext_config][:header] = false
      orig[:ext_config][:record_id] = @passed_config[:record_id] # pass recordId to javascript instance
      
      orig[:persistent_config] = false
      
      orig
    end
    
    def js_config
      super.merge({
        :file_types => config[:file_types],
        :default_file_type => config[:doctype]
      })
    end
    
    def self.js_extend_properties
      {
        :file_upload => true,
        :initial_upload_fields_number => INITIAL_UPLOAD_FIELDS_NUMBER,
        :label_width => 100,
        :defaults => {
          :hide_label => true
        },
        
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);
            // Fires when the file upload was successuf (no HTML errors)
            this.addEvents('submitsuccess');
          }
        END_OF_JAVASCRIPT
        
        :on_done => <<-END_OF_JAVASCRIPT.l,
          function(){
            // Not a Netzke's standard API call, because the form is multipart
            this.getForm().submit({
              url: this.buildApiUrl("netzke_submit"),
              params: {
                record_id: this.recordId
              },
              success: function(form, action){
                this.fireEvent('submitsuccess');
              },
              failure: function(form, action){
                this.feedback("Upload failed");
              },
              scope: this
            });
          }
        END_OF_JAVASCRIPT
        
        :on_more => <<-END_OF_JAVASCRIPT.l,
          function(){
            if (!this.currentFieldsNumber) this.currentFieldsNumber = this.initialUploadFieldsNumber;
            ++this.currentFieldsNumber;
            this.add({name:"file_"+this.currentFieldsNumber, xtype:'filewithtype', fileTypes: this.fileTypes, defaultFileType: this.defaultFileType});
            this.doLayout();
          }
        END_OF_JAVASCRIPT
      }
    end
    
  end
end