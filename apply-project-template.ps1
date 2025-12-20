$apps = @(
  @{ slug="weather"; title="Weather App"; subtitle="Şehir arama, hava durumu verisi ve durum yönetimi." },
  @{ slug="todo"; title="To Do List"; subtitle="Görev ekleme/silme/tamamlama, kalıcı kayıt." },
  @{ slug="quiz"; title="Quiz App"; subtitle="Soru akışı, skor ve sonuç ekranı." },
  @{ slug="calculator"; title="Calculator"; subtitle="Temel işlemler, klavye desteği, sağlam input." },
  @{ slug="qr-generator"; title="QR Code Generator"; subtitle="Metinden QR üretimi, indirme, doğrulama." },
  @{ slug="music-player"; title="Music Player"; subtitle="Playlist, progress bar, ses kontrolü." }
)

$css = @'
:root{
  --bg:#0b1020;
  --text:rgba(255,255,255,.92);
  --muted:rgba(255,255,255,.65);
  --panel:rgba(255,255,255,.06);
  --border:rgba(255,255,255,.12);
  --shadow: 0 12px 40px rgba(0,0,0,.35);
  --radius: 18px;
  --max: 900px;
}

*{ box-sizing:border-box; }
body{
  margin:0;
  font-family: system-ui, Arial, sans-serif;
  background: radial-gradient(900px 520px at 15% 10%, rgba(76,110,245,.22), transparent 60%), var(--bg);
  color: var(--text);
  line-height: 1.55;
}

a{ color: inherit; text-decoration: none; }
a:hover{ text-decoration: underline; }
a:focus-visible{
  outline: 3px solid rgba(76,110,245,.9);
  outline-offset: 3px;
  border-radius: 12px;
}

.container{
  width: min(var(--max), calc(100% - 32px));
  margin: 24px auto;
}

.top{
  display:flex;
  align-items:flex-start;
  justify-content:space-between;
  gap: 16px;
  margin-bottom: 14px;
}

.back{
  color: var(--muted);
  border: 1px solid var(--border);
  padding: 8px 10px;
  border-radius: 12px;
  text-decoration: none;
}
.back:hover{ background: rgba(255,255,255,.06); text-decoration:none; }

.card{
  border: 1px solid var(--border);
  background: linear-gradient(180deg, rgba(255,255,255,.08), var(--panel));
  border-radius: 22px;
  padding: 16px;
  box-shadow: var(--shadow);
}

.muted{ color: var(--muted); margin-top: 6px; }
'@

foreach ($app in $apps) {
  $slug = $app.slug
  $title = $app.title
  $subtitle = $app.subtitle

  $base = "projects\$slug"
  $htmlPath = "$base\index.html"
  $cssPath = "$base\css\style.css"
  $jsPath = "$base\js\app.js"

  if (-not (Test-Path $base)) { continue }

  $html = @"
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>$title</title>
  <link rel="stylesheet" href="./css/style.css" />
</head>
<body>
  <main class="container">
    <header class="top">
      <div>
        <h1>$title</h1>
        <p class="muted">$subtitle</p>
      </div>
      <a class="back" href="../../index.html">← Ana sayfa</a>
    </header>

    <section class="card">
      <h2>Scope</h2>
      <ul>
        <li>UI iskeleti</li>
        <li>Core logic</li>
        <li>Edge cases</li>
        <li>Polish + responsive</li>
      </ul>
    </section>
  </main>

  <script src="./js/app.js"></script>
</body>
</html>
"@

  Set-Content -Path $cssPath -Value $css -Encoding utf8
  Set-Content -Path $htmlPath -Value $html -Encoding utf8

  if (-not (Test-Path $jsPath) -or [string]::IsNullOrWhiteSpace((Get-Content $jsPath -Raw))) {
    Set-Content -Path $jsPath -Value "// app.js`nconsole.log('Ready');" -Encoding utf8
  }
}

Write-Output "Project templates applied."
