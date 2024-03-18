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

## Example Usage

### Local to Remote Tunnel

1. Select "Local to Remote" tunneling option from the menu.
2. Enter the local port from which the tunnel will originate.
3. Provide the remote user's username and the hostname or IP address of the remote machine.
4. Enter the port on the remote machine to which the tunnel will connect.
5. Upon successful setup, the script will display a success message confirming the creation of the tunnel.
   * try to choose same ports for both local and remote servers(your remote server must accept ssh over the choosen port)

### Remote to Local Tunnel

To create a remote-to-local tunnel, follow similar steps as above, but select the "Remote to Local" tunneling option from the menu.

### Both Sides Tunnel

For both sides of the tunnel, select the corresponding option from the menu and provide the required information for both the local-to-remote and remote-to-local connections.

### Killing Existing Tunnels

To terminate existing tunnels, select the "Kill tunnel" option from the menu and enter the local port associated with the tunnel you wish to terminate.

### Exiting the Script

To exit the script, select the "Exit" option from the menu.

## Contributing

Contributions, bug reports, and suggestions for improvements are welcome! Feel free to open an issue or create a pull request.

## License

This project is licensed under the MIT License.
