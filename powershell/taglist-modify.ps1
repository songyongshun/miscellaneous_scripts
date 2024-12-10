# 导入必要的程序集  
# 是在dotnet add的时候添加的.
$tagLibPath = "C:\Users\Lenovo\.nuget\2.3.0\lib\netstandard2.0\TagLibSharp.dll"
Add-Type -Path $tagLibPath

# 指定要遍历的文件夹路径  
$folderPath = "C:\Users\Lenovo\docf\jianing\英语资料\牛津树\音频-英音\level-1"  

# 获取所有 MP3 文件  
$mp3Files = Get-ChildItem -Path $folderPath -Filter *.mp3  

foreach ($file in $mp3Files) {  
    try {  
        # 使用 TagLibSharp 创建文件对象  
        $tfile = [TagLib.File]::Create($file.FullName)  

        # 获取当前文件的原始标题和时长  
        $originalTitle = $tfile.Tag.Title  
        $duration = $tfile.Properties.Duration  

        # 输出原始标题和时长  
        Write-Host "Original Title: $originalTitle, Duration: $duration"  

        # 使用文件名（不带扩展名）更新标题  
        $newTitle = [IO.Path]::GetFileNameWithoutExtension($file.Name)  
        $tfile.Tag.Title = $newTitle  
        $tfile.Save()  

        # 输出更新后的标题  
        Write-Host "Updated Title: $($tfile.Tag.Title)"  
    } catch {  
        Write-Warning "Error processing $($file.FullName): $_"  
    }  
}
