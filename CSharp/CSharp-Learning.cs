using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    class Program
    {
        static void Main_(string[] args)
        {
            ArrayList list_ = new ArrayList() { 1, 2, 100, 10 };
            list_.Sort(new CompareImpl());
            foreach(var i in list_)
            {
                Console.WriteLine(i);
            }

            Queue q_ = new Queue();
            q_.Enqueue(100);
            q_.Enqueue("test");
            IEnumerator it = q_.GetEnumerator();
            while(it.MoveNext())
            {
                Console.WriteLine(it.Current);
            }
            Stack st = new Stack();
            st.Push(100);
            st.Push("test");
            while(st.Count != 0)
            {
                Console.WriteLine(st.Pop());
            }

            Hashtable hash_ = new Hashtable();
            hash_.Add(1, "test hash");
            hash_.Add(2, "test hash 2");
            foreach(DictionaryEntry i in hash_)
            {
                Console.WriteLine(i.Key.ToString() + i.Value.ToString());
            }
            if(hash_.Contains(1))
            {
                Console.WriteLine(hash_[1]);
            }
            System.Nullable<int> a = null;
            if (!a.HasValue)
            {
                Console.WriteLine("No value");
            }
            Add(1.2, 2.1);

            List<Student> stu_ = new List<Student>();
            stu_.Add(new Student(3, "stu1"));
            stu_.Add(new Student(2, "stu2"));
            //stu_.Sort();
            stu_.Sort(new StudentList());
            foreach(Student stu in stu_)
            {
                Console.WriteLine(stu.ToString());
            }

            DriveInfo[] di = DriveInfo.GetDrives();
            foreach(var i in di)
            {
                Console.WriteLine(i.ToString());
            }

            DirectoryInfo di_ = new DirectoryInfo("C:/Code");
            di_.Create();
            di_.CreateSubdirectory("code-01");
            di_.CreateSubdirectory("code-02");
            IEnumerable<DirectoryInfo> di__ = di_.EnumerateDirectories();
            foreach(var i in di__)
            {
                Console.WriteLine(i.FullName);
            }
            di_.Delete(true);

            Console.WriteLine(Directory.GetCurrentDirectory());
            //Directory.CreateDirectory("C:/code");
            //File.Create("C:/code/test.cs");

            

            StreamWriter sw = new StreamWriter("C:/TEST/code.cs");
            sw.WriteLine("小王");
            sw.WriteLine("155");
            sw.Flush();
            sw.Close();

            StreamReader sr = new StreamReader("C:/TEST/code.cs");
            while (sr.Peek() != -1)
            {
                Console.WriteLine(sr.ReadLine());
            }
            sr.Close();

            FileStream fs = new FileStream("C:/TEST/code.cs", FileMode.Append);
            byte bValue = 65;
            fs.WriteByte(bValue);
            fs.Flush();
            fs.Close();
            bValue = 0;
            fs = new FileStream("C:/TEST/code.cs", FileMode.Open);
            fs.Seek(-1, SeekOrigin.End);
            int iValue = fs.ReadByte();
            Console.WriteLine(iValue);

            MyDelegate dele_ = new MyDelegate(Foo.foo);
            dele_ += new Foo().bar;
            dele_ -= new Foo().bar;
            dele_();

            MyDelegate2 dele__ = new MyDelegate2(Foo.Add);
            Console.WriteLine(dele__(1000));

            MyDelegate dele___ = delegate
            {
                Console.WriteLine("anonymous delegate");
            };
            dele___();
            Console.ReadKey();
        }
        public delegate void MyDelegate();

        public delegate int MyDelegate2(int a);
        public static void Add<T>(T a, T b)
        {
            double sum = double.Parse(a.ToString()) + double.Parse(b.ToString());
            Console.WriteLine(sum);
        }

        static void Main(string[] args)
        {
            Program et = new Program();
            et.SayEvent = new SayDelegate(Program.sayHello);
            et.TriggerEvent();

            ClassA inst = new ClassA();
            inst.MyEvent += new ClassA.MyDelegate(ClassA.Do1);
            inst.MyEvent += new ClassA.MyDelegate(ClassA.Do2);
            inst.trigger();

            Console.ReadKey();
        }

        public static void sayHello()
        {
            Console.WriteLine("Say hello");
        }

        public delegate void SayDelegate();
        public event SayDelegate SayEvent;
        public void TriggerEvent()
        {
            SayEvent();
        }
    }
    class ClassA
    {
        public delegate void MyDelegate();
        public event MyDelegate MyEvent;
        public static void Do1()
        {
            Console.WriteLine("Do 1");
        }

        public static void Do2()
        {
            Console.WriteLine("Do 2");
        }

        public void trigger()
        {
            MyEvent();
        }
    }
    class Foo
    {
        public static void foo()
        {
            Console.WriteLine("Hello delegate");
        }
        public void bar()
        {
            Console.WriteLine("Hello delegate instance method");
        }

        public static int Add(int a)
        {
            return a + 1;
        }
    }
    class CompareImpl : IComparer
    {
        public int Compare(object o1, object o2)
        {
            return o1.ToString().CompareTo(o2.ToString());
        }
    }
    class StudentList: IComparer<Student>
    {
        public int Compare(Student a, Student b)
        {
            if (((Student)a).Id > ((Student)b).Id)
            {
                return 1;
            }
            return -1;
        }
    }
    class Student: IComparable<Student>
    {
        public int Id { set; get; }
        public string Name { set; get; }
        public override string ToString()
        {
            return Id.ToString() + " " + Name;
        }
        public Student(int id_, string name_)
        {
            Id = id_;
            Name = name_;
        }

        public int CompareTo(Student t)
        {
            if (this.Id >= t.Id)
            {
                return 1;
            }
            else
            {
                return -1;
            }
        }
    }
}
