# mkdir used for creating new directory 
$   mkdir <directory_name> 


# cd --> change directory 
$   cd <directory_name>

# touch --> create empty file 
$   touch <file_name with extension>

#vi it is inbuilt text editior 
$    vi  <file_name>

#cat -- it will display content present in file  from top to buttom 
$    cat <file_name>

# tac -- it will display content present in file  from buttom to top
$    tac <file_name>

# cp -- copy the file or directory from one directory to another or same directory 
$    cp <source_file> <desination_file_with_directory>

#mv -- rename the filename 
$    mv <source_file_name> <destination_file_name>

# chmod  -- change mode to user(owner)/group/other for perticular file/directory
# for all mode read-write-execute to enable it we have give it as 1 or else make 0 
# for example user rwx=111 then we have code in octal as 7 similarly 
# -rwx------ 1 vinay vinay 17 Jan 24 15:30 final.txt  -- this example say user all three access but group and other don't have it 
# -rw-r--r-- 1 vinay vinay 17 Jan 24 15:29 test1.txt  -- this example says user has access read and write , group has only read and ohter has aslo read 
$    chmod 700 <file_name>  # it says given only user not for all
$    chmod 705 <file_name>  #  it says given access for both user and ohter read and execute , and write is for only write
