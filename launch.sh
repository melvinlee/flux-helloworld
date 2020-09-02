#/bin/sh

set -e
source launch.config

instuction()
{
    echo ""
    echo "Usage: launch.sh aks"
    echo "Usage: launch.sh destroy"
}

if [ $# -lt 1 ]; then
    instuction
    exit 1
fi

if [ "$1" = "aks" ];then

    echo "Launching resources..."
    echo
    echo "Creating resources group ..." 
    az group create -l $LOCATION -n $RESOURCEGROUP --output json
    echo 
    echo "Creating aks ..." 
    az aks create -g $RESOURCEGROUP -n $CLUSTERNAME --enable-managed-identity --no-ssh-key --output json
fi

if [ "$1" == "destroy" ];then

    echo "Deleting resources..."
    az group delete -n $RESOURCEGROUP --no-wait
fi