import os
from huaweicloudsdkcore.auth.credentials import BasicCredentials
from huaweicloudsdkevs.v2.region.evs_region import EvsRegion
from huaweicloudsdkevs.v2 import EvsClient, ListVolumesRequest, DeleteVolumeRequest


def handler(event, context):
    print("🤖 FinOps Terminatör Motoru Uyandı. Otonom imha protokolü başlatılıyor...")

    ak = os.getenv("AK", "MOCK_AK")
    sk = os.getenv("SK", "MOCK_SK")
    project_id = os.getenv("PROJECT_ID", "MOCK_PROJECT_ID")

    credentials = BasicCredentials(ak, sk, project_id)

    try:
        client = EvsClient.new_builder() \
            .with_credentials(credentials) \
            .with_region(EvsRegion.value_of("tr-west-1")) \
            .build()

        # 1. Tüm diskleri listele
        request = ListVolumesRequest()
        response = client.list_volumes(request)

        deleted_disks = []
        saved_money_gb = 0

        # 2. Boşta olan (available) diskleri bul ve SİL
        for volume in response.volumes:
            if volume.status == "available":
                print(f"🗑️ İSRAF TESPİT EDİLDİ: {volume.name} ({volume.id}). Otonom olarak siliniyor...")

                # Silme İsteği (Terminatör Vuruşu)
                delete_req = DeleteVolumeRequest(volume_id=volume.id)
                client.delete_volume(delete_req)

                deleted_disks.append(volume.name)
                saved_money_gb += volume.size

        # 3. Sonuç Raporu
        if deleted_disks:
            success_msg = f"✅ OTONOM TEMİZLİK TAMAMLANDI! {len(deleted_disks)} adet boşta disk silindi. Toplam {saved_money_gb} GB israf engellendi."
            print(success_msg)
            return {"status": "remediated", "deleted_resources": deleted_disks, "saved_gb": saved_money_gb}
        else:
            print("💤 Sistem tertemiz. İmha edilecek israf bulunamadı.")
            return {"status": "clean"}

    except Exception as e:
        print(f"❌ SDK Kritik Hatası: {str(e)}")
        return {"status": "error", "message": str(e)}


if __name__ == "__main__":
    handler(None, None)