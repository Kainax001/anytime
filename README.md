# clip-texts

클립보드에 키워드를 복사하면 해당 글(`texts/`)을 GitHub에서 받아 클립보드에 넣어 주는 PowerShell 스크립트입니다.

| 키워드 | 글 |
|---|---|
| 보들레르 (보들레드) | `texts/1-baudelaire.txt` |
| 바그너 | `texts/2-wagner.txt` |
| 마네 | `texts/3-manet.txt` |
| 마티스 | `texts/4-matisse.txt` |

## 실행 (창 없이 백그라운드)

```powershell
Start-Process powershell -WindowStyle Hidden -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "C:\경로\clip-keyword.ps1"'
```

## 중지

```powershell
Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" | Where-Object CommandLine -like '*clip-keyword.ps1*' | ForEach-Object { Stop-Process -Id $_.ProcessId }
```

글을 GitHub에서 고치면 다음 키워드 복사 때 반영됩니다(GitHub 캐시 때문에 최대 5분 정도 늦을 수 있음).
