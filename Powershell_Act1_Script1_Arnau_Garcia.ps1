
#Recollirem la informació que ve com a paràmetre 

Param(
[string] $tipus,
[string] $ruta,
[string] $nom
)


#fem una condició amb el if per comprobar si el usuari vol un trobar un fitxer o un directori

if ($tipus -eq "Directori" )
{

#busquem el directori utilitzan la comanda get-childitem i la posame a la variable $existeix
#la comanda té les opcions: 
#-Directory (només busca directoris), 
#-Filter (per filtrar el contingut buscant una cadena concreta),
#-Recurse (per buscar recursivament)
#-ErrorAction (per dir-li el que ha de fer si es troba amb un error a la comanda)

$existeix = Get-ChildItem $ruta -Directory -Filter $nom -Recurse -ErrorAction Ignore 
}
elseif($tipus -eq "Fitxer" )
{
$existeix = Get-ChildItem $ruta -File -Filter $nom -Recurse -ErrorAction Ignore 
}


#fem un altre condició per comunicar si existeix o no

#si la variable $existeix no és Nula o esta buida llavors donarà una resposta conforme existeix

if (-not ([string]::IsNullOrEmpty($existeix)))
{
Write-Host "`nEl" $tipus $nom "existeix a la ruta/es: `n" 

#Amb aixó printarem totes les rutes completes (nom complet) on existeix el fitxer o directori que busca l'usuari (ja que busquem recursivament)

($existeix |  % {Write-Host $_.FullName})

Write-Host "`nQuin és el que tu busques?`n" 

}
else
{
Write-Host "`nEl" $tipus $nom "no existeix a la ruta" $ruta "`n"
}

