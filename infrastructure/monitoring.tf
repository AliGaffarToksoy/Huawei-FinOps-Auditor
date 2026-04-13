# K8s içinde izleme araçlarımız için özel, izole bir oda (Namespace) açıyoruz
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "observability-stack"
  }
}

# Helm kullanarak meşhur 'kube-prometheus-stack' paketini (Grafana dahil) kuruyoruz
resource "helm_release" "prometheus_grafana" {
  name       = "enterprise-monitor"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "51.2.0" # Stabil kurumsal sürüm

  # Grafana'ya mülakatçıları etkileyecek havalı bir admin şifresi atıyoruz
  set {
    name  = "grafana.adminPassword"
    value = "HuaweiCloudSRE@2026!"
  }

  # Grafana arayüzünü dış dünyaya (LoadBalancer) açıyoruz ki tarayıcıdan girebilelim
  set {
    name  = "grafana.service.type"
    value = "LoadBalancer"
  }

  # Prometheus'un sadece 14 günlük veri tutmasını söylüyoruz (Disk maliyet optimizasyonu!)
  set {
    name  = "prometheus.prometheusSpec.retention"
    value = "14d"
  }
}