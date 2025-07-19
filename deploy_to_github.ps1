# GitHub Deployment Script
# Almanya Üniversite Gezi Rehberi Projesi

Write-Host "=== GitHub Deployment Script ===" -ForegroundColor Green
Write-Host "Proje: Almanya Üniversite Gezi Rehberi" -ForegroundColor Yellow
Write-Host ""

# Mevcut dizini kontrol et
$currentDir = Get-Location
Write-Host "Mevcut dizin: $currentDir" -ForegroundColor Cyan

# Git durumunu kontrol et
Write-Host "Git durumu kontrol ediliyor..." -ForegroundColor Yellow
try {
    $gitStatus = git status --porcelain
    if ($gitStatus) {
        Write-Host "Uncommitted değişiklikler bulundu:" -ForegroundColor Red
        git status
        
        $response = Read-Host "Bu değişiklikleri commit etmek istiyor musunuz? (y/n)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            git add .
            $commitMessage = Read-Host "Commit mesajı girin (boş bırakırsanız varsayılan kullanılır)"
            if ([string]::IsNullOrWhiteSpace($commitMessage)) {
                $commitMessage = "Proje güncellemesi - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
            }
            git commit -m $commitMessage
            Write-Host "Değişiklikler commit edildi." -ForegroundColor Green
        }
    } else {
        Write-Host "Tüm değişiklikler commit edilmiş." -ForegroundColor Green
    }
} catch {
    Write-Host "Git durumu kontrol edilemedi: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Repository bilgileri
$repoName = "german-universities-map"
$githubUsername = "tolgaaytekinlogo"
$repoUrl = "https://github.com/$githubUsername/$repoName.git"

Write-Host ""
Write-Host "=== Repository Bilgileri ===" -ForegroundColor Green
Write-Host "GitHub Kullanıcı Adı: $githubUsername" -ForegroundColor Cyan
Write-Host "Repository Adı: $repoName" -ForegroundColor Cyan
Write-Host "Repository URL: $repoUrl" -ForegroundColor Cyan
Write-Host ""

# Remote kontrolü
Write-Host "Remote repository kontrol ediliyor..." -ForegroundColor Yellow
try {
    $remotes = git remote -v
    if ($remotes -match "origin") {
        Write-Host "Origin remote zaten mevcut:" -ForegroundColor Yellow
        git remote -v
        
        $response = Read-Host "Mevcut remote'u güncellemek istiyor musunuz? (y/n)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            git remote set-url origin $repoUrl
            Write-Host "Remote URL güncellendi." -ForegroundColor Green
        }
    } else {
        Write-Host "Origin remote ekleniyor..." -ForegroundColor Yellow
        git remote add origin $repoUrl
        Write-Host "Origin remote eklendi." -ForegroundColor Green
    }
} catch {
    Write-Host "Remote işlemi başarısız: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Branch kontrolü ve ayarlama
Write-Host ""
Write-Host "Branch kontrol ediliyor..." -ForegroundColor Yellow
try {
    $currentBranch = git branch --show-current
    Write-Host "Mevcut branch: $currentBranch" -ForegroundColor Cyan
    
    if ($currentBranch -ne "main") {
        Write-Host "Branch 'main' olarak ayarlanıyor..." -ForegroundColor Yellow
        git branch -M main
        Write-Host "Branch 'main' olarak ayarlandı." -ForegroundColor Green
    }
} catch {
    Write-Host "Branch işlemi başarısız: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# GitHub'a push
Write-Host ""
Write-Host "=== GitHub'a Push İşlemi ===" -ForegroundColor Green
Write-Host "UYARI: GitHub'da '$repoName' adında bir repository oluşturduğunuzdan emin olun!" -ForegroundColor Red
Write-Host "Repository URL: https://github.com/$githubUsername/$repoName" -ForegroundColor Cyan
Write-Host ""

$response = Read-Host "GitHub'da repository oluşturdunuz mu ve push işlemine devam etmek istiyor musunuz? (y/n)"
if ($response -eq 'y' -or $response -eq 'Y') {
    try {
        Write-Host "Push işlemi başlatılıyor..." -ForegroundColor Yellow
        git push -u origin main
        
        Write-Host ""
        Write-Host "=== BAŞARILI! ===" -ForegroundColor Green
        Write-Host "Proje başarıyla GitHub'a yüklendi!" -ForegroundColor Green
        Write-Host ""
        Write-Host "=== Sonraki Adımlar ===" -ForegroundColor Yellow
        Write-Host "1. GitHub repository sayfanıza gidin: https://github.com/$githubUsername/$repoName" -ForegroundColor Cyan
        Write-Host "2. Settings > Pages sekmesine gidin" -ForegroundColor Cyan
        Write-Host "3. Source: 'Deploy from a branch' seçin" -ForegroundColor Cyan
        Write-Host "4. Branch: 'main' ve Folder: '/ (root)' seçin" -ForegroundColor Cyan
        Write-Host "5. Save butonuna tıklayın" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Site URL'niz: https://$githubUsername.github.io/$repoName/" -ForegroundColor Green
        Write-Host ""
        
    } catch {
        Write-Host "Push işlemi başarısız: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        Write-Host "=== Olası Çözümler ===" -ForegroundColor Yellow
        Write-Host "1. GitHub'da repository'nin oluşturulduğunu kontrol edin" -ForegroundColor Cyan
        Write-Host "2. Internet bağlantınızı kontrol edin" -ForegroundColor Cyan
        Write-Host "3. GitHub kullanıcı adı ve şifrenizi kontrol edin" -ForegroundColor Cyan
        Write-Host "4. Personal Access Token gerekebilir (2FA aktifse)" -ForegroundColor Cyan
        exit 1
    }
} else {
    Write-Host "İşlem iptal edildi. Önce GitHub'da repository oluşturun." -ForegroundColor Yellow
    Write-Host "Repository oluşturma linki: https://github.com/new" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Script tamamlandı. Herhangi bir tuşa basın..." -ForegroundColor Gray
Read-Host
