#!/usr/bin/env bash

set -xeu pipefail

source ./config.sh

all_public_ips=(${MASTER_PUBLIC_IPS[@]} ${WORKER_PUBLIC_IPS[@]})
all_public_ips=($(printf "%s\n" "${all_public_ips[@]}" | sort -u))

rm -rf ./render/

for i in ${!all_public_ips[*]}; do
    echo "cleanup: ${all_public_ips[$i]}"

    ssh ${SSH_LOGIN}@${all_public_ips[$i]} <<SSHEOF
        set -xeu pipefail

        sudo env PATH=\$PATH:/usr/local/bin:/opt/bin kubeadm reset
        sudo rm -rf ~/render/
SSHEOF
done
