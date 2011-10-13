  class MyChart < Netzke::Base
    # Our JS class will be inherited from Ext.chart.Chart
    js_base_class "Ext.chart.Chart"


    js_mixin :my_chart
    include Netzke::Basepack::DataAccessor

    js_properties :title => 'Simple Chart', :width => 800, :height => 600
    
    def js_config #:nodoc:
      super.merge({
        :animate => true,
         :model => config[:model],
         :pri => data_class.primary_key,
        :axes => [{
                    :type => 'Numeric',
                    :position => 'left',
                    :fields => ['staff_salary'],
                    :title => 'Sample Values',
                    :grid => true,
                    :minimum => 0
                }, {
                    :type => 'Category',
                    :position => 'bottom',
                    :fields => ['age'],
                    :title => 'Sample Metrics'
                }],

                 :series => [{
                     :type => 'column',
                     :axis => 'left',
                     :gutter => 80,
                     :stacked => true,
                    :xField => 'age',
                    :yField => 'staff_salary'
                 }]

     })
    end


  endpoint :get_data do |params|
    staff = data_class.all()
    staff.map do |s|
      {:age => s.age, :staff_salary => s.staff_salary}
    end
  end
end
