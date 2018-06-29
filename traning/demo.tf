resource "rancher_environment" "dentsu" {
    name = "Dentsu"
    description = "Local enviroment dentsu"
    orchestration =  "kubernetes"
}
resource "rancher_registration_token" "dentsu-token" {
  environment_id = "${rancher_environment.dentsu.id}"
  name = "dentsu-token"
  description = "Host registration token for Demo environment"
  provisioner "local-exec" {
      command =  "docker run -e CATTLE_HOST_LABELS='' -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 http://${var.hostname}:8080/v1/projects/${rancher_environment.dentsu.id}/scripts/${rancher_registration_token.dentsu-token.token}"
  }
}
resource "rancher_host" "k8s" {
  name = "${var.hostname}"
  description = "Node ${var.hostname}"
  environment_id = "${rancher_environment.dentsu.id}"
  hostname = "${var.hostname}"
}
