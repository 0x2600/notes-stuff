class A:
    def __init__(self):
        print("en A\n", 'le A')

class B(A):
    def __init__(self):
        print("en B")
        super().__init__()
        print("le B")

class C(A):
    def __init__(self):
        print("en C")
        super().__init__()
        print("le C")

class D(B, C):
    def __init__(self):
        print("en D")
        super().__init__()
        print("le D")

if __name__ == "__main__":
    d = D()

'''
en D
en B
en C
en A
 le A
le C
le B
le D

'''