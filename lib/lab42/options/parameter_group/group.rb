module Lab42
  class Options
    class ParameterGroup
      class Group

        def element element_name, options=nil
          @group_container << [ element_name, options ].compact
        end

        private
        def initialize group_name, group_container
          @group_name      = group_name
          group_container.update group_name => []
          @group_container = group_container[ group_name ]
        end
        
      end # class Group
    end # class ParameterGroup
  end # class Options
end # module Lab42
