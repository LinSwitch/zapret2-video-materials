$InputFullPath  = Join-Path $PSScriptRoot "blockcheck2.log"
$OutputFullPath = Join-Path $PSScriptRoot "clean_summary.txt"

if (-not (Test-Path $InputFullPath)) { Write-Error "Исходный файл blockcheck2.log не найден в папке $PSScriptRoot!"; exit }

$reader = [System.IO.StreamReader]::new($InputFullPath, [System.Text.Encoding]::UTF8)
$writer = [System.IO.StreamWriter]::new($OutputFullPath, $false, [System.Text.Encoding]::UTF8)

$prevLine = ""

while (($currentLine = $reader.ReadLine()) -ne $null) {
    $currentLine = $currentLine.Trim()
    if ([string]::IsNullOrEmpty($currentLine)) { continue }

    if ($currentLine.StartsWith("* script :")) {
        $writer.WriteLine("`r`n" + $currentLine)
        $writer.WriteLine("-" * $currentLine.Length)
        continue
    }

    if ($currentLine -like "*!!!!! AVAILABLE !!!!!*") {
        if (-not [string]::IsNullOrEmpty($prevLine)) {
            if ($prevLine.StartsWith("- ")) {
                $prevLine = $prevLine.Substring(2)
            }
            $writer.WriteLine("  " + $prevLine)
        }
    }

    $prevLine = $currentLine
}

$reader.Close()
$writer.Close()
Write-Host "🎉 Готово! Проверяй clean_summary.txt" -ForegroundColor Green
