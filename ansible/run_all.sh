#!/bin/bash

INVENTORY="/ansible/inventory/hosts.ini"
PLAYBOOKS="/ansible/playbooks"

echo "Starting deployment of all playbooks..."

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
    fi
    echo ""
}

run_playbook "update_repos.yml"
run_playbook "install_docker.yml"
run_playbook "install_vscode.yml"
run_playbook "install_node_exporter.yml"
run_playbook "install_wazuh_agent.yml"

echo "🎉 All playbooks executed successfully!"
