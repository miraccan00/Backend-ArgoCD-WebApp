helm uninstall argocd -n argocd
sh argocdinstallation.sh
kubectl apply -f argocd-ingress.yaml