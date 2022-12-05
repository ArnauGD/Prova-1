
#El primer que farem serà demanar la informació necessaria

Write-Host "Benvingut!! Quina ISO voldràs muntar?"

#Demana la ruta de la iso

$iso = Read-Host "Ruta de la ISO"

#Munta la iso i ens dona informació que després utilitzarem per amb un get volume obtenir la lletra de la unitat amb la qual s'ha muntat
#Necesitarem la lletra per trobar el fitxer que es vol copiar

$montar = Mount-DiskImage $iso -PassThru 

$lletra= ($montar| Get-Volume |Where-Object {$_.DriveType -like "CD-ROM" -and  $_.DriveLetter -notlike "" } |ForEach-Object DriveLetter) + ":\"


#Comprovarem que existeix a la ruta de la iso muntada mentre demanem el nom del fitxer

while ($true) {

#Ara demanarem el fitxer de la iso que es vol copiar, pero com no sabem la ruta ho haurem de buscar

$fitxer = (Read-Host "Nom del fitxer a copiar") + ".*"

#Amb la comanda get-childitme i la condició del if determinarem si el fitxer existeix o no

$existeix = Get-ChildItem $lletra -File -Filter $fitxer -Recurse -ErrorAction Ignore


if ($existeix -ne $null){

    #En cas de que el output de la comanda no sigui null, sortirem del bucle

    break
}
else {

    #Si el output no es null, direm que hi ha un error i tornarem a demanar el fitxer
    
    Write-Host "#Error: El fitxer no existeix `n"
    
}

}

Write-Host "`nEl" $fitxer "existeix a la ruta/es: `n" 

#Amb aixó printarem totes les rutes completes (nom complet) on existeix el fitxer que busca l'usuari (ja que busquem recursivament)

($existeix | % {Write-Host $_.FullName})

Write-Host "`nQuin és el que vols copiar?`n"

#Demanarem a l'usuari, que de les rutes en que hem trobat el fixer que vol copiar escolleixi una

$rutafitxer = Read-Host "Introdueix la ruta del fitxer"


#Demanarem la ruta desti a la que es vol copiar el fitxer de la iso

$desti = Read-Host "Ruta destí del fitxer a copiar"

#Copiarem el fixter de la iso a la ruta destí

Copy-Item -Path $rutafitxer -Destination $desti

#Posarem un missatge de comiat

Write-Host "Perfecte!! Treball realitzat!! Fins un altre."

