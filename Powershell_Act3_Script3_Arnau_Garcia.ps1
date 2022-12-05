
#Primer mostrarem per pantalla un menu per a que l'usuari escolleixi el mode que vol utilitzar

Write-Host "PORTS OBERTS"
Write-Host "Selecciona el tipus de port que vols filtrar" 
Write-Host "1- Ports TCP" 
Write-Host "2- Ports UDP" 
Write-Host "3- Tots els ports"


#Entrarem en un bucle per evitar que l'usuari doni un valor incorrecte 
#En funció del que vulgi veure l'usuari, farem condicions amb el if 

While ($true){

#Llegirem el input de l'usuari
$num = Read-Host "Quina opcio vols utilitzar? "

#Si el valor és 1 farà la commanda de TCP

if ($num -eq 1){

    Write-Host "Ports TCP Oberts"

    #Utilitzarem la comanda Get-NetTCPconnection per obtenir els ports TCP oberts, tant els que estan en listenting com established.
    
    Get-NetTCPConnection -State Established,Listen
    
    break

}

#Si el valor és 2 farà la commanda de UDP

if ($num -eq 2){

    Write-Host "Ports UDP Oberts"

    #Utilitzarem la comanda Get-NetUDPEndpoint per obtenir els ports UDP en estat listening

    Get-NetUDPEndpoint -LocalAddress 0.0.0.0 | Sort-Object LocalPort

    break

}
#Si el valor és 3 farà les dues comandes

if ($num -eq 3){

    #Farem una comanda i deprés l'altre

    Write-Host "Ports TCP Oberts"
    
    Get-NetTCPConnection -State Established,Listen
    
    Write-Host "Ports UDP Oberts"

    Get-NetUDPEndpoint -LocalAddress 0.0.0.0 | Sort-Object LocalPort | ft LocalAddress,Localport

    break

}
#Si el valor no esta en el rang dels demanats, donarà un missatge d'error i tornarà a preguntar

else {

    Write-Host "#Error: No és una opció vàlida"

}

}