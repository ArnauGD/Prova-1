

#Per comprovar que la connexió TCP funciona correctament, farem la comanda Test-NetConnection, al port 80, i li direm que ens doni informació detallada
#a la mateixa comanda farem que només ens doni la informació referent al TCPtestSucceeded, per així comprovar si es troba en false o true.

$tcptest = Test-NetConnection -Port 80 -InformationLevel "Detailed" | % {Write-Host $_.TcpTestSucceeded}

#Farem una condició on si és false sortirà el missatge de que no es correcta i si es true donarà en missatge de que és correcta.

if ($tcptest = $true){
    
    #Carregarem el assembly 

    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

    #Per mostrar el quadre de missatges, cridarem a la funció estàtica show

    [System.Windows.Forms.MessageBox]::Show('La connexió TCP ha sigut correcta','Success')


}
# farem el mateix que abans pero ara per la opció false
elseif ($tcptest = $false) {

    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

    [System.Windows.Forms.MessageBox]::Show('La connexió TCP no ha sigut correcta','Failure')

}

