# GitHub'a Manuel Deployment Rehberi

## Adım 1: GitHub'da Repository Oluşturma

1. **GitHub'a gidin**: https://github.com
2. **Giriş yapın**: tolgaaytekinlogo hesabınızla
3. **Yeni repository oluşturun**:
   - Sağ üst köşedeki **"+"** butonuna tıklayın
   - **"New repository"** seçin
   - **Repository name**: `german-universities-map`
   - **Description**: `Almanya Üniversite Gezi Rehberi - İnteraktif harita ve günlük planlama uygulaması`
   - **Public** olarak işaretleyin (GitHub Pages için gerekli)
   - **❌ Initialize this repository with a README** - İŞARETLEMEYİN (zaten var)
   - **Create repository** butonuna tıklayın

## Adım 2: Local Repository'yi GitHub'a Bağlama

Repository oluşturduktan sonra, aşağıdaki komutları **PowerShell** veya **Command Prompt**'ta çalıştırın:

### Komutlar (Sırayla çalıştırın):

```bash
# 1. Proje klasörüne gidin (zaten oradasınız)
cd "c:\Users\TolgaA\CascadeProjects\GermanUniversitiesMap\Site"

# 2. GitHub remote'unu ekleyin
git remote add origin https://github.com/tolgaaytekinlogo/german-universities-map.git

# 3. Ana branch'i main olarak ayarlayın
git branch -M main

# 4. Projeyi GitHub'a push edin
git push -u origin main
```

## Adım 3: GitHub Pages Aktifleştirme

1. **GitHub repository sayfanızda**:
   - **Settings** sekmesine gidin
   - Sol menüden **Pages** seçin
   - **Source** bölümünde **"Deploy from a branch"** seçin
   - **Branch** olarak **"main"** seçin
   - **Folder** olarak **"/ (root)"** seçin
   - **Save** butonuna tıklayın

2. **Birkaç dakika bekleyin**, GitHub Pages sitenizi hazırlayacak
3. **Site URL'niz**: `https://tolgaaytekinlogo.github.io/german-universities-map/`

## Adım 4: Doğrulama

Deployment başarılı olduktan sonra:
- Ana sayfa: `https://tolgaaytekinlogo.github.io/german-universities-map/`
- Gezi rehberi: `https://tolgaaytekinlogo.github.io/german-universities-map/seyahat_rehberi_ana.html`
- Günlük plan: `https://tolgaaytekinlogo.github.io/german-universities-map/dinamik_gunluk_plan_kartlari.html`

## Sorun Giderme

### Eğer "git push" komutu hata verirse:
```bash
# GitHub kullanıcı adı ve token ile authentication
git config --global user.name "tolgaaytekinlogo"
git config --global user.email "tolgaaytekin@gmail.com"

# Personal Access Token gerekebilir
# GitHub Settings > Developer settings > Personal access tokens > Generate new token
```

### Eğer repository zaten varsa:
```bash
# Mevcut remote'u kontrol edin
git remote -v

# Eğer farklı bir URL varsa, güncelleyin
git remote set-url origin https://github.com/tolgaaytekinlogo/german-universities-map.git
```

## Güncelleme Yapmak İçin

Gelecekte proje dosyalarınızı güncelledikten sonra:

```bash
# Değişiklikleri ekleyin
git add .

# Commit yapın
git commit -m "Güncelleme açıklaması"

# GitHub'a push edin
git push origin main
```

## Notlar

- ✅ Git repository zaten oluşturuldu
- ✅ İlk commit yapıldı
- ✅ README.md ve index.html eklendi
- ✅ Git config ayarlandı (user.name ve user.email)
- 🔄 Şimdi sadece GitHub'da repository oluşturup push etmeniz gerekiyor

## Yardım

Herhangi bir sorunla karşılaştığınızda:
1. Hata mesajını not alın
2. GitHub repository'nin doğru oluşturulduğunu kontrol edin
3. Internet bağlantınızı kontrol edin
4. Personal Access Token gerekebilir (GitHub 2FA aktifse)
