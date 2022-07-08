classdef Adder
   properties
      NumericData
   end
   methods
      function obj = Adder(val)
         obj.NumericData = val;
      end
      function r = plus(obj1,obj2)
         a = double(obj1);
         b = double(obj2);
         r = Adder(a + b);
      end
      function d = double(obj)
         d = obj.NumericData;
      end
      function tf = lt(obj1,obj2)
         if obj1.NumericData < obj2.NumericData
            tf = true;
         else
            tf = false;
         end
      end
   end
end