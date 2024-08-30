#!/bin/bash


# Check for user argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1 
fi 

domain="$1"
wordlist="wordlist.txt"

# Check domain existence using ping
if ping -c 1 "$domain" &> /dev/null; then
    echo "$domain exists 😁"

else
    echo "🤬Domain $domain is unreachable or doesn't exist or check you internet connection🤬"
    exit 1  # Exit script if domain is unreachable
fi



# Directory to store the recon results
recon_dir="Recon"
uniq="uniq.txt"
live="live.txt"

# Create Recon directory if it doesn't exist 
if [ ! -d "$recon_dir" ]; then
    mkdir "$recon_dir"
    echo "📂Created directory: $recon_dir"
    echo
fi



#running tools 
echo "🫷This operation may take some time to complete🫸 " 
echo
echo "🔎 Finding Subdomains......🔍"


#Subdomain enumeration tools
echo "subfinder...."
subfinder -d "$domain" -o "$recon_dir/subfinder.txt" &> /dev/null 
echo "sublist3r.."
sublist3r -d "$domain" -o "$recon_dir/sublist3r.txt" &> /dev/null 
echo "findomain......"
findomain -t "$domain" -w "$wordlist" -u "$recon_dir/findomain.txt" &> /dev/null 

wait 

#echo msg after completion
echo "🔥save subdomains sucessfully👍"



#combine file and remove duplicates
echo "removing duplicates...🫨...🫨...🫨" 

cat $recon_dir/subfinder.txt $recon_dir/sublist3r.txt $recon_dir/findomain.txt  | anew "$recon_dir/$uniq" &> /dev/null 
 


#Ask for save files 
read -p "Do you want to delete previous files subfinder.txt, sublist3r.txt, findomain.txt? 🤔(Y/n): " opt

#convert opt to lowercase for case-insensitive comparison

opt=${opt,,}

if [ "$opt" = "n" ]; then
   echo "Files are available in $recon_dir/subfinder.txt, $recon_dir/sublist3r.txt, $recon_dir/findomain.txt"
   
else
    rm -f "Recon/subfinder.txt" "Recon/sublist3r.txt" "Recon/findomain.txt"
    echo "👻Files are deleted👻"
    echo

fi













