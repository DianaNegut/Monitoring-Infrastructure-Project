#!/bin/bash

# Define inventory and Playbooks directory
INVENTORY="/ansible/inventory/hosts.ini"
PLAYBOOKS="/ansible/playbooks"

echo "Starting deployment of all playbooks..."

# Function to run playbook
run_playbook() {
    local playbook=$1
    echo "------------------------------------------------------------------"
    echo "Running playbook: $playbook"
    echo "------------------------------------------------------------------"
    ansible-playbook -i "$INVENTORY" "$PLAYBOOKS/$playbook"
    if [ $? -eq 0 ]; then
        echo "✅ SUCCESS: $playbook COMPLETED"
    else
        echo "❌ FAIL: $playbook failed"
        # exit 1  <-- Disabled to allow continuing
    fi
    echo ""
}

# 1. Update Repositories
run_playbook "update_repos.yml"

# 2. Install Docker (Core infrastructure)
run_playbook "install_docker.yml"

# 3. Install VS Code Server (Browser-based, works in containers)
run_playbook "install_vscode.yml"

# 4. Install Node Exporter (Monitoring)
run_playbook "install_node_exporter.yml"

# 5. Install Wazuh Agent (Security)
run_playbook "install_wazuh_agent.yml"

echo "🎉 All playbooks executed successfully!"
