provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "my_app" {
  name       = "my-app"
  repository = "https://github.com/dzoni223/simple-java-maven-app" # Example repo
  chart      = "my-app" # Example chart, replace with your own
  namespace  = "default"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "replicaCount"
    value = "2"
  }
}
