port forward for argocd
- kubectl port-forward svc/argocd-server -n argocd 8080:80
get secret argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d