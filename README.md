# Corio-Runtime

**CRT** (Corio RunTime) lets you run the same applications (**Cores**) on any operating system without having to compile the app separately for each OS. It works by using different **Host** implementations

Now CRT tested success on **Debian 13**, added **Fedora** and **Arch** support, later will be added **Windows** and **MacOS** support

# Install

1. ## Install git
   Debian: `sudo apt update && sudo apt install -y git`
   Fedora: `sudo dnf install -y git`
   Arch: `sudo pacman -Sy --noconfirm git`
2. Clone the repo
   `git clone https://github.com/yareeekc/Corio-Runtime.git && cd Corio-Runtime/`
3. Start the installation script
   `chmod +x ./install.sh && sudo ./install.sh`

# Using
1. ## Installing apps
   `crt-add <ARCHIVE-NAME>.core`
2. ## Launch app
   `crt-lch <APP-NAME>`
3. ## Remove app
   `crt-del <APP-NAME>`

# For developers
## How to pack your app
.core-files is a ZIP-archive with .core extension, but you must pack your **FILES** in archive, **NOT** directory
`cd your-project-dir`
`zip -r ../yoru-app-name.core .`

## App files
Your .core-archive must have:
1. index.html - main file
2. logo.png   - app logo

## API
### Sending request
CRT using port **6543** for API server, using in JS (f. e.):
`fetch('http://127.0.0.1:6543/ls/home/')`
to get list of files in / device

### Basic API methods
poweroff ╮

reboot   }   Power management

suspend  ╯

ping     }   Check connect to API server, answer: "OK"

os-info  }   `cat /etc/os-release`

mkdir/dir}   Create a new directory, "dir" is absolutely path to your new directory

rmdir/dir}   Remove the directory, "dir" is absolutely path to your directory

ls/dir   }   list of files in currently directory, "dir" is absolutely path to your directory

write/file}  writing text to the file, "file" is absolutely path to your file and it's name (f. e.: /etc/os-release)

read/file}   reading text in the file, "file" is absolutely path to your file and it's name

mkfile/file} create a new file, "file" is absolutely path to your file and it's name

rmfile/file} remove the file, "file" is absolutely path to your file and it's name

hostname }   get name of user's host

whoami   }   get username

# What's next?
## In plans are:
Integration to the <a href="https://github.com/yareeekc/CorIO">**Corio Shell**</a>
More **Hosts**
More **API methods**

Thank you for staying with us!
From Yareeek, with ❤️
