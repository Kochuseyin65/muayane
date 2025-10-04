Elbette. İşte bu JSON yapısını ve arkasındaki mantığı sıfırdan bir geliştiriciye anlatacak şekilde hazırlanmış, örneklerle dolu bir Markdown dosyası.

Dinamik Arayüz Oluşturma: JSON Tabanlı "Blueprint" Sistemi

Merhaba! Bu dökümana hoş geldin. Burada, karmaşık formları ve raporları dinamik olarak oluşturmak için kullandığımız JSON tabanlı bir sistemin mantığını ve nasıl çalıştığını öğreneceksin.

1. Temel Felsefe: "Ne İstediğini Söyle, Nasıl Yapılacağını Değil"

Bu sistemin kalbinde Deklaratif (Bildirimsel) Programlama felsefesi yatar. Bu ne anlama geliyor?

Emirsel (Imperative) Yaklaşım (Geleneksel Yol): "Bir kutu çiz, koordinatları 10,20 olsun. Genişliği 200px olsun. İçine 'Ad:' metnini yaz." Bu yaklaşımda, nasıl yapılacağını adım adım tarif edersin.

Bildirimsel (Declarative) Yaklaşım (Bizim Yolumuz): "Sayfada, üzerinde 'Ad:' yazan bir giriş alanı istiyorum." Bu yaklaşımda ise sadece ne istediğini söylersin. Sistemin kendisi (biz ona Renderer diyoruz), bu isteği nasıl ekrana çizeceğini bilir.

JSON dosyamız, oluşturulacak raporun bir tarifi veya planıdır (blueprint). Renderer programı bu planı okur ve sonucu ekrana çizer.

Avantajları:

Esneklik: Arayüzün görünümünü değiştirmek için programlama kodu yerine sadece JSON'ı değiştirirsin.

Taşınabilirlik: Aynı JSON planı, bir web sayfası (HTML/CSS), bir mobil uygulama veya bir PDF oluşturmak için farklı Renderer'lar tarafından kullanılabilir.

Okunabilirlik: Arayüzün yapısı, kodun içinde kaybolmak yerine tek bir yerde net bir şekilde görülebilir.

2. JSON Yapısının Anatomisi: Temel Parçalar

JSON'umuz birkaç temel yapı taşından oluşur.

page, section, row, cell: Hiyerarşik Düzen

Yapı, bir Matruşka bebek gibi iç içe geçmiş kutulardan oluşur:

page: Her şeyi içeren en dıştaki nesne.

section: "1. GENEL BİLGİLER" gibi raporun ana bölümleri.

row: Bir bölüm içindeki yatay bir satır.

cell: Bir satır içindeki dikey bir hücre (sütun).

code
JSON
download
content_copy
expand_less
{
  "page": {
    "layout": [
      {
        "type": "section",
        "title": "Bölüm 1",
        "rows": [
          {
            "cells": [ /* Hücreler buraya gelecek */ ]
          },
          {
            "cells": [ /* Başka bir satırın hücreleri */ ]
          }
        ]
      }
    ]
  }
}
type: "Ben Neyim?"

Her bileşenin bir type özelliği vardır. Bu, Renderer'a o şeyi nasıl çizeceğini söyler.

"type": "labelInput": Üzerinde etiket olan bir metin giriş alanı.

"type": "checkboxGroup": Seçenek kutucukları grubu.

"type": "hierarchicalTable": Karmaşık başlıklı bir tablo.

flex: Yerleşim Sihri

Bu, sistemin en önemli parçasıdır. Bir satır içindeki hücrelerin (cell) mevcut alanı nasıl paylaşacağını belirler. CSS Flexbox mantığıyla aynıdır.

Kural: Bir satırdaki toplam flex değeri bulunur. Her hücre, kendi flex değerinin toplam değere oranı kadar yer kaplar.

Örnek 1: İki eşit parçalı satır

code
JSON
download
content_copy
expand_less
"cells": [
  { "type": "labelInput", "label": "Adı", "flex": 1 },
  { "type": "labelInput", "label": "Soyadı", "flex": 1 }
]

Toplam flex: 1 + 1 = 2.

İlk hücre alanın 1/2'sini (%50) kaplar.

İkinci hücre alanın 1/2'sini (%50) kaplar.

Örnek 2: Eşit olmayan parçalı satır

code
JSON
download
content_copy
expand_less
"cells": [
  { "type": "labelInput", "label": "Adres", "flex": 3 },
  { "type": "labelInput", "label": "Posta Kodu", "flex": 1 }
]

Toplam flex: 3 + 1 = 4.

"Adres" hücresi alanın 3/4'ünü (%75) kaplar.

"Posta Kodu" hücresi alanın 1/4'ünü (%25) kaplar.

Bu sayede, "bazı satırlar daha geniş, bazıları daha dar" sorununu kolayca çözeriz.

3. Renderer Algoritması: Plan Nasıl Hayata Geçer?

Renderer programı JSON'ı aldığında yaklaşık olarak şu adımları izler:

JSON dosyasını oku ve page.layout dizisini bul.

layout dizisindeki her bir section için döngü başlat.

Bölüm başlığını ekrana yazdır.

Bölümün içindeki rows dizisi için döngü başlat.

Her bir row için:

Satırın toplam genişliğini al (örneğin 1000px).

Satırın içindeki tüm cell'lerin flex değerlerini topla (totalFlex).

cells dizisi içindeki her bir cell için döngü başlat.

Hücrenin genişliğini hesapla: cellWidth = (cell.flex / totalFlex) * rowWidth.

Hücrenin type'ına bakarak ilgili bileşeni (input, checkbox vb.) cellWidth genişliğinde ekrana çiz.

Eğer style özelliği varsa, bu stilleri (arka plan rengi, yazı tipi vb.) uygula.

Tüm layout bittiğinde işlemi sonlandır.

4. İleri Düzey Konu: Hiyerarşik Tablolar (hierarchicalTable)

Bazen tabloların başlıkları birden fazla satır veya sütuna yayılabilir. İşte burada colspan ve rowspan devreye girer.

code
Code
download
content_copy
expand_less
+---------------------------+------------------+
|      Header Row 1         |                  |
+---------------------------+------------------+
|      Header Row 2         |                  |
+===========================+==================+
| Data Cell | Data Cell     | Data Cell        |
+-----------+---------------+------------------+
colspan: Sütun Birleştirme (Yatayda Yayılma)

Bir başlığın, altında bulunan birden fazla sütunu kaplamasını sağlar.

Örneğimizdeki "Koruma Elemanının" başlığı, altında 4 farklı alt başlık barındırır. Bu yüzden colspan: 4 alır ve yatayda 4 sütunluk yer kaplar.

rowspan: Satır Birleştirme (Dikeyde Yayılma)

Bir başlığın birden fazla satır kadar yükseklikte olmasını sağlar.

Tablomuzun başlığı aslında 2 satırdan oluşuyor:

Satır 1: "No", "Ölçüm noktası...", "Koruma Elemanının", "Ölçüm" vb.

Satır 2: "In (A)", "Açma eğrisi tipi" gibi alt başlıklar.

"No" başlığının altında başka bir alt başlık yok. Bu yüzden, hem 1. satırın hem de 2. satırın yüksekliğini kaplayarak tek ve uzun bir hücre gibi durması gerekir. Bu nedenle rowspan: 2 alır.

Aşağıdaki şema durumu daha iyi açıklar:

code
Code
download
content_copy
expand_more
children: Alt Başlıklar

colspan kullanan bir ana başlığın altındaki ikinci satır başlıklarını tanımlamak için children dizisini kullanırız. Renderer bu diziyi gördüğünde, ikinci başlık satırını oluşturacağını anlar.

key ve data: Veriyi Başlıkla Eşleştirme

Her başlığa (In (A), olcumNoktasi vb.) benzersiz bir key veririz. data dizisindeki her bir satır nesnesi, bu key'leri kullanarak verilerini ilgili sütunlara yerleştirir. Bu, yapıyı içerikten ayırmanın temiz bir yoludur.

code
JSON
download
content_copy
expand_less
"headers": [
  { "text": "Ölçüm noktası", "key": "olcumNoktasi" }
],
"data": [
  { "olcumNoktasi": "Tali Pano-1" } // "key" sayesinde doğru sütuna gider.
]

Bu sistem, karmaşık ve değişken rapor yapılarını yönetmek için güçlü ve esnek bir yöntem sunar. Başlangıçta biraz karmaşık gelebilir, ancak temel parçaları anladığında ne kadar modüler olduğunu göreceksin.