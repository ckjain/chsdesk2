{

    initComponent: function(params)
    {
        // Define the model
        Ext.define(this.id, {
          extend: 'Ext.data.Model',
          idProperty: this.pri, // Primary key
          fields: [{
                    name: 'age',
                    type: 'int'
                    },
                    {
                    name: 'staff_salary',
                    type: 'float'
                    }]
        });
 
       var store = new Ext.data.Store({
                            model: this.id,
                            proxy: {
                                type: 'direct',
                                directFn: Netzke.providers[this.id].getData,
                                reader: {
                                    type: 'json',
                                    root: 'staff'
                                }
                            },
                            autoLoad: true
        });
        this.store = store;
        
        Netzke.classes.MyChart.superclass.initComponent.call(this);
    }
}
