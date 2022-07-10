# Oh my posh  https://docs.microsoft.com/zh-cn/windows/terminal/tutorials/custom-prompt-setup
Install-Module oh-my-posh -Scope CurrentUser
Install-Module posh-git -Scope CurrentUser

# Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module Terminal-Icons