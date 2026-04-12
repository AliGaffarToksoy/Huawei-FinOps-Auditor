# FunctionGraph servisinin kullanabileceği bir rol oluşturuyoruz
resource "huaweicloud_identity_agency" "finops_agency" {
  name                   = "serverless-finops-auditor-role"
  description            = "FinOps motoru icin salt okunur yetkiler"
  delegated_service_name = "op_svc_cce" # Huawei FunctionGraph arka plan servisi
}

# Bu role sadece 'EVS ReadOnlyAccess' (Diskleri Okuma) yetkisi atıyoruz
resource "huaweicloud_identity_agency_policy" "finops_read_policy" {
  agency_name = huaweicloud_identity_agency.finops_agency.name
  policy_name = "EVS ReadOnlyAccess"
}