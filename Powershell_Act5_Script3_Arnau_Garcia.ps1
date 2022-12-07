
#Primer damanarem a l'usuari per el nom SamAccountName de l'usuari en questió de Active Directory

$nom = Read-Host "Nom de l'usuari (SamAccountName)"

#Amb la comanda següent obtindrem el temps en format hores i minuts (hh:mm) de l'ultim login de l'usuari de Active Directory (LastLogon)
 
$data = Get-ADUser -Identity $nom -Properties LastLogon | Select @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | Select-Object -ExpandProperty LastLogon | Get-Date -Format t


#Farem una condició ara per determinar si l'hora del lastlogon coicideix o no amb l'horari de treball, si no ho fa donarem una alerta a l'usuari, i apuntarem el nom d'aquest usuari, 
#a un fitxer txt amb el nom de alerta.txt. En el cas de que si coincideixi només li direm a l'usuari i no realitzarem cap acció.


if ((($data -gt '10:00') -AND ($data -lt '13:00')) -OR (($now -gt '15:00') -AND ($now -lt '18:00'))) {

    #Informarem a l'usuari

    Write-Host "L'Usuari no ha iniciat sessió fora dels horaris de treball. No cal seguiment."


}
else {
    
    #Donarem l'avís a l'usuari

    Write-Host "ATENCIÓ!! L'usuari ha iniciat sessió fora d'horari de treball!!"

    #Amb la comanda següent afegirem el contingut al fitxer alerta.txt, la ruta per a aquest fitxer la posarem fixa.
    #Afegirem la informació amb el format "Usuari: "nom" --> Hora Iniciada: "hora" "

    Add-Content -Path C:\Users\Administrador\Desktop\alerta.txt -Value "Usuari: $nom --> Hora Iniciada: $data"

}