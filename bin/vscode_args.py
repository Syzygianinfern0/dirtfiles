import sys
arg = " ".join(sys.argv[1:])
print('"' + '",\n"'.join(arg.split(" ")) + '"')
