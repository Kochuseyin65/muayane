# Dinamik Şablon v2 Tasarım Notları

Bu belge, ekipman ve muayene şablonlarının yeni JSON tabanlı v2 formatını tanımlar. Amaç; aynı şema üzerinden hem form (frontend) hem de rapor (PDF/HTML) çıktılarının üretilebilmesi, karmaşık tabloların yönetilebilmesi ve layout ihtiyaçlarının tek kaynakta toplanmasıdır.

## 1. Genel Mimari

- **Sürüm etiketi**: Her şablon `"version": "2.0"` alanını içermeli. Renderer bu sayede v1 (legacy) ile v2'yi ayırır.
- **Kök yapı**: `page` nesnesi → `layout` dizisi → `section` / `subsection` → `rows` → `cells` → `component`.
- **Veri bağlama**: Girdi üreten her bileşen `binding.name` anahtarına sahip olmalı. Değerler varsayılan olarak `inspection_data[binding.name]` altında saklanır.
- **Stil önceliği**: `component.style` > `cell.style` > `row.style` > `section.style` > `page.style`.
- **Renderer ilkesi**: Layout sırası korunur; section ve subsection'lar bağımsız kutular gibi ele alınır.

## 2. Page Seviyesi

```json
{
  "version": "2.0",
  "page": {
    "id": "asili_erisim_raporu",
    "title": "ASILI ERİŞİM DONANIMI PERİYODİK KONTROL RAPORU",
    "theme": { "scale": "medium" },
    "style": {
      "fontFamily": "Arial, sans-serif",
      "fontSize": "10px",
      "backgroundColor": "#FFFFFF"
    },
    "meta": {
      "documentCode": "ZPKR07",
      "issueDate": "26/09/2025"
    },
    "layout": [ ... ]
  }
}
```

- `page.meta`: Serbest anahtarlar (doküman kodu, revizyon bilgisi vb.). Renderer header bölgesinde kullanır.
- `theme.scale`: `small | medium | large` → PDF margin, satır aralığı, font boyutu.

## 3. Section & Subsection

```json
{
  "type": "section",
  "id": "2_ekipman_bilgileri",
  "title": "2. EKİPMAN BİLGİLERİ",
  "style": {
    "border": "1px solid #333",
    "titleBackgroundColor": "#d9d9d9"
  },
  "subsections": [
    {
      "type": "subsection",
      "id": "2_1_etiket",
      "title": "2.1. EKİPMAN ETİKET BİLGİLERİ",
      "rows": [ ... ]
    }
  ],
  "rows": [ ... ]
}
```

- `section.rows`: Doğrudan satırlar; `subsections` ile paralel kullanılabilir.
- `visibility`: `{ "field": "binding", "equals": "value" }` formatında koşullu gösterim hem section hem subsection için desteklenecek.
- `style.variant`: `panel | borderless | highlight` gibi ön tanımlı şablonlar.

## 4. Satır (row)

```json
{
  "id": "row_1",
  "cells": [ ... ],
  "gutter": 8,
  "direction": "row",
  "repeat": {
    "source": "inspection_data.testler",
    "template": { "testAdi": "", "tarih": "" },
    "minRows": 3,
    "maxRows": 20,
    "addButton": { "label": "Satır Ekle" }
  }
}
```

- `gutter`: Hücreler arası boşluk (px). Varsayılan 8.
- `direction`: `row` veya `column`.
- `repeat`: Diziler için satır çoğaltma. `source` JSONPath benzeri (`inspection_data.bakim_kayitlari`). `template` varsayılan satır değeri.

## 5. Hücre (cell)

```json
{
  "flex": 3,
  "span": { "rows": 1, "columns": 1 },
  "style": {
    "backgroundColor": "#E0EFFF",
    "align": "center",
    "border": "1px solid #7f7f7f"
  },
  "component": { ... }
}
```

- `flex`: Satır genişliğinin paylaşımı. `flex` belirtilmezse 1 kabul edilir.
- `span`: Çok satırlı/dikey birleşen hücreler için destek (opsiyonel).
- `style.align`: `left | center | right`.

## 6. Bileşen Tipleri

### 6.1 Ortak Alanlar

```json
{
  "type": "input",
  "binding": {
    "name": "isyerinin_unvani",
    "path": "inspection_data.isyerinin_unvani"
  },
  "label": "İşyerinin Ünvanı",
  "placeholder": "",
  "required": false,
  "readonly": false,
  "description": "",
  "style": { ... }
}
```

- `binding.name`: Zorunlu, benzersiz olmalı.
- `binding.path`: Varsayılan `inspection_data[binding.name]`. Özel path gerekirse belirtilir (`inspection_data.testler[].deger`).
- `defaultValue`: İlk render’da doldurulacak değer.

### 6.2 Form Bileşenleri

| Tip            | Açıklama                        | Ek Alanlar |
|----------------|---------------------------------|------------|
| `input`        | Tek satırlı giriş               | `inputType: text|number|date|time`, `min`, `max`, `step`, `mask`
| `textarea`     | Çok satırlı metin               | `rows`, `autoResize`
| `select`       | Açılır liste                    | `options: [{ label, value }]`, `multiple`, `allowCustom`
| `checkboxGroup`| Çoklu seçim kutucukları         | `options`, `layout: row|column`, `maxSelection`
| `radioGroup`   | Tek seçim                       | `options`, `inline`
| `switch`       | Aç/Kapa                         | `trueLabel`, `falseLabel`
| `dateRange`    | Başlangıç-bitiş tarihi          | `binding.endName`, `displayFormat`

### 6.3 Görsel Bileşenler

| Tip        | Açıklama                         | Ek Alanlar |
|------------|----------------------------------|------------|
| `label`    | Statik metin                     | `variant`, `align`, `color`
| `note`     | Bilgilendirici metin             | `icon`, `highlight`
| `divider`  | Yatay çizgi                      | `thickness`, `color`
| `metaGrid` | Header içi etiket-değer grid'i   | `columns`, `items[{label,value}]`

### 6.4 Tablo Bileşenleri

| Tip                  | Açıklama                                                 | Ek Alanlar |
|----------------------|---------------------------------------------------------|------------|
| `simpleTable`        | Sabit kolon/satır – sadece görüntü veya sınırlı input    | `columns`, `rows`, `editable`
| `table`              | `repeat` tabanlı klasik tablo                            | `columns`, `actions`
| `hierarchicalTable`  | Çok satırlı başlık, colspan/rowspan desteği             | `headers`, `data`, `rowStyle`
| `splitTable`         | İki kolonlu sabit metin listesi                          | `left`, `right` koleksiyonları

#### 6.4.1 HierarchicalTable

```json
{
  "type": "hierarchicalTable",
  "binding": { "name": "dolayli_dokunma" },
  "headers": [
    { "text": "No", "rowspan": 2, "key": "no" },
    {
      "text": "Koruma Elemanının",
      "colspan": 4,
      "children": [
        { "text": "In (A)", "key": "in_A" },
        { "text": "Açma eğrisi tipi", "key": "acmaEgrisiTipi" },
        { "text": "Açma akımı Ia (A)", "key": "acmaAkimi_Ia" },
        { "text": "Toprak kısa devre akımı Ik1 (A)", "key": "toprakKisaDevreAkimi_Ik1" }
      ]
    },
    ...
  ],
  "data": [ { "no": 1, "in_A": 40, ... } ]
}
```

- `headers[].key`: Satır verisini eşleştirmek için zorunlu.
- `children`: Alt başlık satırlarını tanımlar, `colspan` değerine eşit sayıda çocuk olmalı.
- `data`: Dizi; her eleman bir satır. Eksik anahtarlar boş çizilir.
- `rowActions`: Form tarafında satır ekleme/silme için kullanılabilir.

### 6.5 Medya Bileşenleri

| Tip         | Açıklama                   | Ek Alanlar |
|--------------|---------------------------|------------|
| `photo`      | Foto galerisi              | `binding.field`, `maxCount`, `uploadPreset`
| `signature`  | İmza alanı                 | `role`, `dateBinding`

## 7. Veri Kaydetme

- Varsayılan kural: `inspection_data[binding.name] = değer`.
- `binding.path` ile iç içe alanlar (`inspection_data.testler[0].deger`). Path JSONPath benzeri (`.` ve `[]`).
- `repeat` satırlarında index otomatik uygulanır (`binding.name` → `inspection_data.testler[0].field`).
- `computed`: `{ "expression": "{dinamik_test_yuku} * 1.25", "mode": "readonly" }`. Değer runtime’da hesaplanır, formda düzenlenemez.
- `validation`: `rules`: `[ { "rule": "required" }, { "rule": "min", "value": 0 } ]`. Desteklenecek kural seti: `required`, `min`, `max`, `regex`, `requiredWith`, `custom`.

## 8. Stil Sistemi

- Desteklenen stil anahtarları: `backgroundColor`, `color`, `fontWeight`, `fontSize`, `textAlign`, `border`, `padding`, `margin`, `className`, `align`, `height`, `width`.
- PDF’de desteklenmeyen özellikler (ör. `position`, `boxShadow`) validasyonda reddedilir.
- Tema varyantları: `style.variant = panel|bordered|inset` vb. Renderer bu varyantları CSS sınıfı olarak uygular.

## 9. Validasyon Akışı (`validateTemplateV2`)

1. `version === "2.0"` kontrolü.
2. `page.layout` dizisi var mı, her elemanın `type` değeri desteklenen set içinde mi (`header`, `section`, `subsection`, `footer`)?
3. `section.id` benzersiz mi? Başlığı var mı (header hariç)?
4. Tüm `component` tipleri için tip bazlı zorunlu alanlar mevcut mu (`binding.name`, `options` vs.).
5. Aynı `binding.name` farklı bileşenler tarafından kullanılıyor mu? (Allow list: computed alanlar.)
6. `repeat.source` ifadesi geçerli path formatında mı? (Statik doğrulama + runtime kontrol.)
7. `hierarchicalTable.headers` dizisinde `rowspan/colspan` değerleri mantıklı mı (çocuk sayısı)?
8. Stil whitelist kontrolleri.

## 10. Legacy Uyum & Migrasyon

- v1 → v2 dönüştürücü script (`scripts/convert_template_v1_to_v2.js`).
  - `key_value` → `rows` + `cells` + `component: input`.
  - `fields` tabanlı tablolar → `repeat` veya `simpleTable`.
- `inspections` tablosuna `template_version` alanı eklenir. Kayıt sırasında hangi şablon sürümü kullanıldığı tutulur.
- Renderer’lar v1 desteklemeye devam eder; v2 desteği eklendikten sonra aşamalı geçiş yapılır.

## 11. Template Builder Gereksinimleri

- Bölüm/satır/hücre sürükle-bırak düzenleyici.
- Bileşen paleti (input, select, tablo vb.).
- Bileşen seçildiğinde `binding`, `label`, `options`, `validation`, `style` düzenlenebilmeli.
- `hierarchicalTable` için başlık editörü (rowspan/colspan UI).
- JSON çıktısı otomatik prettify + değişiklik uyarıları.
- Şablon kaydedilmeden önce `validateTemplateV2` çalıştırılıp hata listesi gösterilmeli.

## 12. Geliştirme Yol Haritası

1. JSON Schema taslağı (`docs/template-v2.schema.json`) ve `validateTemplateV2` implementasyonu.
2. PDF renderer (`reportRenderer.js`) ve form renderer (`InspectionFormPage.tsx`) için v2 desteği.
3. Veri katmanı: `binding.path` kurallarına göre API’nin güncellenmesi (inspection save/update).
4. Template Builder’ın v2 bileşenleri üretmesi.
5. Örnek şablonla (docs/example-template-v2.md) uçtan uca testler.
6. Legacy migrasyon ve dokümantasyon.

## 13. Açık Sorular

- Çok dilli etiketler için format: `label` alanı JSON obje (örn. `{ "tr": "Ad", "en": "Name" }`) mı, yoksa global anahtar mı?
- `computed` alanlar backend tarafında güvenli biçimde nasıl değerlendirilecek (mini expression parser)?
- PDF’de geniş tablolarda sayfa taşması için `breakStrategy` veya `allowPageBreak` alanı gerekli mi?
- Template Builder’da kullanıcıya `binding.name` otomatik önerilsin mi (slugify) yoksa manuel mi bırakılacak?

---

Bu doküman v2 şablon formatı için referans niteliğindedir. Yeni gereksinimler çıktıkça güncellenmeli ve renderer/builder görevleriyle eşleştirilmelidir.
