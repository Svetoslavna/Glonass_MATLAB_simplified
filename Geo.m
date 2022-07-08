classdef Geo
    
    properties
        prop
    end
    
    methods
        function obj = Geo(value)
            obj.prop = value;
        end
        function pl = plus(test_point)

           pl.s = test_point + p.test_point;
        end
        function mnog = mnogit(test_point)

           mnog.s = test_point * p.test_point;
        end
    end
end

