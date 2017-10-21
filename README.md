# Simplicity. Minimalism. Elegance.

> A modern Arch workflow with an emphasis on functionality.

## Table of Contents

- Philosophy
    - GNU/Linux
    - Arch Linux
    - Use Case
- Features
- Installation
    - Installing From Source
    - Using a Pre-Compiled Image
- Post-Installation
- Workflow
- Help
- Contributing 

## Installation

### Installing From Source

**Important:** Do *not* attempt to run this script on your physical machine. This script was made for and has only been tested in a fresh new virtual machine running the Arch Linux ISO.

Boot into the Arch Linux ISO. Then, run the following commands:

```
wget https://raw.githubusercontent.com/GloverDonovan/new-start/master/install.sh
chmod +x install.sh
./install.sh <HOSTNAME> <LOCALUSER>
```

Replace `<HOSTNAME>` with your preferred hostname and `<LOCALUSER>` with the name of the user account to create.

