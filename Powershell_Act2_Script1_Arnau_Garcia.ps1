

#Començem l'script demanant a l'usuari que introdueixi la informació que es demana i la guardem a les variables.

$Nom = Read-Host "Nom"
$Cognoms = Read-Host "Cognoms"
$Usuari = Read-Host "Nom Usuari"

#Preguntarem a l'usuari si vol introduir una contrasenya o vol deixar a l'usuari sense
#per aixó crearem la variable $i que ens ajudarà a crear el bucle

$i=$false

while ($i -ne $true){

$pass = Read-Host "Vols posar-li una contrasenya? [Y/N] "

if (($pass -eq "Y") -or ($pass -eq "y")){

#La contrasenya haurà d'anar com a SecureString
	
    $Password = Read-Host "Introdueix la contrasenya" 
    New-ADUser -Name $Usuari -GivenName $Nom -Surname $Cognoms -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -Path "OU=Prueba1,DC=midom,DC=sis"-Enabled $true
    $i=$true
}
elseif (($pass -eq "N") -or ($pass -eq "n")){
    
    New-ADUser -Name $Usuari -GivenName $Nom -Surname $Cognoms -PasswordNotRequired $true -Path "OU=Prueba1,DC=midom,DC=sis"-Enabled $true
    $i=$true
}
}

