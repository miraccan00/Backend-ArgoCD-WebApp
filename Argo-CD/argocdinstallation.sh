helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd -f argocd-values.yaml
echo "Password saved to argocd-password.txt file"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd-password.txt

