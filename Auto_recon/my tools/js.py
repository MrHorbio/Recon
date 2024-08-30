from bs4 import BeautifulSoup
import requests

with open("js.txt", "r") as f:
    urls = f.read().split()

# Create an empty list to store the contents of all URLs
all_contents = []

for url in urls:
    response = requests.get(url)
    
    # Check if the request was successful (status code 200) and if the content type is HTML
    if response.status_code == 200 and 'text/html' in response.headers.get('content-type', ''):
        soup = BeautifulSoup(response.content, "html.parser")
        all_contents.append(soup)
    else:
        print(f"Failed to fetch content from {url}")

# Combine all the contents into one string
combined_content = "\n".join(str(content) for content in all_contents)

# Write the combined content to index.html
with open("index.html", "w") as f:
    f.write(combined_content)
