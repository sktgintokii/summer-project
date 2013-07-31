#!/bin/bash

file="network.dot"
dpi=300

printf "\n=============================================\n"
printf "Launching \"$0\"...\n\n"
# Remove existing file if any 
if [ -f $file ]; then
	printf "File $file already exists! Removing $file automatically...\n"
	rm -rf $file
	sleep 1
fi

# Create and initialize file
printf "Creating file \"$file\"...\n"
printf "\n----------------------------------------------\n\n"
touch $file
sleep 1
printf "strict digraph network{\n\tgraph [ dpi = $dpi ];\n" >> $file

for i in $(seq 11 12); do
		for j in $(seq 73 80); do
			site="137.189.$i.$j"
			ping -c1 -W1 ${site} &> /dev/null
			if [ "$?" == "0" ]; then
				str="$(traceroute -P ICMP $site |
					sed 's/).*$/)/g' | sed 's/^.*\ \ //g' |
					grep -v '*' | sed 's/\ //' | sed 's/(/\\n(/g' | 
					grep "137.189.\|hkix")"

				printf "\t" >> "$file"
				printf "Writing result of IP: \033[38;5;148m$site\033[39m to file ($file) ...\n\n"
				echo \"$str | sed 's/\ /\"\ ->\ \"/g' | sed 's/$/\";/g' >> $file
			else
				printf "Cannot ping \033[38;5;148m$site\033[39m. Not tracing this IP\n\n"
			fi
				
		done
done

printf "}\n" >> $file

printf "Generating output file \"network.png\"...\n"
circo network.dot -T png -o network.png
if [ "$?" -ne "0" ]; then
	echo Unexpected error occurs
	exit 1
fi

printf "Sucessfully gernerate file\n"
printf "File saved under \"`pwd`\"\\\n"


printf "\n--------------------------------------------\n"
printf "Program terminates...\n"
printf "\n=============================================\n"
