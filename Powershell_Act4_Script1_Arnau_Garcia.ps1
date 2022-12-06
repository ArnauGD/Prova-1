
#El primer que farme serà demanar les credencial a l'usuari que executa el script (hauran d'introduir el correu i la contrasenya proporcionada per google)

$mycredentials = Get-Credential

#Agafem els parametres, el directori origen amb la seva ruta absoluta
#i el directori destí on es copiarà

$origen = Read-Host "Ruta del fitxer a copiar"

$destí = Read-Host "Ruta destí del backup"

#Agafem el string de la ruta origen i el separem per després agafar el nom de la carpeta que volem copiar
$array_origen=$origen.Split("\")
$nom_fitxer = $array_origen[-1]

#Obtenim la data en la que és fa el backup
$backup_date = Get-Date -Format dd-MM-yyyy

#Avisarem i demanarem al l'usuari per el seu correu 

Write-Host "Et notificarem per correu quan el backup hagui finalitzat." 
$correu = Read-Host "Introdueix la teva adreça de Gmail"

#Copiem el directori a la ruta destí, amb el nom de format Backup_nomfitxer_data, si
#dona error preguntarà si es vol continuar
Copy-Item -Path $origen -Destination ($destí+"\Backup_"+$backup_date+"_"+$nom_fitxer) -ErrorAction Inquire

#Farem una condició per evitar errors, si no hi han procedirà amb l'execució, sino donarà missatge d'error
if ($? -eq "true") {
    
    #Dona el missatge de que s'esta fent el backup

    Write-Host "`nCreant Backup ...`n"
    sleep 2
    
    #Envia un correu des de direcció proporcionada fins a la mateixa, tot i que podriem enviar a altres adreçes, per evitar més errors ho fem així

    Send-MailMessage -SmtpServer smtp.gmail.com -Port 587 -UseSsl -From $correu -To $correu -Subject 'Copia de seguretat finalitzada' -Body "La copia de seguretat s'ha realitzat correctament" -Credential $mycredentials 
    
    #Missatge de que ja ha acabat correctament.
    
    Write-Host "Done!!!" 

}
else {

    #Mostra el missatge d'error

    Write-Host "#Error: Sortint del script, tornar a executar-lo i introdueix la informació correctament."
    sleep 3
}

