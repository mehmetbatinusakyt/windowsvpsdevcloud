
FROM mcr.microsoft.com/windows/server


RUN Invoke-WebRequest https://raw.githubusercontent.com/TheDarkMythos/Ngrok-Exe/master/ngrok.exe -OutFile ngrok.exe
RUN Invoke-WebRequest https://raw.githubusercontent.com/mehmetbatinusakyt/WindowsVPS2021/main/Files/nssm.exe -OutFile nssm.exe
RUN copy nssm.exe C:\Windows\System32
RUN copy ngrok.exe C:\Windows\System32
RUN .\ngrok.exe authtoken 
RUN Invoke-WebRequest https://raw.githubusercontent.com/mehmetbatinusakyt/WindowsVPS2021/main/Files/NGROK-US.bat -OutFile NGROK-US.bat
RUN Invoke-WebRequest https://raw.githubusercontent.com/mehmetbatinusakyt/WindowsVPS2021/main/Files/NGROK-CHECK.bat -OutFile NGROK-CHECK.bat
RUN Invoke-WebRequest https://raw.githubusercontent.com/mehmetbatinusakyt/WindowsVPS2021/main/Files/loop.bat -OutFile loop.bat
RUN Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
RUN Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
RUN Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
RUN sc start ngrok
RUN cmd /c NGROK-CHECK.bat
RUN cmd /c loop.bat 

CMD ["dir"]
