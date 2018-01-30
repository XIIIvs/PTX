class SimpleClass:
    def function(self, x=3, a=6, b=9):
        for i in range(10):
            print i+i
            for k in range(2):
                print i+k
        if x == 1:
            return a
        return b
 
obj = SimpleClass()
kek = obj.function(x=5)
print kek
