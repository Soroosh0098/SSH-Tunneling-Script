# SSH Tunneling Script
This script provides a simple interface to set up SSH tunnels between local and remote machines. It allows for various tunneling configurations, including local-to-remote, remote-to-local, and both sides.

## Why we need tunneling
SSH tunneling is commonly used for secure communication between two machines over an untrusted network. It encrypts the data transmitted between the machines, ensuring confidentiality and integrity.

## Usage in Restricted Regions
In regions where access to certain services or websites is restricted, SSH tunneling can be used to bypass censorship and access blocked content securely.

## Features
- Provides an interactive menu for setting up SSH tunnels
- Supports local-to-remote, remote-to-local, and both-side tunneling
- Validates user input for port numbers and host accessibility
- Allows killing existing SSH tunnels
- Colored output for better readability

## Download or Execute
To execute the script directly on your server, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/Soroosh0098/SSH-Tunneling-Script/main/ssh_tunnel.sh | sudo bash
```

To download the script, you can use either `curl` or `wget`. Run one of the following commands in your terminal:

Using `curl`:
```bash
curl -o ssh_tunnel.sh -L https://raw.githubusercontent.com/Soroosh0098/SSH-Tunneling-Script/main/ssh_tunnel.sh
```
Using `wget`:
```bash
wget https://raw.githubusercontent.com/Soroosh0098/SSH-Tunneling-Script/main/ssh_tunnel.sh -O ssh_tunnel.sh
```

## Usage
1. Make the script executable:

    ```bash
    chmod +x ssh_tunnel.sh
    ```

2. Run the script with root privileges:

    ```bash
    sudo ./ssh_tunnel.sh
    ```
    
Alternatively, you can execute the script using the following command:

```bash
bash ssh_tunnel.sh
```
    
This command runs the script in the Bash shell environment.

## Contributing

Contributions, bug reports, and suggestions for improvements are welcome! Feel free to open an issue or create a pull request.

## License

This project is licensed under the MIT License.
