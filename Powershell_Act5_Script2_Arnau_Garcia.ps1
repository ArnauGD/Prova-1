#Per realitzar la tasca de mostrar tot els usuaris de Active Directory amb el seu SID, serà molt senzill.
 
#Amb la comanda Get-ADuser obtindrem el usuaris de AD i després posarem una pipe per donar-li format a la sortida
#En aquest script necessitarem que doni el SamAccountName.
 
Get-ADUser -Filter * | Format-Table Name,SID,SamAccountName

#Farem que l'usuari trii el SamAccountName, de l'usuari que vol canviarli la fotografia

Write-Host "A quin usuari li vols canviar la fotografia de perfil?"

$nom = Read-Host "Introdueix un nom d'usuari dels que es troben a la llista (SamAccountName)"

#Demanarem a l'usuari que introdueixi la ruta absoluta de la fotografia.

$foto = Read-Host "Introdueix la ruta de la fotografia"
    
Sleep 2

#Convertirem la informació que necessitem de la imatge

$ADphoto = [byte[]](Get-Content $foto -Encoding byte)

#Amb la comanda Set-ADUser canviarem la foto de perfil de l'usuari especificat

Set-ADUser -Identity $nom -Replace @{thumbnailPhoto=$ADphoto}

#Ens acomiadarem

Write-Host "S'ha realitzar correctament!! Fins un altre!!"
Sleep 2
