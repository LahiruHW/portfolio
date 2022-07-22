def char_num(char):									# O(1)
	return ord(char.lower())


print(char_num("z"))

# check if string 'a' can be converted into string 'b' by only
# 		deleting letters
#		 chaging letter cases

def abbreviation(a, b) -> str:
	invalid_count = 0
	change_count = 0
	delete_count = 0

	i = 0 ; j = 0
	while True:
		
		if ord(a[i].lower()) == ord(b[i].lower()):
			print("EQUAL LETTER:", a[i], b[i], end=" ----->")
			
			if ord(a[i]) > ord(b[j]): print("change", a[i], "to uppercase!")
			elif ord(a[i]) < ord(b[j]): print("change", a[i], "to lowercase!")
			
			i += 1 ; j += 1
		elif ( ord(a[i].lower()) != ord(b[i].lower()) ) and (len(a) == len(b)):
			print("INVALID CHARACTER DETECTED")
			return "NO"

		elif ( ord(a[i].lower()) != ord(b[i].lower()) ) and (len(a) != len(b)):
			delete_count += 1
			i += 1
		else:
			i += 1 ; j += 1		

a = "AbcDE"
b = "ABDE"

print( abbreviation(a, b) )