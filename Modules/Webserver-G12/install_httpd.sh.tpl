#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
sudo aws s3 cp s3://${env}-group12-finalproject/images/carlos-sainz-ferrari.jpg /var/www/html 
sudo aws s3 cp s3://${env}-group12-finalproject/images/charles-leclerc-ferrari.jpg /var/www/html 
sudo aws s3 cp s3://${env}-group12-finalproject/images/lando-norris-mclaren.jpg /var/www/html 


echo "<html>
  <head>
<title>TerraformCI-CD</title>
 </head>
 <body>
<center>
    <h1>Created by Group12</h1>
</center>

<table border="5" bordercolor="grey" align="center">
    <tr>
        <th colspan="3">Leo Lu</th> 
    </tr>
    <tr>
        <th>Group12</th>
        <th>Our private IP is $myip</th>
        <th>This is our favorite F1 Drivers.</th>
            
    </tr>
    <tr>
        <td><img src="carlos-sainz-ferrari.jpg" alt="Carlos Sainz" border=3 height=200 width=300></img></th>
        <td><img src="charles-leclerc-ferrari.jpg" alt="Charles Leclerc" border=3 height=200 width=300></img></th>
        <td><img src="lando-norris-mclaren.jpg" alt="Lando Norris" border=3 height=200 width=300></img></th>
    </tr>
</table>
<br></br>
<table border="5" bordercolor="grey" align="center">
    <tr>
        <th colspan="3">Build By</th> 
    </tr>
    <tr>
        <th>Name</th>
        <th>Seneca ID</th>
        <th>Email</th>
    </tr>
    <tr>
        <td>Harjot Bali</td>
        <td>127800233</td>
        <td>hsbali@myseneca.ca</td>
    </tr>
    <tr>
        <td>Meet Brahmbhatt</td>
        <td>136557220</td>
        <td>msbrahmbhatt@myseneca.ca</td>
    </tr>
    <tr>
        <td>Nishit Rathod</td>
        <td>133411223</td>
        <td>nsrathod@myseneca.ca</td>
    </tr>
</table>

  </body>
  <html>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd