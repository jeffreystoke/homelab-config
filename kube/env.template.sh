#
#
#
# Environment Variables Template
# DO NOT EDIT THIS FILE, copy to env.sh
# cp env.template.sh env.sh
#
#
#

export KUBE_PUB_ADDR="10.0.0.10"
export CLUSTER_NAME="kubernetes-the-hard-way"
export CLUSTER_DNS_SERVER="10.0.0.254"
export CONTEXT_NAME="default"

# CONTROLLER_LIST is not restricted by controller hostnames
export CONTROLLER_LIST=("kube-controller")
export CONTROLLER_INTERN_IP_LIST=(10.0.0.10)
export CONTROLLER_EXTERN_IP_LIST=(10.0.0.10)
export CONTROLLER_SSH_PORT_LIST=(22)
export CONTROLLER_SSH_ID_LIST=("~/.ssh/id_rsa")
export CONTROLLER_SSH_USER_LIST=("user")
# password for `sudo` in deployment
export CONTROLLER_SSH_USER_PASS_LIST=("my_password")

# WORKER_LIST has to be the list of worker hostnames
export WORKER_LIST=("kube-worker-1" "kube-worker-2" "kube-worker-3")
export WORKER_INTERN_IP_LIST=(10.0.0.1 10.0.0.2 10.0.0.3)
export WORKER_EXTERN_IP_LIST=(10.0.0.1 10.0.0.2 10.0.0.3)
export WORKER_SSH_PORT_LIST=(22 22 22)
export WORKER_SSH_ID_LIST=("~/.ssh/id_rsa" "~/.ssh/id_rsa" "~/.ssh/id_rsa")
export WORKER_SSH_USER_LIST=("user" "user" "user")
# password for `sudo` in deployment
export WORKER_SSH_USER_PASS_LIST=("my_password" "my_password" "my_password")

export KUBE_ETCD_CLUSTER_NAME="etcd-cluster-kube"
export KUBE_ETCD_LISTEN_CLIENT_PORT="2379"
export KUBE_ETCD_LISTEN_PEER_PORT="2380"

export KUBE_SERVICE_IP_RANGE="10.32.0.0/24"
export KUBE_SERVICE_PORT_RANGE="30000-32767"
export KUBE_CLUSTER_CIDR="10.200.0.0/16"
export KUBE_API_SERVER_PORT="6443"

export CERT_ORG_UNIT="Kubernetes The Hard Way"
export CERT_COUNTRY="US"
export CERT_LOCATION="Portland"
export CERT_STATE="Oregon"

# 
# 
# DO NOT Edit Variables Below, Unless You Know What You Are Doing
# 
# 

export COMP_KUBE_SERVICE_ACCOUNT="kube-service-account"
export COMP_KUBE_API_SERVER="kubernetes"
export COMP_KUBE_SCHEDULER="kube-scheduler"
export COMP_KUBE_CTRL_MGR="kube-controller-manager"
export COMP_KUBE_PROXY="kube-proxy"

export VER_KUBE="1.12.0"
export VER_ETCD="3.2.24"
export VER_RUNC="1.0.0-rc5"
export VER_RUNSC=""
export VER_CONTAINERD="1.2.0-rc.0"
export VER_CNI="0.3.1"
export VER_CNI_PLUGINS="0.6.0"

export GEN_DIR="generated"
export DOWNLOAD_DIR="download"

export WORKER_ADDR_LIST=""
export CONTROLLER_ADDR_LIST""
export ETCD_INITIAL_CLUSTERS=""
export ETCD_SERVERS=""

for IP in ${WORKER_INTERN_IP_LIST[@]}
do
export WORKER_ADDR_LIST="${IP},${WORKER_ADDR_LIST}"
done

for IP in ${CONTROLLER_INTERN_IP_LIST[@]}
do
export CONTROLLER_ADDR_LIST="${IP},${CONTROLLER_ADDR_LIST}"
done

for i in ${!CONTROLLER_LIST[@]}
do
CONTROLLER=${CONTROLLER_LIST[${i}]}
INTERN_IP=${CONTROLLER_INTERN_IP_LIST[${i}]}
URL="https://${INTERN_IP}:${KUBE_ETCD_LISTEN_PEER_PORT}"
export ETCD_INITIAL_CLUSTERS="etcd-${CONTROLLER}=${URL},${ETCD_INITIAL_CLUSTERS}"
export ETCD_SERVERS="https://${INTERN_IP}:${KUBE_ETCD_LISTEN_CLIENT_PORT},${ETCD_SERVERS}"
done