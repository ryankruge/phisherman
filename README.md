# Phisherman
Phisherman is a simple tool that allows for quick and effective deployment of phishing sites. The way that this tool works is via the use of **Python**, the **PHP** tool as well as a directory of sites that can deployed during an attack. This tool when forwarded to the internet via a tunnel can be a very effective.
# Application Usage
## Arguments
- C R L - Display the current credentials stored, clear the credentials file, list all available directories.
- H W - Display the help screen, select which payload you would like to deploy.
## Requirements
This program requires the `colorama` library as well as the `PHP` command-line tool for **Linux**.
```
python -m pip install colorama
```
```
sudo pacman -Sy php
```
Or for **Debian**, **Ubuntu** and other Linux distributions.
```
sudo apt-get install php
```

## Usage

This program is a great tool for capturing sensitive information (*hypothetically*) without the knowledge of the target. I **DO NOT** condone the malicious use of this software as it should only be used with explicit concent from the target.