#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

input() {
    local message="$1"
    local color="$2"
    local response

    echo -en "${color}${message}${NC}" >&2

    read -r response

    echo "$response"
}

validate_user() {
    local user="$1"
    if id "$user" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

validate_port() {
    local port="$1"
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        return 1
    else
        return 0
    fi
}

validate_host() {
    local host="$1"
    if ping -c 1 $host >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

kill_tunnel() {
    local port="$1"
    if ! pkill -f "ssh.*-L.*$port" || ! pkill -f "ssh.*-R.*$port"; then
        error "Failed to kill tunnel on port $port"
    else
        success "Tunnel on port $port successfully killed"
    fi
}

SSH_OPTIONS="-o ServerAliveInterval=30 -o ServerAliveCountMax=3"

while true; do
    echo "Select tunnel type:"
    echo "1. Local to Remote"
    echo "2. Remote to Local"
    echo "3. Both sides"
    echo "4. Kill tunnel"
    echo "5. Exit"
    choice=$(input "Enter your choice: " $GREEN)
    case $choice in
    1)
        info "Setting up Local to Remote tunnel..."

        LOCAL_IP=$(hostname -I | cut -d' ' -f1)
        LOCAL_PORT=$(input "Enter local port: " $BLUE)
        while ! validate_port $LOCAL_PORT; do
            error "Port $LOCAL_PORT is not available. Please enter a different port."
            LOCAL_PORT=$(input "Enter local port: " $BLUE)
        done

        REMOTE_USER=$(input "Enter remote user: " $YELLOW)

        REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        while ! validate_host $REMOTE_HOST; do
            error "Host $REMOTE_HOST is not reachable. Please enter a different host."
            REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        done

        REMOTE_PORT=$(input "Enter remote port: " $YELLOW)

        ssh $SSH_OPTIONS -L 0.0.0.0:$LOCAL_PORT:localhost:$LOCAL_PORT -C -fN $REMOTE_USER@$REMOTE_HOST -p $REMOTE_PORT

        success "Local to Remote tunnel created from $LOCAL_IP:$LOCAL_PORT to $REMOTE_HOST:$REMOTE_PORT"
        ;;
    2)
        info "Setting up Remote to Local tunnel..."

        LOCAL_PORT=$(input "Enter local port: " $BLUE)
        while ! validate_port $LOCAL_PORT; do
            error "Port $LOCAL_PORT is not available. Please enter a different port."
            LOCAL_PORT=$(input "Enter local port: " $BLUE)
        done

        REMOTE_USER=$(input "Enter remote user: " $YELLOW)

        REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        while ! validate_host $REMOTE_HOST; do
            error "Host $REMOTE_HOST is not reachable. Please enter a different host."
            REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        done

        REMOTE_PORT=$(input "Enter remote port: " $YELLOW)

        ssh $SSH_OPTIONS -R 0.0.0.0:$REMOTE_PORT:localhost:$LOCAL_PORT -C -fN $REMOTE_USER@$REMOTE_HOST

        success "Remote to Local tunnel created from $REMOTE_HOST:$REMOTE_PORT to localhost:$LOCAL_PORT"
        ;;
    3)
        info "Setting up both sides of the tunnel..."

        LOCAL_PORT=$(input "Enter local port: " $BLUE)
        while ! validate_port $LOCAL_PORT; do
            error "Port $LOCAL_PORT is not available. Please enter a different port."
            LOCAL_PORT=$(input "Enter local port: " $BLUE)
        done

        REMOTE_USER=$(input "Enter remote user: " $YELLOW)

        REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        while ! validate_host $REMOTE_HOST; do
            error "Host $REMOTE_HOST is not reachable. Please enter a different host."
            REMOTE_HOST=$(input "Enter remote host: " $YELLOW)
        done

        REMOTE_PORT=$(input "Enter remote port: " $YELLOW)

        ssh $SSH_OPTIONS -L 0.0.0.0:$LOCAL_PORT:localhost:$LOCAL_PORT -C -fN $REMOTE_USER@$REMOTE_HOST -p $REMOTE_PORT

        ssh $SSH_OPTIONS -R 0.0.0.0:$REMOTE_PORT:localhost:$LOCAL_PORT -C -fN $REMOTE_USER@$REMOTE_HOST

        success "Both sides of the tunnel created from $LOCAL_IP:$LOCAL_PORT to $REMOTE_HOST:$REMOTE_PORT and from $REMOTE_HOST:$REMOTE_PORT to localhost:$LOCAL_PORT"
        ;;
    4)
        info "Killing existing tunnels..."

        LOCAL_PORT=$(input "Enter local port: " $BLUE)

        kill_tunnel $LOCAL_PORT
        ;;
    5)
        info "Exiting..."
        exit 0
        ;;
    *)
        error "Invalid choice! Please select a valid option."
        ;;
    esac
done
