# 1. Terraform bizim yerimize Python kodunu ZIP dosyası yapar
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "finops_engine.zip"
}

# 2. Serverless Fonksiyonu yaratıyoruz
resource "huaweicloud_fgs_function" "finops_auditor" {
  name        = "finops-idle-disk-auditor"
  app         = "default"
  agency      = huaweicloud_identity_agency.finops_agency.name
  memory_size = 128     # Sadece 128MB RAM! En ucuz profil.
  timeout     = 30      # 30 saniye içinde işini bitirmezse sistemi yormamak için durdur.
  runtime     = "Python3.10"
  handler     = "audit_engine.handler" # DosyaAdı.FonksiyonAdı

  # HATANIN ÇÖZÜMÜ: Huawei Cloud Kod Yükleme Standartları
  code_type = "zip"
  func_code = filebase64(data.archive_file.function_zip.output_path)

  # Kodun içindeki ortam değişkenleri (ENV)
  user_data = jsonencode({
    PROJECT_ID = "MOCK_PROJECT_ID"
  })
}

# 3. Otonom Zamanlayıcı (CRON) Tetikleyici
resource "huaweicloud_fgs_trigger" "nightly_cron" {
  function_urn = huaweicloud_fgs_function.finops_auditor.urn
  type         = "TIMER"
  status       = "ACTIVE"
  timer {
    name           = "nightly-audit"
    schedule_type  = "Cron"
    schedule       = "0 0 3 * * ?" # Her gece saat 03:00'te uyan
  }
}