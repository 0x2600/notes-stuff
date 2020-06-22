#ifndef _SHOW_H__
#define _SHOW_H__
typedef struct{
	int no;
	char name[64];
	float height;
}Student;

void show(Student *);
#endif // SHOW_H
