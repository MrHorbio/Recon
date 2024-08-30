import socket
import re

with open("domain.txt", "r") as f:
    domains = f.read().split()

with open("ip.txt", "a") as f:
    for domain in domains:
        cleaned_url = re.sub(r'https?://|/$', '', domain)  # Clean the URL
        ip_address = socket.gethostbyname(cleaned_url)  # Get IP address
        f.write(ip_address + "\n")  # Write IP address to file
