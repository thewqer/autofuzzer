#!/bin/bash
line='-----------------'
echo $line
echo -e "
  /  _  \  __ ___/  |_  _____/ ____\_ __________________ ___________ 
 /  /_\  \|  |  \   __\/  _ \   __\  |  \___   /\___   // __ \_  __ \
/    |    \  |  /|  | (  <_> )  | |  |  //    /  /    /\  ___/|  | \/
\____|__  /____/ |__|  \____/|__| |____//_____ \/_____ \\___  >__|   
        \/                                    \/      \/    \/       
                                                                -by @wqer"
echo $line
echo 'use -h for help'
echo $line
echo 'Specify the target name:'
read target
echo $line
mkdir $target

if [ $1 = '-h' ]
then
echo -e "HELP\n $line \nsyntax of tool:\n bash autofuzzer.sh [DOMAIN_LIST] [WORDLIST]" 
echo $line
fi

linenum=`wc -l $1 | awk '{print $1;}'`
for i in $linenum
do
   echo "Running ffuf on $i subdomains"
done
echo $line

for ((i = 0 ; i<=$linenum ; i++));
do
    domain=`sed -n "${i}p" $1`
    echo "Running ffuf for the $i. time"
   ffuf -u https://$domain/FUZZ  -w $2 -o $target/domain$i.txt ||ffuf -u http://$domain/FUZZ  -w $2 -o $target/domain$i.txt || echo "invalid domain" 
done

echo $line
echo "Cleaning up and finishing"
cd $target 
find . -type f -size 0 -exec rm {} \;



