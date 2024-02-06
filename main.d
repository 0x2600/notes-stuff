import std.stdio;

void main()
{
    writeln("hello d");
    bool ok = true;
    byte b = 1;
    ubyte ub = 2;
    char ch = 'a';

    short s = 200;
    float f = 999.0f;

    float *pf = &f;
    int *pi = new int(10);

    immutable double d = 998.1;
    const char[] word = "Hello there";

    if (*pi == 10)
    {
        writeln("pi is 10");
    }

    // switch (s) {
    //     case 1..201:
    //         writeln("in 1..201");
    //         break;
    // }
    auto add(int a, int b)
    {
        return a + b;
    }

    struct People {
        int age;
        string name;
        this(int age, string name) {
            this.age = age;
            this.name = name;
            writeln("People constructed");
        }
        void greet(string who) {
            doGreet(who);
        }
        private void doGreet(string who) {
            writeln("Hello, Mrs.", who);
        }
    }
    auto p = People(20, "Mike");
    p.greet("Bill");

    int[] arr = [1,2,3];
    arr[] *= 2;
    auto slice = arr[0..2];
    slice[$-1] = 10;
    foreach (ele; slice)
    {
        writeln("the slice element is ", ele);
    }
    foreach (i; 0..20)
    {
        //writeln("call 20 times");
    }
    foreach(i,e; arr) {

    }
    foreach_reverse(ele;[1,2,3]) {
        
    }
    alias MyString = immutable(char)[];
    MyString ms = "Hello";
    writeln("my string is ", ms);
  
    struct Fib {
        int a = 1;
        int b = 1;

        enum empty = false;
        int front() const @property {
            return a;
        }
        void popFront()
        {
            auto t = a;
            a = b;
            b = t + b;
        }
    }
    // Fib fib;
    // import std.range: drop, take;
    // import std.algorithm.iteration: filter, sum;
    // auto fib10 = fib.take(10);
    // writeln("fib 10 ", fib10);

    // auto fib5 = fib.drop(5);
    // writeln("fib 5 ", fib5);

    // writeln("fib 5 even ", fib5.filter!(x => x % 2 == 0));

    int[string] map;
    map["key1"] = 1;
    if ("key1" in map) {

    }
    if (auto pv = "key1" in map) {
        *pv = 2;
        writeln(map["key1"]);
    }
    class Foo {
        void greet() {
            writeln("hello from Foo");
        }
    }
    auto foo = new Foo();
    foo.greet();
    interface Animal {
        void makeNoise();
        final doubleNoise() {
            foreach (i;0..2) {
                makeNoise();
            }
        }
    }
    class Dog : Animal {
        final void makeNoise() {
            writeln("wang");
        }
    }
    new Dog().doubleNoise();

    auto addGeneric(T)(T a, T b) {
        return a + b;
    }

    auto c = addGeneric!int(1,2);
    void doSomething(int delegate(int, int) doer) {
        doer(1,2);
    }
    doSomething(&add);
    auto add2 = (int a, int b) => a + b;
    writeln(add2(1,3));
    //writeln([1,2,3].reduce!`a*b`);

    class GAnimal(string noise) {
        void make() {
            writeln(noise ~ "!");
        }
    }
    class GDog: GAnimal !("Woof") {

    }
    auto gdog=new GDog();
    gdog.make();
}

