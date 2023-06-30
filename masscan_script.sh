#!/bin/bash

# Output file path
ipv4_output_file="ipv4_scan_results.txt"
ipv6_output_file="ipv6_scan_results.txt"

# Get IP blocks for Bangladesh from Ipverse API
ipv4_blocks=$(curl https://raw.githubusercontent.com/ipverse/rir-ip/master/country/bd/aggregated.json | jq -r '.subnets.ipv4[]')
ipv6_blocks=$(curl https://raw.githubusercontent.com/ipverse/rir-ip/master/country/bd/aggregated.json | jq -r '.subnets.ipv6[]')


# Store IPv4 blocks in the output file
# echo "IPv4 Blocks" > "$ipv4_output_file"
#echo "$ipv4_blocks" >> "$ipv4_output_file"

# Store IPv6 blocks in the output file
#echo "IPv6 Blocks" > "$ipv6_output_file"
#echo "$ipv6_blocks" >> "$ipv6_output_file"

# Scan ipv4 blocks
echo "Scanning IPv4 Addresses in BD" > "$ipv4_output_file"
for ipv4_block in $ipv4_blocks;
do
	echo "$ipv4_block" >> "$ipv4_output_file"
	sudo masscan "$ipv4_block" -p80,443,21,22 --rate 1000 -oG - | tee -a "$ipv4_output_file"
done


# Scan ipv6 blocks
echo "Scanning IPv6 Addresses in BD" > "$ipv6_output_file"
for ipv6_block in $ipv6_blocks;
do
	echo "$ipv6_block" >> "$ipv6_output_file"
	sudo masscan "$ipv6_block" -p80,443,21,22 --rate 1000 -oG - | tee -a "$ipv6_output_file"
done

