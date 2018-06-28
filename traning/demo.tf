resource "rancher_environment" "dentsu" {
    name = "Dentsu"
    description = "Demonstration dentsu"
    orchestration =  "kubernetes" 
}
resource "rancher_registration_token" "dentsu-token" {
  environment_id = "${rancher_environment.dentsu.id}"
  name = "dentsu-token"
  description = "Host registration token for Demo environment"
}
resource rancher_host "k8svm" {
  name           = "k8svm"
  description    = "Main Host"
  environment_id = "${rancher_environment.dentsu.id}"
  hostname       = "k8svm"
}