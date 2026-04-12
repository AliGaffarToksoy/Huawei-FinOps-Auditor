import os
from huaweicloudsdkcore.auth.credentials import BasicCredentials
from huaweicloudsdkevs.v2.region.evs_region import EvsRegion
from huaweicloudsdkevs.v2 import EvsClient, ListVolumesRequest

# FunctionGraph (Serverless) her tetiklendiğinde bu fonksiyonu çalıştırır
def handler(event, context):
    print("🔍 FinOps Denetim Motoru Uyandı. Tarama başlatılıyor...")

    # Güvenlik standardı: Anahtarlar asla koda yazılmaz, ortam değişkeninden (IAM) alınır
    ak = os.getenv("AK", "MOCK_AK")
    sk = os.getenv("SK", "MOCK_SK")
    project_id = os.getenv("PROJECT_ID", "MOCK_PROJECT_ID")

    credentials = BasicCredentials(ak, sk, project_id)

    try:
        # Huawei Cloud EVS (Elastic Volume Service) İstemcisini Başlat
        client = EvsClient.new_builder() \
            .with_credentials(credentials) \
            .with_region(EvsRegion.value_of("tr-west-1")) \
            .build()

        # Tüm sunucu disklerini listele
        request = ListVolumesRequest()
        response = client.list_volumes(request)

        idle_disks = []
        total_waste_gb = 0

        # Zombi (Kullanılmayan) diskleri bul
        # 'available' durumu, diskin hiçbir sunucuya (ECS) bağlı olmadığını gösterir
        for volume in response.volumes:
            if volume.status == "available":
                idle_disks.append(volume.name)
                total_waste_gb += volume.size

        # Raporlama
        if idle_disks:
            alert_msg = f"🚨 İSRAF TESPİT EDİLDİ! Toplam {len(idle_disks)} adet boşta disk var. İsraf edilen alan: {total_waste_gb} GB."
            print(alert_msg)
            # Burada normalde Slack veya SMN (Email) tetiklenir
            return {
                "status": "alert",
                "wasted_storage_gb": total_waste_gb,
                "idle_resources": idle_disks
            }
        else:
            print("✅ Sistem tertemiz. Boşta kaynak (İsraf) yok.")
            return {"status": "clean"}

    except Exception as e:
        print(f"❌ SDK Bağlantı Hatası: {str(e)}")
        return {"status": "error", "message": str(e)}

# Sadece lokalde test edebilmek için ufak bir tetikleyici
if __name__ == "__main__":
    handler(None, None)