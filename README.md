# 🚀 Helm Chart Deployment Guide

## 📌 Add Helm Repository
To add your **Helm repository** from GitHub Pages, run the following command:

```sh
helm repo add backend-argocd https://miraccan00.github.io/Backend-ArgoCD-WebApp/
```

🔹 This command adds the repository **backend-argocd** from your hosted Helm repository.

💡 If you have already added the repository but need to refresh it, use:
```sh
helm repo update
```

---

## 🛠 Install Helm Chart
Once the repository is added, install your **Helm chart**:

```sh
helm install my-app backend-argocd/servicename
```

🔹 `my-app` → The **release name** (change it as needed).
🔹 `backend-argocd/servicename` → The **Helm repository and chart name**.

💡 To install a **specific version** of the chart:
```sh
helm install my-app backend-argocd/servicename --version 1.0.0
```

---

## ⚙️ Install with Custom Values (Optional)
If you want to use **custom values** from `values.dev.yaml` or `values.prod.yaml`, install using:

```sh
helm install my-app backend-argocd/servicename --version 1.0.0 -f helmchart/values.dev.yaml
```

🔹 Replace `values.dev.yaml` with the appropriate values file (`values.prod.yaml` for production, etc.).

---

## ✅ Verify the Deployment
Check the installed Helm release:
```sh
helm list
```

This should display output like:
```
NAME       NAMESPACE  REVISION  UPDATED                               STATUS   CHART        APP VERSION
my-app     default    1         2024-01-30 12:34:56.789 +0000 UTC   deployed servicename-1.0.0  1.0.0
```

To verify the deployed **Kubernetes resources**:
```sh
kubectl get all -n default
```

---

## 🔄 Upgrade or Uninstall Helm Release

To **upgrade** the release to a newer version:
```sh
helm upgrade my-app backend-argocd/servicename --version 1.0.1
```

To **uninstall** the Helm release:
```sh
helm uninstall my-app
```

---

## 🎯 Summary
✅ **Helm Repo Added**  
✅ **Helm Chart Installed**  
✅ **Deployment Verified**  
✅ **Upgrade & Uninstall Options Available**  

🚀 **You’re now ready to deploy with Helm!** If you have any issues, check your Helm logs or Kubernetes status.

