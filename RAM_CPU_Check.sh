#######################################################

# Purpose:- To monitor the CPU, Load Average, RAM Usage
# Date:- 19-01-2019
########################################################


#!/bin/bash

cpu=($(sar -P ALL 1 1 | grep Average | awk 'NR!=1 {print $2}'))
peruser=($(sar -P ALL 1 1 | grep Average | awk 'NR!=1 {print $3}'))
persys=($(sar -P ALL 1 1 | grep Average | awk 'NR!=1 {print $5}'))
perio=($(sar -P ALL 1 1 | grep Average | awk 'NR!=1 {print $6}'))
perdile=($(sar -P ALL 1 1 | grep Average | awk 'NR!=1 {print $8}'))

function sar_repo {
        echo "<html>" 
                echo "<body>" 
                        echo "<table border="1" width="600">" 
                                echo "<tr>" 
                                        echo "<th bgcolor="orange">cpu</th>" 
                                        echo "<th bgcolor="orange">%user</th>"
                                        echo "<th bgcolor="orange">%system</th>"
                                        echo "<th bgcolor="orange">%iowait</th>" 
                                        echo "<th bgcolor="orange">%idle</th>"
                                echo "</tr>" 
        i=0
        len=${#cpu[@]}
                while [ $i -lt $len ]
                do
                                                                echo "<tr>" 
                                                                                echo "<td>${cpu[$i]}</td>"
                                                                                echo "<td>${peruser[$i]}</td>" 
                                                                                echo "<td>${persys[$i]}</td>"
                                                                                echo "<td>${perio[$i]}</td>"
                                                                                echo "<td>${perdile[$i]}</td>"
                                                                echo "</tr>"
                                i=`expr $i + 1`
                done
                                                                echo "</table>" 

}

function mem_cal {

        memtot=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
        memfree=`cat /proc/meminfo | grep MemFree | awk '{print $2}'`
        output=`echo $(echo "$memfree/$memtot" | bc -l )`
        permemfree=$(echo "$output * 100" | bc -l )
        permemfree=`echo "($memfree/$memtot)*100" | bc -l |cut -c 1-5`

        echo "<br><br>" 

        echo "<table border="1" width="600">" 
                                echo "<tr>"
                                        echo "<th bgcolor="orange">Total Mem</th>" 
                                        echo "<th bgcolor="orange">Free Memory</th>" 
                                        echo "<th bgcolor="orange">% Free Memory</th>" 
                                        echo "<th bgcolor="orange">Health</th>" 
                                echo "</tr>" 
                                echo "<tr>" 
                                        echo "<th>$memtot</th>"
                                        echo "<th>$memfree</th>" 
                                        echo "<th>$permemfree</th>"
                #echo $permemfree
                if [ $( printf "%.0f" $permemfree ) -lt 10 ]
                then
                                        echo "<th bgcolor="#FF0000">BAD</th>" 
                else
                                        echo "<th bgcolor="#00FF00">OK</th>"
                fi
                                echo "</tr>" 
                                echo "</table>"
                                echo "</body>" 
                                echo "</html>" 
}



sar_repo
mem_cal
