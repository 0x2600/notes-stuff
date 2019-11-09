4. 检索数据
select * from products;
select prod_name, prod_id, prod_price from products;
select products.prod_id from crashcourse.products;
select prod_id from products limit 4 offset 3;
select distinct vend_id from products;

5. 排序检索数据
select prod_name from products order by prod_name;

# 按非选择数据排序
select prod_name from products order by prod_price; 

select prod_id, prod_name, prod_price from products order by prod_price desc, prod_name;

# 注意 from, order by, limit 语句顺序
select prod_price from products order by prod_price desc limit 1;  


6. 过滤数据
select prod_name, prod_price from products where prod_price = 2.5;

# where 在 order by 之前， where, order by
where 子句操作符:
= <> != < <= > >= BETWEEN

# 不区分大小写， Fuses 与 fuses 匹配
select prod_name, prod_price from products where prod_name = 'fuses'; 

select prod_name, prod_price from products where prod_price between 10 and 2.5;

# IS NULL;
select cust_id, cust_name from customers where cust_email IS NULL;

7. 数据过滤
select prod_id, prod_name, prod_price, vend_id from products where vend_id=1003 and prod_price < 10;

select prod_id, prod_name, prod_price, vend_id from products where vend_id=1003 or vend_id=1002;

# 括号改变顺序
select prod_id, prod_name, prod_price, vend_id from products where prod_price >= 10 and (vend_id=1003 or vend_id=1002);

# IN 与 OR 操作符类似
select prod_id, prod_name, prod_price, vend_id from products where vend_id in (1002,1003);

select prod_id, prod_name, prod_price, vend_id from products where vend_id not in (1002,1003);

8. 用通配符进行过滤

# LIKE 与 %(0, 1, 多个字符，不匹配 NULL)
select prod_name from products where prod_name LIKE 'jet%';

# _ (匹配单个字符)

9. 用正则表达式进行搜索
# REGEXP， . 匹配任意一个字符
select prod_name from products where prod_name regexp '.000';

# BINARY 区分大小写
select prod_name from products where prod_name regexp binary 'JetPack .000';
# | 或
select prod_name from products where prod_name regexp '1000|2000';
# 匹配几个字符之一
select prod_name from products where prod_name regexp '[123] ton';
与下式相等:
MariaDB [crashcourse]> select prod_name from products where prod_name regexp '[1|2|3] ton';
+-------------+
| prod_name   |
+-------------+
| 1 ton anvil |
| 2 ton anvil |
+-------------+
2 rows in set (0.000 sec)

MariaDB [crashcourse]> select prod_name from products where prod_name regexp '1|2|3 ton';
+---------------+
| prod_name     |
+---------------+
| 1 ton anvil   |
| 2 ton anvil   |
| JetPack 1000  |
| JetPack 2000  |
| TNT (1 stick) |
+---------------+
5 rows in set (0.001 sec)

# [0-9] [a-z]

# 匹配 ., 使用 \\., \\-, \\|, \\[, \\], \\\, 或者引用元字符 \\f, \\n, \\r, \\t, \\v
select vend_name from vendors where vend_name regexp '\\.';
+--------------+
| vend_name    |
+--------------+
| Furball Inc. |
+--------------+
1 row in set (0.000 sec)

# 匹配字符串

[:alnum:] [a-zA-Z0-9]
[:alpha:]
[:blank:] 空格和制表符
[:cntrl:] ASCII 0-31, 127
[:digit:]
[:graph:] [:print:]
[:lower:]
[:space:] fnrtv
[:upper:]
[:xdigit:] [0-9a-fA-F]
[:punct:] 不在[:alnum:]，也不在[:cntrl:]

重复元字符
* 0或多个
+ 1或多个
? 0或1
{n}
{n,}
{n,m}

select prod_name from products where prod_name regexp '\\([0-9] sticks?\\)';
+----------------+
| prod_name      |
+----------------+
| TNT (1 stick)  |
| TNT (5 sticks) |
+----------------+
2 rows in set (0.001 sec)


select prod_name from products where prod_name regexp '[[:digit:]]{4}';
+--------------+
| prod_name    |
+--------------+
| JetPack 1000 |
| JetPack 2000 |
+--------------+
2 rows in set (0.001 sec)

# 定位元字符

^ 文本的开头
$ 文本的结尾
[[:<:]] 词的开头
[[:>:]] 词的结尾

select 'Hello' regexp '[[:alpha:]]';

10. 创建计算字段

# 拼接字段

select Concat(vend_name, '(', vend_country,')') from vendors order by vend_name desc;
+------------------------------------------+
| Concat(vend_name, '(', vend_country,')') |
+------------------------------------------+
| LT Supplies(USA)                         |
| Jouets Et Ours(France)                   |
| Jet Set(England)                         |
| Furball Inc.(USA)                        |
| Anvils R Us(USA)                         |
| ACME(USA)                                |
+------------------------------------------+

# RTrim 删除右侧多余空白， LTrim, Trim
select Concat(RTrim(vend_name), '(', RTrim(vend_country),')') from vendors order by vend_name desc;
+--------------------------------------------------------+
| Concat(RTrim(vend_name), '(', RTrim(vend_country),')') |
+--------------------------------------------------------+
| LT Supplies(USA)                                       |
| Jouets Et Ours(France)                                 |
| Jet Set(England)                                       |
| Furball Inc.(USA)                                      |
| Anvils R Us(USA)                                       |
| ACME(USA)                                              |
+--------------------------------------------------------+


# AS 别名

select Concat(RTrim(vend_name), '(', RTrim(vend_country),')') as vend_title from vendors order by vend_name desc;
+------------------------+
| vend_title             |
+------------------------+
| LT Supplies(USA)       |
| Jouets Et Ours(France) |
| Jet Set(England)       |
| Furball Inc.(USA)      |
| Anvils R Us(USA)       |
| ACME(USA)              |
+------------------------+


select prod_id, quantity, item_price, quantity*item_price as expanded_price from orderitems where order_num= 20005;
+---------+----------+------------+----------------+
| prod_id | quantity | item_price | expanded_price |
+---------+----------+------------+----------------+
| ANV01   |       10 |       5.99 |          59.90 |
| ANV02   |        3 |       9.99 |          29.97 |
| TNT2    |        5 |      10.00 |          50.00 |
| FB      |        1 |      10.00 |          10.00 |
+---------+----------+------------+----------------+

# + - * /

11. 使用数据处理函数

# 文本处理函数

Upper()
Left() 
Length()
Locate()
Lower()
LTrim()
Right()
RTrim()
Soundex()
SubString()


select vend_name, Upper(vend_name) as vend_name_upper from vendors;
+----------------+-----------------+
| vend_name      | vend_name_upper |
+----------------+-----------------+
| Anvils R Us    | ANVILS R US     |
| LT Supplies    | LT SUPPLIES     |
| ACME           | ACME            |
| Furball Inc.   | FURBALL INC.    |
| Jet Set        | JET SET         |
| Jouets Et Ours | JOUETS ET OURS  |
+----------------+-----------------+

# 日期和时间处理函数

select cust_id, order_num,order_date from orders where order_date='2005-09-01';
+---------+-----------+---------------------+
| cust_id | order_num | order_date          |
+---------+-----------+---------------------+
|   10001 |     20005 | 2005-09-01 00:00:00 |
+---------+-----------+---------------------+

select cust_id, order_num,order_date from orders where Date(order_date) BETWEEN '2005-09-01' and '2005-09-30';
+---------+-----------+---------------------+
| cust_id | order_num | order_date          |
+---------+-----------+---------------------+
|   10001 |     20005 | 2005-09-01 00:00:00 |
|   10003 |     20006 | 2005-09-12 00:00:00 |
|   10004 |     20007 | 2005-09-30 00:00:00 |
+---------+-----------+---------------------+

# 数值处理函数

Abs()
Cos()
Exp()
Mod()
Pi()
Rand()
Sin()
Sqrt()
Tan()

12. 汇总数据

# SQL 聚集函数
AVG()
COUNT()
MAX()
MIN()
SUM()

select AVG(prod_price) as prod_price_avg from products;
+----------------+
| prod_price_avg |
+----------------+
|      16.133571 |
+----------------+

select AVG(prod_price) from products where vend_id=1003;
+-----------------+
| AVG(prod_price) |
+-----------------+
|       13.212857 |
+-----------------+

# COUNT(*) 包含 NULL 值, COUNT(column) 不包含 NULL 值
select COUNT(*) from products;
+----------+
| COUNT(*) |
+----------+
|       14 |
+----------+

select MAX(prod_price) as max_price from products;
+-----------+
| max_price |
+-----------+
|     55.00 |
+-----------+

select MIN(prod_price) as min_price from products;
+-----------+
| min_price |
+-----------+
|      2.50 |
+-----------+

select SUM(quantity) from orderitems where order_num=20005;
+---------------+
| SUM(quantity) |
+---------------+
|            19 |
+---------------+

select AVG(DISTINCT prod_price) from products where vend_id=1003;
+--------------------------+
| AVG(DISTINCT prod_price) |
+--------------------------+
|                15.998000 |
+--------------------------+

select COUNT(*), MAX(prod_price), MIN(prod_price), AVG(prod_price) from products;
+----------+-----------------+-----------------+-----------------+
| COUNT(*) | MAX(prod_price) | MIN(prod_price) | AVG(prod_price) |
+----------+-----------------+-----------------+-----------------+
|       14 |           55.00 |            2.50 |       16.133571 |
+----------+-----------------+-----------------+-----------------+

13. 分组数据

# GROUP 位于 where 之后， order 之前
select vend_id, COUNT(*) as num_pord from products group by vend_id;
+---------+----------+
| vend_id | num_pord |
+---------+----------+
|    1001 |        3 |
|    1002 |        2 |
|    1003 |        7 |
|    1005 |        2 |
+---------+----------+

# HAVING 过滤分组
select vend_id, COUNT(*) as num_pord from products group by vend_id with rollup HAVING COUNT(*) > 2;
+---------+----------+
| vend_id | num_pord |
+---------+----------+
|    1001 |        3 |
|    1003 |        7 |
|    NULL |       14 |
+---------+----------+
HE
# select 子句顺序

select, from, where, group by, having, order by, limit


14. 使用子查询

select cust_name, cust_state, (select COUNT(*) from orders where orders.cust_id = customers.cust_id ) as orders from customers ;
+----------------+------------+--------+
| cust_name      | cust_state | orders |
+----------------+------------+--------+
| Coyote Inc.    | MI         |      2 |
| Mouse House    | OH         |      0 |
| Wascals        | IN         |      1 |
| Yosemite Place | AZ         |      1 |
| E Fudd         | IL         |      1 |
+----------------+------------+--------+

15. 联结表
# 等值联结: WHERE, 没有 WHERE 迪卡儿积

# 内部联结
select vend_name, prod_name, prod_price from vendors INNER JOIN products ON vendors.vend_id = products.vend_id;
+-------------+----------------+------------+
| vend_name   | prod_name      | prod_price |
+-------------+----------------+------------+
| Anvils R Us | .5 ton anvil   |       5.99 |
| Anvils R Us | 1 ton anvil    |       9.99 |
| Anvils R Us | 2 ton anvil    |      14.99 |
| LT Supplies | Fuses          |       3.42 |
| LT Supplies | Oil can        |       8.99 |
| ACME        | Detonator      |      13.00 |
| ACME        | Bird seed      |      10.00 |
| ACME        | Carrots        |       2.50 |
| ACME        | Safe           |      50.00 |
| ACME        | Sling          |       4.49 |
| ACME        | TNT (1 stick)  |       2.50 |
| ACME        | TNT (5 sticks) |      10.00 |
| Jet Set     | JetPack 1000   |      35.00 |
| Jet Set     | JetPack 2000   |      55.00 |
+-------------+----------------+------------+

# 联结多个表
select prod_name, vend_name, prod_price, quantity from orderitems, products, vendors where products.vend_id=vendors.vend_id and orderitems.prod_id=products.prod_id and order_num=20005;
+----------------+-------------+------------+----------+
| prod_name      | vend_name   | prod_price | quantity |
+----------------+-------------+------------+----------+
| .5 ton anvil   | Anvils R Us |       5.99 |       10 |
| 1 ton anvil    | Anvils R Us |       9.99 |        3 |
| TNT (5 sticks) | ACME        |      10.00 |        5 |
| Bird seed      | ACME        |      10.00 |        1 |
+----------------+-------------+------------+----------+

16. 创建高级联结

# 自联结
# 引子，子查询

select vend_id,prod_id, prod_name from products where vend_id=(select vend_id from products where prod_id='DTNTR');
+---------+---------+----------------+
| vend_id | prod_id | prod_name      |
+---------+---------+----------------+
|    1003 | DTNTR   | Detonator      |
|    1003 | FB      | Bird seed      |
|    1003 | FC      | Carrots        |
|    1003 | SAFE    | Safe           |
|    1003 | SLING   | Sling          |
|    1003 | TNT1    | TNT (1 stick)  |
|    1003 | TNT2    | TNT (5 sticks) |
+---------+---------+----------------+

# 使用自联结

select p1.vend_id,p1.prod_id, p1.prod_name from products as p1, products as p2 where p1.vend_id=p2.vend_id and p2.prod_id='DTNTR';
+---------+---------+----------------+
| vend_id | prod_id | prod_name      |
+---------+---------+----------------+
|    1003 | DTNTR   | Detonator      |
|    1003 | FB      | Bird seed      |
|    1003 | FC      | Carrots        |
|    1003 | SAFE    | Safe           |
|    1003 | SLING   | Sling          |
|    1003 | TNT1    | TNT (1 stick)  |
|    1003 | TNT2    | TNT (5 sticks) |
+---------+---------+----------------+

# 使用自然联结

# 外部联结

17. 组合查询

# UNION
# 使用 WHERE
select prod_price, prod_id, prod_name,vend_id from products where vend_id in (1001,1002) or prod_price <=5;    
+------------+---------+---------------+---------+
| prod_price | prod_id | prod_name     | vend_id |
+------------+---------+---------------+---------+
|       5.99 | ANV01   | .5 ton anvil  |    1001 |
|       9.99 | ANV02   | 1 ton anvil   |    1001 |
|      14.99 | ANV03   | 2 ton anvil   |    1001 |
|       2.50 | FC      | Carrots       |    1003 |
|       3.42 | FU1     | Fuses         |    1002 |
|       8.99 | OL1     | Oil can       |    1002 |
|       4.49 | SLING   | Sling         |    1003 |
|       2.50 | TNT1    | TNT (1 stick) |    1003 |
+------------+---------+---------------+---------+
8 rows in set (0.001 sec)

# 使用 UNION
MariaDB [crashcourse]> select prod_price, prod_id, prod_name,vend_id from products where vend_id in (1001,1002) UNION select prod_price, prod_id, prod_name,vend_id from products where prod_price <=5;
+------------+---------+---------------+---------+
| prod_price | prod_id | prod_name     | vend_id |
+------------+---------+---------------+---------+
|       5.99 | ANV01   | .5 ton anvil  |    1001 |
|       9.99 | ANV02   | 1 ton anvil   |    1001 |
|      14.99 | ANV03   | 2 ton anvil   |    1001 |
|       3.42 | FU1     | Fuses         |    1002 |
|       8.99 | OL1     | Oil can       |    1002 |
|       2.50 | FC      | Carrots       |    1003 |
|       4.49 | SLING   | Sling         |    1003 |
|       2.50 | TNT1    | TNT (1 stick) |    1003 |
+------------+---------+---------------+---------+
8 rows in set (0.008 sec)

# UNION ALL

select prod_price, prod_id, prod_name,vend_id from products where vend_id in (1001,1002) UNION ALL select prod_price, prod_id, prod_name,vend_id from products where prod_price <=5;
+------------+---------+---------------+---------+
| prod_price | prod_id | prod_name     | vend_id |
+------------+---------+---------------+---------+
|       5.99 | ANV01   | .5 ton anvil  |    1001 |
|       9.99 | ANV02   | 1 ton anvil   |    1001 |
|      14.99 | ANV03   | 2 ton anvil   |    1001 |
|       3.42 | FU1     | Fuses         |    1002 |
|       8.99 | OL1     | Oil can       |    1002 |
|       2.50 | FC      | Carrots       |    1003 |
|       3.42 | FU1     | Fuses         |    1002 |
|       4.49 | SLING   | Sling         |    1003 |
|       2.50 | TNT1    | TNT (1 stick) |    1003 |
+------------+---------+---------------+---------+
9 rows in set (0.001 sec)

# 对组合查询结果排序， ORDER BY 出现在最后一条 SELECT 语句之后


18. 全文本搜索

MyISAM 支持， InnoDB 不支持
CREATE TABLE productnotes
(
    note_id int NOT NULL AUTO_INCREMENT,
    prod_id char(10) NOT NULL,
    note_date datetime NOT NULL,
    note_text text NULL,
    PRIMARY KEY(note_id),
    
)ENGINE=MyISAM;

select note_text from productnotes where Match(note_text) Against('rabbit');
+----------------------------------------------------------------------------------------------------------------------+
| note_text                                                                                                            |
+----------------------------------------------------------------------------------------------------------------------+
| Customer complaint: rabbit has been able to detect trap, food apparently less effective now.                         |
| Quantity varies, sold by the sack load.
All guaranteed to be bright and orange, and suitable for use as rabbit bait. |
+----------------------------------------------------------------------------------------------------------------------+

# Match 选择列， Against选择文本， 搜索不区分大小写，除非 BINARY 方式

19. 插入数据

# 插入完整的行

# 危险
insert into customers values(NULL, 'gary', NULL,NULL,NULL,NULL,NULL,NULL,NULL);
Query OK, 1 row affected (0.009 sec)

# 安全
insert into customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip,cust_country,cust_contact,cust_email) values(NULL, 'Gary2', NULL,NULL,NULL,NULL,NULL,NULL,NULL);


# INSERT SELECT 语句, 复制操作
insert into customers(cust_id, cust_name, cust_country, cust_city, cust_state,cust_zip, cust_contact, cust_email, cust_address) select cust_id, cust_name, cust_country, cust_city, cust_state,cust_zip, cust_contact, cust_email, cust_address from custnew;

20. 更新和删除数据
WHERE 子句

# UPDATE
update customers set cust_email='test@suse.lan' where cust_id=10007;
更新多个列, 逗号分开多个列
update customers set cust_name= 'Gary3', cust_email='test1@suse.lan' where cust_id=10007;
DELETE 删除表的内容而不是表
DELETE from customers where cust_id=10007;
更快地删除表中所有行， 删除表并重新建立表
TRUNCATE table

21. 创建和操纵表
CREATE TABLE table1
(
    cust_id int NOT NULL AUTO_INCREMENT,
    cust_name char(50) NOT NULL,
    cust_address char(50) NULL,
    PRIMARY KEY(cust_id)
) ENGINE=InnoDB;

desc table1;
+--------------+----------+------+-----+---------+----------------+
| Field        | Type     | Null | Key | Default | Extra          |
+--------------+----------+------+-----+---------+----------------+
| cust_id      | int(11)  | NO   | PRI | NULL    | auto_increment |
| cust_name    | char(50) | NO   |     | NULL    |                |
| cust_address | char(50) | YES  |     | NULL    |                |
+--------------+----------+------+-----+---------+----------------+
NULL 不等于 '' 空串
主键单列，或多列组合唯一，主键中只能使用不允许 NULL 值的列。
每个表只允许一个 AUTO_INCREMENT 列，而且必须被索引， 如使之成为主键

指定默认值, 常量， 比使用 NULL 值更好
quantity int NOT NULL DEFAULT 1,

引擎类型
外键不能跨引擎， 使用一个引擎的表不能引用具有使用不同引擎的表的外键

更新表的定义， ALTER TABLE

desc vendors;
+--------------+----------+------+-----+---------+----------------+
| Field        | Type     | Null | Key | Default | Extra          |
+--------------+----------+------+-----+---------+----------------+
| vend_id      | int(11)  | NO   | PRI | NULL    | auto_increment |
| vend_name    | char(50) | NO   |     | NULL    |                |
| vend_address | char(50) | YES  |     | NULL    |                |
| vend_city    | char(50) | YES  |     | NULL    |                |
| vend_state   | char(5)  | YES  |     | NULL    |                |
| vend_zip     | char(10) | YES  |     | NULL    |                |
| vend_country | char(50) | YES  |     | NULL    |                |
+--------------+----------+------+-----+---------+----------------+
7 rows in set (0.001 sec)

MariaDB [crashcourse]> alter table vendors add vend_phone CHAR(20);
Query OK, 0 rows affected (0.010 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [crashcourse]> desc vendors;
+--------------+----------+------+-----+---------+----------------+
| Field        | Type     | Null | Key | Default | Extra          |
+--------------+----------+------+-----+---------+----------------+
| vend_id      | int(11)  | NO   | PRI | NULL    | auto_increment |
| vend_name    | char(50) | NO   |     | NULL    |                |
| vend_address | char(50) | YES  |     | NULL    |                |
| vend_city    | char(50) | YES  |     | NULL    |                |
| vend_state   | char(5)  | YES  |     | NULL    |                |
| vend_zip     | char(10) | YES  |     | NULL    |                |
| vend_country | char(50) | YES  |     | NULL    |                |
| vend_phone   | char(20) | YES  |     | NULL    |                |
+--------------+----------+------+-----+---------+----------------+
8 rows in set (0.001 sec)

ALTER TABLE vendors DROP COLUMN vend_phone;

ALTER TABLE 定义外键










