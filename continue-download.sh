while read a; read b; read c; read d; read e; do wget -c $c -O $b$e$d$a; echo $c; done < list1.xml
while read a; read b; read c; read d; read e; do wget -c $c -O $b$e$d$a; echo $c; done < list2.xml
