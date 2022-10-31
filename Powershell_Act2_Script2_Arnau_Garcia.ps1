
#Demanarem la ruta com a paràmetre

Param(
[string] $ruta
)

#Guardarem la informació del csv a la variable $Usuaris, el csv haurà d'estar delimitat per comes, i amb els següents paràmetres:
#Firstname,Lastname,Description,Password
#Si hi han més paràmetres o menys, no funcionarà

$Usuaris = Import-Csv -Delimiter "," -Path $ruta

#Farem un for each per anar pasant linia per linia mirant els paràmetres de cada usuari     
   
foreach ($User in $Usuaris)            
{            
    $Nom = $User.Firstname
    $Cognom = $User.Lastname
    $Usuari = $User.Firstname + $User.Lastname                                                  
    $Description = $User.Description            
    $Password = $User.Password  
    $OU = $User.OU

    #Amb la següent comanda anem introduint els usuaris per cada pasada del for-each, amb la informació que recopilem del csv
          
    New-ADUser -Name $Usuari -GivenName $Nom -Surname $Cognom -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -Path "$OU" -Enabled $true          
}