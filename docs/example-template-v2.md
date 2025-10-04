``` json
{
  "page": {
    "title": "ASILI ERİŞİM DONANIMI PERİYODİK KONTROL RAPORU",
    "style": {
      "fontFamily": "Arial, sans-serif",
      "fontSize": "10px",
      "backgroundColor": "#FFFFFF"
    },
    "layout": [
      {
        "type": "header",
        "title": "ASILI ERİŞİM DONANIMI PERİYODİK KONTROL RAPORU",
        "style": {
          "textAlign": "center",
          "fontWeight": "bold",
          "fontSize": "16px",
          "border": "1px solid #000",
          "padding": "10px"
        },
        "meta": {
            "type": "grid",
            "columns": 2,
            "style": {
                "position": "absolute",
                "top": "10px",
                "right": "10px",
                "border": "1px solid #000"
            },
            "items": [
                { "label": "Doküman Kodu", "value": ": ZPKR07" },
                { "label": "Yayım Tarihi", "value": ": 26/09/2025" },
                { "label": "Revizyon No", "value": ": " },
                { "label": "Revizyon Tarihi", "value": ": " },
                { "label": "Yürürlük Tarihi", "value": ": 01/02/2026" }
            ]
        }
      },
      {
        "type": "section",
        "id": "1_genel_bilgiler",
        "title": "1. GENEL BİLGİLER",
        "rows": [
          {
            "cells": [
              {
                "type": "labelInput",
                "label": "İşyerinin ünvanı",
                "flex": 1
              }
            ]
          },
          {
            "cells": [
              {
                "type": "labelInput",
                "label": "İşyerinin adresi",
                "flex": 1
              }
            ]
          },
          {
            "cells": [
              {
                "type": "labelInput",
                "label": "SGK Sicil Numarası",
                "flex": 1
              }
            ]
          },
          {
            "cells": [
              { "type": "labelInput", "label": "Periyodik kontrol başlangıç tarihi ve saati", "flex": 3 },
              { "type": "labelInput", "label": "Rapor tarihi", "flex": 2, "style": { "backgroundColor": "#E0EFFF" } }
            ]
          },
          {
            "cells": [
              { "type": "labelInput", "label": "Periyodik kontrol bitiş tarihi ve saati", "flex": 3 },
              { "type": "labelInput", "label": "ISG-KATİP Sözleşme ID", "flex": 2, "style": { "backgroundColor": "#E0EFFF" } }
            ]
          },
          {
            "cells": [
              { "type": "labelInput", "label": "Bir sonraki periyodik kontrol başlangıç tarihi", "flex": 3 },
              { "type": "labelInput", "label": "Rapor no", "flex": 2, "style": { "backgroundColor": "#E0EFFF" } }
            ]
          }
        ]
      },
      {
          "type": "subsection",
          "id": "1_1_kontrol_metodu",
          "title": "1.1 PERİYODİK KONTROL METODU",
          "rows": [ { "cells": [ { "type": "input", "flex": 1 } ] } ]
      },
      {
        "type": "section",
        "id": "2_ekipman_bilgileri",
        "title": "2. EKİPMAN BİLGİLERİ",
        "subsections": [
            {
                "id": "2_1_etiket_bilgileri",
                "title": "2.1. EKİPMAN ETİKET BİLGİLERİ",
                "rows": [
                    {
                        "cells": [
                            { 
                                "type": "checkboxGroup",
                                "label": "Ekipman türü",
                                "flex": 1,
                                "options": ["Yapı bakım ünitesi", "Geçici asılı erişim donanımı", "Asılı koltuk"]
                            }
                        ]
                    },
                    {
                        "cells": [
                            { "type": "labelInputGroup", "flex": 1, "inputs": [
                                { "label": "Markası / Modeli", "flex": 3},
                                { "label": "İmal yılı", "flex": 1 }
                            ]},
                            { "type": "labelInput", "label": "Kapasitesi (kg ve kişi)", "flex": 1 }
                        ]
                    },
                    {
                        "cells": [
                            { "type": "labelInput", "label": "Seri no", "flex": 1 },
                            { "type": "labelInput", "label": "Kaldırma hızı (m/min)", "flex": 1 }
                        ]
                    },
                    {
                        "cells": [
                            { "type": "labelInput", "label": "Birincil ve ikincil halat çapı (mm)", "flex": 1 },
                            { "type": "labelInput", "label": "Yardımcı kaldırma mekanizması kapasitesi (kg)", "flex": 1 }
                        ]
                    },
                     {
                        "cells": [
                            { "type": "labelInput", "label": "Yük kolu iç ve dış uzunluğu (m)", "flex": 1 },
                            { "type": "labelInput", "label": "İkincil güvenlik cihazı maksimum çalışma yükü (kg) ve hızı (m/min)", "flex": 1 }
                        ]
                    },
                    {
                        "cells": [
                            { "type": "labelInput", "label": "Parapet destek ayağı arası mesafe (m)", "flex": 1 },
                            { "type": "labelInput", "label": "Konsollu çıkmaların uzunluğu (m) ve maksimum çalışma yükü (kg)", "flex": 1 }
                        ]
                    }
                ]
            },
            {
                "id": "2_2_tespit_edilen_bilgiler",
                "title": "2.2. TESPİT EDİLEN BİLGİLER",
                "rows": [
                     {
                        "cells": [
                            { "type": "labelInput", "label": "Birincil ve ikincil halat çapı (mm)", "flex": 1 },
                            { "type": "labelInput", "label": "Platform sayısı ve boyutları (en, boy (m))", "flex": 1 }
                        ]
                    },
                     {
                        "cells": [
                            { "type": "labelInput", "label": "Yük kolu iç ve dış uzunluğu (m)", "flex": 1 },
                            { "type": "labelInput", "label": "Kaldırma yüksekliği (m) / Kat sayısı", "flex": 1 }
                        ]
                    },
                     {
                        "cells": [
                            { "type": "labelInput", "label": "Parapet destek ayağı arası mesafe (m)", "flex": 1 },
                            { "type": "labelInput", "label": "Konsollu çıkmaların uzunluğu (m)", "flex": 1 }
                        ]
                    },
                     {
                        "cells": [
                            { "type": "labelInput", "label": "Yapıya bağlantı türü", "flex": 1 },
                            { "type": "labelInput", "label": "Toplam karşı ağırlık kütlesi (kg)", "flex": 1 }
                        ]
                    },
                    {
                        "cells": [
                            { "type": "labelInput", "label": "Kullanım yeri ve amacı", "flex": 1}
                        ]
                    }
                ]
            }
        ]
      },
      {
        "type": "section",
        "id": "3_test_degerleri",
        "title": "3. TEST DEĞERLERİ",
        "rows": [
            {
                "cells": [
                    { "type": "labelInput", "label": "Yüklü test yükü (kg)", "flex": 1},
                    { "type": "labelInput", "label": "Dinamik test yükü (kg)", "flex": 1},
                    { "type": "labelInput", "label": "Statik test yükü (kg)", "flex": 1}
                ]
            }
        ]
      },
       {
        "type": "section",
        "id": "4_olcum_aletleri",
        "title": "4. ÖLÇÜM ALETLERİ BİLGİLERİ",
        "rows": [
            {
                "cells": [
                     { "type": "labelInput", "label": "Adı, Seri no, Kalibrasyon bilgisi", "flex": 1 }
                ]
            }
        ]
      },
      {
        "type": "section",
        "id": "5_muayene_ve_testler",
        "title": "5. MUAYENE KRİTERLERİ VE TESTLER",
        "layout": "freeform",
        "content": [
          {
            "type": "splitTable",
            "headers": ["MUAYENE KRİTERİ", "Değerlendirme"],
            "columns": [
              {
                "items": [
                  "1. Operatör talimatları ve işaretlemeler",
                  "2. Yetkisiz kullanıma ve müdahaleye karşı koruma",
                  "3. Koruma tertibatları",
                  "4. Asılı platform veya koltuk",
                  "5. Kaldırma ve emniyet askı aksamları",
                  "6. Fren sistemi/sistemleri",
                  "7. Mekanik hareket sınırlayıcı/sınırlayıcıları",
                  "8. Hareket sınırlama cihazı/cihazları",
                  "9. Kumandalar",
                  "10. Göstergeler ve ikazlar"
                ]
              },
              {
                "items": [
                  "11. Aşırı yük algılama cihazı",
                  "12. Düşmeyi engelleyici güvenlik tertibatları",
                  "13. Enerji kesintisinde elle indirme tertibatları",
                  "14. Boylamasına durumun korunması ve/veya engel algılama",
                  "15. Asma donanımı",
                  "16. Yapısal bileşenler ve bağlantılar",
                  "17. Yardımcı kaldırma mekanizmaları",
                  "18. Erişim",
                  "19. Elektromekanik uyum"
                ]
              }
            ]
          },
          {
            "type": "simpleTable",
            "headers": ["TESTLER", "Test Tarihi", "Değerlendirme"],
            "rows": [
                { "id": 20, "aciklama": "Yüksüz test"},
                { "id": 21, "aciklama": "Yüklü test"},
                { "id": 22, "aciklama": "Dinamik test"}
            ]
          },
          {
            "type": "simpleTable",
            "headers": ["TESTLER", "Test Tarihi", "Değerlendirme"],
            "rows": [
                { "id": 23, "aciklama": "Statik test"},
                { "id": 24, "aciklama": "Düşmeyi engelleyici güvenlik tertibatı/tertibatları testi"}
            ]
          }
        ]
      },
      {
        "type": "footer",
        "text": "Değerlendirme \"Uygun\", \"Uygun Değil\" ve \"Uygulanamaz\" olarak yapılmıştır.",
        "style": {
            "borderTop": "1px solid #000",
            "paddingTop": "5px",
            "fontSize": "9px",
            "textAlign": "center"
        }
      }
    ]
  }

```

nasıl çalışır?

Elbette, anladım. Metni değiştirmeden, sadece Markdown formatında daha okunaklı hale getireceğim. İşte istediğiniz gibi düzenlenmiş metin:

***

# JSON Yapısı ve Deklaratif Kullanıcı Arayüzü Yaklaşımı

Bu JSON yapısı, **deklaratif (bildirimsel)** bir kullanıcı arayüzü yaklaşımını kullanır. Bunun anlamı şudur:
> "Ekranda neyin, nerede ve nasıl görüneceğini adım adım kodla çizmek yerine, istediğim sonucun bir planını veya tarifini JSON formatında sunuyorum."

Bu JSON'u, bir web sayfasını oluşturmak için yazılmış bir HTML ve CSS dosyası gibi düşünebilirsiniz, ama hepsi tek bir dosya içinde birleşmiş halde. Onu yorumlayacak bir **"görselleştirici" (renderer)** program, bu plana bakarak raporu ekrana veya bir PDF'e çizer.

---

## Mantığı Temel Parçalara Ayıralım

### 1. Hiyerarşik Yapı (Büyükten Küçüğe)
JSON, raporu mantıksal bölümlere ayırır, tıpkı belgenin kendisi gibi.

- **page**: En dıştaki ana nesne. Bütün raporu temsil eder.
- **layout**: Bir dizidir (`[]`). Raporun yukarıdan aşağıya doğru sıralanan ana bloklarını içerir. Bu bloklar `header`, `section`, `footer` gibi parçalardır. Görselleştirici, bu diziyi sırayla okur ve her bloğu ekrana yerleştirir.
- **section / subsection**: Raporun "1. GENEL BİLGİLER" veya "2.1. EKİPMAN ETİKET BİLGİLERİ" gibi numaralandırılmış bölümleridir. Her bölümün bir başlığı ve içeriği vardır.
- **rows**: Bir bölümün içindeki yatay satırları temsil eden bir dizidir. Her bir `row` nesnesi, raporda gördüğümüz bir satıra karşılık gelir.
- **cells**: Bir satırın (`row`) içindeki dikey hücreleri veya sütunları temsil eder. İşte sihrin büyük kısmı burada gerçekleşir.

---

### 2. Yerleşim (Layout) Mantığı: `flex`
Kullanıcı arayüzü tasarlamanın en zor kısımlarından biri, elemanları yan yana düzgün bir şekilde yerleştirmektir. İşte burada `flex` anahtarı devreye giriyor ve en önemli konseptlerden biridir.

#### `flex` Nedir?
Bir satır içindeki hücrelerin (`cell`) mevcut yatay alanı nasıl paylaşacağını belirten bir sayıdır. Bu, modern web tasarımındaki **CSS Flexbox** mantığıyla tamamen aynıdır.

#### Nasıl Çalışır?
- Eğer bir satırda tek bir hücre varsa ve `flex: 1` ise, o hücre satırın tamamını kaplar.
- Eğer bir satırda iki hücre varsa ve biri `flex: 3`, diğeri `flex: 2` ise:
    - Toplam `flex` değeri `3 + 2 = 5` olur.
    - İlk hücre mevcut alanın `3/5`'ini kaplar (%60).
    - İkinci hücre mevcut alanın `2/5`'ini kaplar (%40).

#### Örnek:
```json
"cells": [
  { "type": "labelInput", "label": "Periyodik kontrol başlangıç tarihi ve saati", "flex": 3 },
  { "type": "labelInput", "label": "Rapor tarihi", "flex": 2, "style": { "backgroundColor": "#E0EFFF" } }
]
```
Bu kod, görselleştiriciye şunu söyler:
> "Bir satır oluştur. İçine iki tane etiketli giriş alanı koy. İlkine mevcut genişliğin %60'ını, ikincisine ise %40'ını ver. Ayrıca, ikinci alanın arka planını mavi yap."

Bu `flex` sistemi, "bazı satırlarda 1, bazılarında 2, bazılarında 3 eleman var" ve "bazıları daha geniş" gibi sorunları mükemmel bir şekilde çözer.

---

### 3. Bileşen (Component) Mantığı: `type`
Her nesnenin bir `type` özelliği vardır. Bu, görselleştiriciye o nesnenin ne olduğunu ve onu nasıl çizmesi gerektiğini söyler.

- **`"type": "section"`**: "Burası ana bir bölüm, başlığını belirgin bir şekilde yaz ve etrafına bir çerçeve çiz."
- **`"type": "labelInput"`**: "Hem etiketi (label) olan hem de içine veri girilebilen bir alan oluştur."
- **`"type": "checkboxGroup"`**: "Bir etiket ve yanında seçilebilecek kutucuklar oluştur."
- **`"type": "splitTable"`**: Bu özel bir durum. "Muayene Kriterleri" bölümü standart bir tablo gibi değil, iki sütuna bölünmüş bir liste gibi. Bu yüzden ona özel bir bileşen tipi (`splitTable`) tanımladım. Görselleştirici bu tipi gördüğünde, veriyi iki sütuna ayırarak özel bir şekilde çizecektir.

---

### 4. Stil ve Tasarım: `style`
Her bileşenin bir `style` nesnesi olabilir. Bu da CSS'e çok benzer.

```json
"style": {
  "textAlign": "center",
  "fontWeight": "bold",
  "backgroundColor": "#E0EFFF"
}
```
Bu nesne, o bileşenin yazı tipi, rengi, hizalaması gibi görsel özelliklerini doğrudan tanımlar. Bu sayede, raporun birebir aynı görünmesi sağlanır.

---

## Özetle Çalışma Akışı

- Bir program (görselleştirici) bu JSON dosyasını okur.
- `layout` dizisindeki ilk elemandan başlar.
- Elemanın `type`'ına bakar (örneğin `section`). Gerekli bölüm çerçevesini ve başlığını çizer.
- Bölümün içindeki `rows` dizisine geçer.
- Her bir `row` için, içindeki `cells` dizisini okur.
- Satırdaki tüm `flex` değerlerini toplayarak her bir hücrenin genişliğini hesaplar.
- Her bir hücrenin `type`'ına bakarak (örneğin `labelInput`), o hücrenin içine ilgili bileşeni (etiket ve giriş kutusu) hesaplanan genişlikte çizer.
- Eğer bir `style` nesnesi varsa, o bileşenin görünümünü bu stile göre ayarlar.
- Tüm `layout` dizisi bitene kadar bu işlemi tekrar eder.

---

## Sonuç
Sonuç olarak bu JSON, raporun hem **Ne** içerdiğini (veri yapısı) hem de **Nasıl** göründüğünü (yerleşim ve stil) eksiksiz bir şekilde tarif eden, makine tarafından okunabilir bir tasarım planıdır.



advanced tablo mantığı:



Elbette, bu yeni tablo yapısı, önceki JSON'daki basit tablolardan daha karmaşık bir başlık (header) yapısına sahip. Bu durumu ifade etmek için, başlık tanımını hiyerarşik (ağaç yapısı gibi) hale getirmemiz gerekir.

Ana fikir şudur:
1.  Bazı başlıklar birden fazla alt başlığa sahiptir (`Koruma Elemanının`, `Ölçüm`, `RCD Testi`). Bunu, JSON'da `children` (çocuklar) dizisi ile temsil edeceğiz.
2.  Bir başlığın yatayda kaç sütun kapladığını belirtmek için `colspan` kullanılır.
3.  Bir başlığın dikeyde kaç satır kapladığını belirtmek için `rowspan` kullanılır (`No`, `Ölçüm noktası...` gibi başlıklar 2 satır kaplarken alt başlıklar tek satır kaplar).

İşte bu mantıkla, gösterdiğiniz tabloyu ifade eden JSON "subsection" bloğu:

```json
{
  "type": "section",
  "id": "5_1_dolayli_dokunma_kontrolu",
  "title": "5.1. SON TÜKETİM NOKTALARINDA DOLAYLI DOKUNMAYA KARŞI KORUMA YETERLİLİĞİ KONTROLÜ",
  "style": {
    "titleBackgroundColor": "#E0E0E0",
    "headerBackgroundColor": "#F0F0F0"
  },
  "rows": [
    {
      "cells": [
        {
          "type": "hierarchicalTable",
          "flex": 1,
          "headers": [
            { "text": "No", "rowspan": 2, "key": "no" },
            { "text": "Ölçüm noktası / Etiketi veya kodu", "rowspan": 2, "key": "olcumNoktasi" },
            {
              "text": "Koruma Elemanının",
              "colspan": 4,
              "children": [
                { "text": "In\n(A)", "key": "in_A" },
                { "text": "Açma eğrisi tipi", "key": "acmaEgrisiTipi" },
                { "text": "Açma akımı\nIa (A)", "key": "acmaAkimi_Ia" },
                { "text": "Toprak kısa devre akımı\nIk1 (A)", "key": "toprakKisaDevreAkimi_Ik1" }
              ]
            },
            {
              "text": "Ölçüm",
              "colspan": 2,
              "children": [
                { "text": "Ölçülen değer\nZx/Rx\n(Ω)", "key": "olculenDeger_ZxRx" },
                { "text": "Sınır değer\nZs /RA\n(Ω)", "key": "sinirDeger_ZsRA" }
              ]
            },
            {
              "text": "RCD Testi",
              "colspan": 3,
              "children": [
                { "text": "RCD tipi, dayanma akımı ve açma akımı\nIn(A) / IΔn(mA)", "key": "rcd_TipiAkimi" },
                { "text": "Açma akımı\nIΔ (mA)", "key": "rcd_AcmaAkimi_Id" },
                { "text": "Açma zamanı\nTΔ (ms)", "key": "rcd_AcmaZamani_Td" }
              ]
            },
            { "text": "Sonuç\n(Uygunluk notu)", "rowspan": 2, "key": "sonuc" }
          ],
          "data": [
            {
              "no": 1, "olcumNoktasi": "Tali Pano-1", "in_A": 40, "acmaEgrisiTipi": "C", "acmaAkimi_Ia": 0.03, "toprakKisaDevreAkimi_Ik1": 261.36, "olculenDeger_ZxRx": 0.88, "sinirDeger_ZsRA": 1666.67, "rcd_TipiAkimi": "AC, 40/0.03", "rcd_AcmaAkimi_Id": 24, "rcd_AcmaZamani_Td": 20, "sonuc": "NOT 1"
            },
            {
              "no": 2, "olcumNoktasi": "Tali Pano-2", "in_A": 40, "acmaEgrisiTipi": "C", "acmaAkimi_Ia": 0.03, "toprakKisaDevreAkimi_Ik1": 270.588, "olculenDeger_ZxRx": 0.85, "sinirDeger_ZsRA": 1666.67, "rcd_TipiAkimi": "AC, 40/0.03", "rcd_AcmaAkimi_Id": 23, "rcd_AcmaZamani_Td": 19, "sonuc": "NOT 1"
            },
            {
              "no": 3, "olcumNoktasi": "Tali Pano-3", "in_A": 40, "acmaEgrisiTipi": "C", "acmaAkimi_Ia": 0.03, "toprakKisaDevreAkimi_Ik1": 261.36, "olculenDeger_ZxRx": 0.88, "sinirDeger_ZsRA": 1666.67, "rcd_TipiAkimi": "AC, 40/0.03", "rcd_AcmaAkimi_Id": 25, "rcd_AcmaZamani_Td": 20, "sonuc": "NOT 1"
            },
            {
              "no": 15, "olcumNoktasi": "ANA PANO", "in_A": 500, "acmaEgrisiTipi": "TMŞ", "acmaAkimi_Ia": 0.3, "toprakKisaDevreAkimi_Ik1": 564.10, "olculenDeger_ZxRx": 0.39, "sinirDeger_ZsRA": 166.66, "rcd_TipiAkimi": "AC, 400/0.3", "rcd_AcmaAkimi_Id": 242, "rcd_AcmaZamani_Td": 21, "sonuc": "NOT 1"
            },
            {
              "no": 16, "olcumNoktasi": "AF 31 TORNA TEZG", "in_A": "-", "acmaEgrisiTipi": "-", "acmaAkimi_Ia": "-", "toprakKisaDevreAkimi_Ik1": "-", "olculenDeger_ZxRx": 1.2, "sinirDeger_ZsRA": 5, "rcd_TipiAkimi": "-", "rcd_AcmaAkimi_Id": "-", "rcd_AcmaZamani_Td": "-", "sonuc": "NOT 1"
            }
          ]
        }
      ]
    }
  ]
}
```

### Bu JSON Nasıl Çalışır?

1.  **`"type": "hierarchicalTable"`**: Görselleştiriciye bunun basit bir tablo değil, karmaşık başlıklara sahip bir tablo olduğunu söyler.
2.  **`headers` Dizisi**: Bu dizi, başlığın en üst satırını tanımlar.
    *   **Basit Başlıklar**: `"No"` gibi başlıklar `rowspan: 2` alır, çünkü dikey olarak iki satır kaplarlar ve altlarında başka bir başlık yoktur.
    *   **Karmaşık Başlıklar**: `"Koruma Elemanının"` gibi başlıklar:
        *   `colspan: 4` alır, çünkü yatay olarak 4 alt başlık sütununu kaplar.
        *   `children` adında bir dizi içerir. Bu dizi, onun altındaki ikinci satırda yer alacak başlıkları (`In (A)`, `Açma eğrisi tipi` vb.) tanımlar. Görselleştirici, bu `children` dizisini okuyarak tablonun ikinci başlık satırını oluşturur.
3.  **`key` Alanı**: Her başlığa benzersiz bir `key` atadık (`no`, `olcumNoktasi`, `in_A` vb.). Bu, `data` dizisindeki verileri doğru sütunla eşleştirmeyi çok kolaylaştırır.
4.  **`data` Dizisi**: Her satır, bir JavaScript nesnesidir. Bu nesnenin anahtarları (`key`'leri), `headers` bölümünde tanımladığımız `key`'lerle birebir aynıdır. Bu sayede `"olcumNoktasi": "Tali Pano-1"` verisinin hangi sütuna ait olduğu net bir şekilde bellidir.

Bu yapı, ne kadar karmaşık olursa olsun neredeyse her türlü tabloyu esnek ve okunabilir bir şekilde tanımlamanıza olanak tanır.