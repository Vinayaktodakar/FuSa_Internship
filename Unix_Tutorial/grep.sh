# grep used to find word or line from file 

# to find particular word from file
$  grep '<word>' <file_name>
# Uses
$  grep "Linux" final.txt

#  Exact Word Match
#  To find "Linux" only as a whole word (avoiding matches like "LinuxOS"), use the -w flag
$   grep -w "Linux" final.txt

#    Case-Insensitive Search
#    To find "linux", "Linux", or "LINUX", use the -i flag
$    frep -i '<word>' <file_name>
$    grep -i "Linux" final.txt

#    Show Line Numbers: 
#    To see which line the word appears on, use the -n flag
$    grep -n '<word>' <file_name>
$    grep -n "Linux" final.txt

#    Count Occurrences: 
#    To see how many lines contain the word, use the -c flag
$    grep -c '<word>' <file_name>
$    grep -c "Linux" final.txt


# -B 2 -A 2 : Show 2 lines Before and After the matching line
grep -B 2 -A 2 "Linux" <filename>
