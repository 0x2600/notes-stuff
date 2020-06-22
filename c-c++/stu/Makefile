# main1 动态链接版本
# main 静态链接版本

main1: main.o show1.so
	gcc -o main1 main.o show1.so 
main: show.a main.o
	gcc -o main main.o show.a
show1.so: show1.o
	gcc -shared show1.o -o show1.so
show.a: show.o
	ar -rc show.a show.o
show1.o: source/show.c include/show.h
	gcc -o show1.o -Iinclude -c source/show.c -fpic
show.o: source/show.c include/show.h
	gcc -Iinclude -c source/show.c -o show.o
main.o: source/main.c include/show.h
	gcc -c -Iinclude source/main.c -o main.o
run: main
	./main
run1: main1
	sudo cp show1.so /lib64
	./main1
clean:
	rm *.o *.a *.so main main1 /lib64/show1.so 2>/dev/null
