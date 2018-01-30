class SimpleClass
    def function(x=3, a=6, b=9)
        for i in 0..10
            puts i+i
            for k in 0..2
                puts i+k
        if x == 1
            return a
        return b
 
obj = SimpleClass()
kek = obj.function(x=5)
puts kek

