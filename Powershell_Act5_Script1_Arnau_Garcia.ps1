 
 #Per realitzar la tasca de mostrar tot els usuaris de Active Directory amb el seu SID, serà molt senzill.
 
 #Amb la comanda Get-ADuser obtindrem el usuaris de AD i després posarem una pipe per donar-li format a la sortida
 #ja que només volem les dades de Nom i SID de l'usuari.
 
 Get-ADUser -Filter * | Format-Table Name,SID