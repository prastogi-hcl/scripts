######################################################################
## Purpose = To Create JVM ThreadPool Data Table View

## Note - No Changes Required
######################################################################
#!/bin/bash
#######################
## All Script Variable
#######################
. /u02/vfnl/oss/prdaua01/scripts/Script/ScriptVar
Product=$1
#####################################
## Function To Create Output In Table
#####################################
Table()
{
col=`cat $Temp_Dir/$JVM_Thread | head -1 | awk -F"|" "{ print NF }"`
row=`cat $Temp_Dir/$JVM_Thread |wc -l`
count=0
echo "<table border=1 width='auto' class='table-class'>"
while read line
do
	count=$(($count + 1))
	if (( $count == 1))
	then
		echo "<tr bgcolor="#ff6600">"
	else
		echo "<tr>"
	fi
for ((columns=1; columns<=$col; columns++))
do
	out=`echo $line|awk -F"|" -v i="$columns" '{print $i}'`
	Check $columns $count "$out" $2
done
	echo "</tr>"
done < $Temp_Dir/$JVM_Thread
echo "</table>"
}

#####################################
## Function To Keep Checks On Data
#####################################
Check()
{
	if (( $1==5 && $2 > 1))
	then
		if [[ "$3" == "$JVM_Health_OK" ]]
		then
			echo "<td bgcolor="#00FF00">$3</td>"
		elif [[ "$3" == "$JVM_Health_Warn" ]]
		then
			echo "<td bgcolor="#f4a742">$3</td>"
			WARN_COUNT=$(($WARN_COUNT + 1))
		else
			echo "<td bgcolor="#FF0000">$3</td>"
			ERROR_COUNT=$(($ERROR_COUNT + 1))
		fi
	elif (( $1==1 || $1==3 || $1==5 || $1==6 || $1==12 || $1==13 && $2>1 ))
        then
                echo "<td>$out</td>"
	elif (( $1==1 || $1==3 || $1==5 || $1==6 || $1==12 || $1==13 && $2==1 ))
	then
		echo "<td>$out</td>"
	fi
}
################################
## Main Function Table Is Called
################################
Table
echo $Product ThreadPool $ERROR_COUNT $WARN_COUNT >> $Trouble_File
