#include "show.h"
#include <stdio.h>

void show(Student *stu)
{
	printf("%s id: %d, height: %f\n", stu->name, stu->no, stu->height);
}
