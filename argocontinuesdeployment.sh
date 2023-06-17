#!/bin/bash

# Argo CD server details
ARGOCD_SERVER="localhost:8080"
ARGOCD_USERNAME="admin"
ARGOCD_PASSWORD="QCNn2YLFEXBBmCj8"

# Application details
APPLICATION_NAME="djangoargo"
APPLICATION_REPO="https://github.com/miraccan00/djangoworkshop.git"
APPLICATION_PATH="djangoapp"
APPLICATION_TARGET_REVISION="master"
APPLICATION_NAMESPACE="default"

# Log in to Argo CD server
echo "Logging in to Argo CD server..."
argocd login "$ARGOCD_SERVER" --username "$ARGOCD_USERNAME" --password "$ARGOCD_PASSWORD" --insecure

# Create or sync the application
echo "Creating or syncing the application..."
argocd app create djangoargo --repo $APPLICATION_REPO --path deploymentchart --dest-server https://kubernetes.default.svc --dest-namespace default --revision $APPLICATION_TARGET_REVISION --sync-policy automated


# Wait for the application to sync
echo "Waiting for the application to sync..."
argocd app wait "$APPLICATION_NAME" --sync

# Check the sync status
SYNC_STATUS=$(argocd app get "$APPLICATION_NAME" -o jsonpath='{.status.sync.status}')
if [ "$SYNC_STATUS" == "Synced" ]; then
  echo "Application sync successful."
else
  echo "Application sync failed."
fi

# Log out from Argo CD server
echo "Logging out from Argo CD server..."
argocd logout "$ARGOCD_SERVER" 

echo "Script execution complete."
