class SimpleClass
    def function(x=3, a=6, b=9)
        for i in 0..10
            puts i+i
            for k in 0..2
                puts i+k
                end
            end
        if x == 1
            return a
            end
        return b
        end
    end
end
 
obj = SimpleClass()
kek = obj.function(x=5)
puts kek

