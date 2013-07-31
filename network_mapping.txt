network_mapping
==============
The very first version
Authur: Felix Yau
Date: 31/7/2013
Version: 0.1 ??
Purpose: scanning and draw CUHK's network map
Tools uesd: bash, graphviz

Step 1: create .dot file for generating graph in later part
Step 2: use ping (with timeout=1) to see if IP can be traced
Step 3: if yes, traceroute with ICMP,  *** results are skipped (might
handle in later version), and save the route to .dot file; else ignore
the IP address.
Step 4: scan through range of IP addresses
Step 5: generate .png file from .dot file using graphviz
