
#compta els usuaris que hi ha i els guarda a la variable

$numUsers = (Get-ADUser -Filter * ).count

#mostra el text amb el contingut de la variable

Write-Host "`nEl nombre total d'usuaris al sistema és de" $numUsers "`n"


#Buscarem els comptes que s'han creat recentment en els últims 2 dies

Write-Host "COMPTES CREATS RECENTMENT (ÚLTIMS 2 DIES)"

$Dies = 2
$Temps = (Get-Date).AddDays(-($Dies))


Get-ADUser -Filter * -Property whenCreated | Where {$_.whenCreated -gt $Temps} | Format-Table Name, WhenCreated


#Mostrar els usuaris que no han canviat la contrasenya

Write-Host "USUARIS QUE NO HAN CANVIAT LA PASSWORD"

Get-ADUser -Filter * -Property PwdLastSet |Where {$_.PwdLastSet -eq 0 } | Format-Table Name


#Mostrar els usuaris deshabilitats

Write-Host "USUARIS INHABILITATS AL SISTEMA"

Get-ADUser -Filter * |Where {$_.enabled -ne "False"} | Format-Table Name, Enabled

#pregunta si es volen esborrar  els usuaris inhabilitats

$decisió = Read-Host "Vols esborrar tots els usuaris inhabilitats? [Y/N]"


 #en cas de que sí, obviant els que no es poden borrar del sistem, elimina tots els usuaris inhabilitats

if (($decisió -eq "Y") -or ($decisió -eq "y")){

    Search-ADAccount -AccountDisabled | where {$_.ObjectClass -eq 'user'} | Remove-ADUser -ErrorAction SilentlyContinue
	
    Write-Host "`n`nS'estàn esborrant els usuaris inhabilitats ..."  
    sleep 2
    Write-Host "`n`nDONE!"

}


