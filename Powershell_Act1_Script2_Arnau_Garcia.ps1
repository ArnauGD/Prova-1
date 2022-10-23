#Agafem els parametres, el directori origen amb la seva ruta absoluta
#i el directori destí on es copiarà

Param(
[string] $origen,
[string] $destí
)

#Agafem el string de la ruta origen i el separem per després agafar el nom de la carpeta que volem copiar

$array_origen=$origen.Split("\")

$nom_fitxer = $array_origen[-1]

#Obtenim la data en la que és fa el backup

$backup_date = Get-Date -Format dd-MM-yyyy

#Copiem el directori a la ruta destí, amb el nom de format Backup_nomfitxer_data, si dona error preguntarà si es vol continuar

Copy-Item -Path $origen -Destination ($destí+"\Backup_"+$nom_fitxer+"_"+$backup_date) -ErrorAction Inquire

Write-Host "`nCreant Backup ...`n"
sleep 2
