# clip-keyword.ps1 — 클립보드에 키워드가 들어오면 GitHub에 올린 해당 글을 클립보드에 넣음
param(
    [string]$BaseUrl = 'https://raw.githubusercontent.com/Kainax001/anytime/main/texts'
)

# 키워드 → 글 파일 (보들레드는 오타로 들어와도 되도록 같이 둠)
$map = @{
    '보들레르' = '1-baudelaire.txt'
    '보들레드' = '1-baudelaire.txt'
    '바그너'   = '2-wagner.txt'
    '마네'     = '3-manet.txt'
    '마티스'   = '4-matisse.txt'
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$web = New-Object Net.WebClient
$web.Encoding = [Text.Encoding]::UTF8
$cache = @{}
$lastSeen = $null

while ($true) {
    $clip = Get-Clipboard -Raw
    if ($clip -ne $lastSeen) {
        $lastSeen = $clip
        $word = "$clip".Trim()
        if ($map.ContainsKey($word)) {
            $file = $map[$word]
            try {
                $cache[$file] = $web.DownloadString("$BaseUrl/$file")
            } catch {
                # 인터넷이 안 되면 전에 받아 둔 내용을 씀
            }
            if ($cache[$file]) {
                Set-Clipboard -Value $cache[$file]
                $lastSeen = Get-Clipboard -Raw   # 직접 넣은 글은 키워드 검사에서 제외
            }
        }
    }
    Start-Sleep -Milliseconds 500
}
