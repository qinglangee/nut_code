for dirname in '100x100/' '140x140/' '300x300/' '590x590/'
do
for a in '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'a' 'b' 'c' 'd' 'e' 'f'
do
	for b in '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'a' 'b' 'c' 'd' 'e' 'f'
	do
		mkdir -p $dirname$a$b
		chmod 777 $dirname$a$b
	done
done
done
