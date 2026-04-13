# FunctionGraph servisinin kullanabileceği kimlik ve yetki bloğu (Huawei Cloud Native)
resource "huaweicloud_identity_agency" "finops_agency" {
  name                   = "serverless-finops-auditor-role"
  description            = "FinOps motoru icin otonom silme (Terminator) yetkileri"
  delegated_service_name = "op_svc_cce" # FunctionGraph arka plan servisi

  # Hatanın çözümü: Huawei Cloud'da yetkiler bu bloğun içine yazılır
  project_role {
    project = "tr-west-1"
    roles   = ["EVS Administrator"] # Diskleri silme yetkisi
  }
}