#############################################

# Purpose:- To Check the File system space
# Date:- 19-01-2019
############################################

#!/bin/bash

host=`hostname`


function check_FS {
        Filesystems=($(df -hP | awk '{print $6}'| grep -v tmpfs | grep -v Mounted | grep -v /run/user ))
        Useper=($(df -hP | awk '{print $5}' | grep -v Use))
        len=${#Filesystems[@]}

        # Creating the html

        echo "<html>" 
                echo "<body>"
                        echo "<table border="1" width="600">" 
                                echo "<tr>" 
                                        echo "<th bgcolor="orange">Server</th>"
                                        echo "<th bgcolor="orange">File System</th>"
                                        echo "<th bgcolor="orange">Use %</th>" 
                                        echo "<th bgcolor="orange">Status</th>"
                                echo "</tr>" 

        for (( i=0; i<$len; i++ ))
        do
                                echo "<tr>" 
                                        echo "<td>$host</td>"
                                        echo "<td>${Filesystems[i]}</td>"
                                        echo "<td>${Useper[i]}</td>" 
                peruse=${Useper[i]}
                peruse=${peruse%?}
                #echo $peruse
                if [ $peruse -le 94 ] && [ $peruse -ge 90 ]
                then
                                        echo "<td bgcolor="#FFF200">WARNING</td>"
                elif [ $peruse -gt 95 ]
                then
                                        echo "<td bgcolor="#FF0000">ALERT</td>"
                else
                                        echo "<td bgcolor="#00FF00">OK</td>" 
                fi
                                        echo "</tr>"
        done
                                        echo "</table>" 
                                        echo "</body>"
                                        echo "</html>" 


}


check_FS
