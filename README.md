# Group12_ACS730_Project

Final Project Group 12: Two-Tier Web Application Automation with Terraform

******************************
Objective of the Project:
******************************

This project aims to evaluate our abilities in using source control, deployment automation, and configuration management technologies to build a two-tier static web application hosting and configuration solution.
This Project was given to us by the Professor Leo Lu to tests our knowledgebase of Terraform in addition to our familiarity with load balancers and autoscaling groups in scalable cloud architecture, AWS identity and access management, and effective use of source control and GitHub Actions to automate security scanning.

******************************
Pre-Requiremnets:
******************************
Step 1:

You need to clone the repository to your local Cloud 9 Enviormnet.

Command: git clone git@github.com:nishitrathod412/group12_acs730_project.git

Step:2

After this you need to create 3 keys for your 3 enviornments (Dev>Staging>Prod)

Follow the steps:

1: First go the .ssh folder 

Command: cd ~/.ssh

2: Key generation for 3 seprate enviorments

Command:

ssh-keygen -t rsa -f Group-No-12-dev

ssh-keygen -t rsa -f Group-No-12-staging

ssh-keygen -t rsa -f Group-No-12-prod

Step3:

Go into AWS portal in search bar type "S3" and create 3 buckets there name should be as follows:


prod-group12-finalproject

dev-group12-finalproject

staging-group12-finalproject

In the each s3 bucket you need to create a folder with name of "images" and upload 4 images with name as follows:

carlos-sainz-ferrari.jpg

charles-leclerc-ferrari.jpg

lando-norris-mclaren.jpg

*** We have also attached images for you in the images folder.

Note:

If you are unable to create bucket succesfully if the name is already taken:

you can create 3 buckets with any name you need update  "config.tf" file Infrastrucure section this is the directory hirechay:

group12_acs730_project>>Infrastructure>>Prod>>Network-01

group12_acs730_project>>Infrastructure>>Prod>>WebServer-01

group12_acs730_project>>Infrastructure>>dev>>Network-01

group12_acs730_project>>Infrastructure>>dev>>WebServer-01

group12_acs730_project>>Infrastructure>>stagging>>Network-01

group12_acs730_project>>Infrastructure>>stagging>>WebServer-01


If you do not want to update the images you need to replace the images name in http script with your respective images name in "install_httpd.sh"


***************************************
Infrastructure and Destruction Proccess
***************************************

Before deploying we are going to define the Alias of terraform = tf for this you need to follow the below command:

sudo vi ~/.bashrc
	
	hit insert key or "i"
	
	Then type "alias tf=terraform"
	
	Hit "ESC" key and then type "wq!" and hit enter
		
After doing this we don't have type terraform again and again.

In order to deploy the infrastructure succesfully kindly follow the below  execution flow

Step1 Part A: Deploying the Dev Enviormnet

a) Network Infrastructure
	1)Open terminal ../group12_acs730_project/Infrastructure/dev/Network-01
	
	2) tf init
	
	3) tf fmt
	
	4) tf plan
		
	5) tf apply and then type 'yes' or you can tf apply --auto-approve
		
b) Web-Server Provioning 
		
		1)Open terminal ../group12_acs730_project/Infrastructure/dev/WebServer-01
		
		2) tf init
		
		3) tf fmt
		
		4) tf plan
		
		5) tf apply and then type 'yes' or you can tf apply --auto-approve
		
		


Step1 Part B: Destroying the Dev Enviormnet
a) Web-Server De-Provisioning  

		1)Open terminal ../group12_acs730_project/Infrastructure/dev/WebServer-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		

b) Network Infrastructure

		1)Open terminal ../group12_acs730_project/Infrastructure/dev/Network-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		
		

		
		
		
Step2 Part A: Deploying the Staging Enviormnet

a) Network Infrastructure
		
		1)Open terminal ../group12_acs730_project/Infrastructure/Staging/Network-01
		
		2) tf init
		
		3) tf fmt
		
		4) tf plan
		
		5) tf apply and then type 'yes' or you can tf apply --auto-approve
		
b) Web-Server Provioning 
		
		1)Open terminal ../group12_acs730_project/Infrastructure/Staging/WebServer-01
		
		2) tf init
		
		3) tf fmt
		
		4) tf plan
		
		5) tf apply and then type 'yes' or you can tf apply --auto-approve


Step2 PART B: Destroying the staging Enviormnet

a) Web-Server De-Provisioning  

		1)Open terminal ../group12_acs730_project/Infrastructure/staging/WebServer-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		


b) Network Infrastructure

		1)Open terminal ../group12_acs730_project/Infrastructure/staging/Network-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		


		
		
Step3 PART A: Deploying the prod Enviormnet

a) Network Infrastructure

		1)Open terminal ../group12_acs730_project/Infrastructure/prod/Network-01
		
		2) tf init
		
		3) tf fmt
		
		4) tf plan
		
		5) tf apply and then type 'yes' or you can tf apply --auto-approve
		
b) Web-Server Provioning 

		1)Open terminal ../group12_acs730_project/Infrastructure/prod/WebServer-01
		
		2) tf init
		
		3) tf fmt
		
		4) tf plan
		
		5) tf apply and then type 'yes' or you can tf apply --auto-approve
		
Step3 Part B: Destroying the prod Enviormnet

		
a) Web-Server De-Provisioning 

		1)Open terminal ../group12_acs730_project/Infrastructure/prod/WebServer-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		
	
	
b) Network Infrastructure

		1)Open terminal ../group12_acs730_project/Infrastructure/prod/Network-01
		
		2) tf destroy and then type 'yes' or you can tf destroy --auto-approve
		
	
		
We are re-deploying each enviorment sepratly becuase of the limitatoion on Student account.

		
Kindly contact us we would loved to answer your querries.

1. Harjot Bali - Seneca ID -127800233 -hsbali@myseneca.ca
2. Meet Brahmbhatt - Seneca ID - 136557220 - msbrahmbhatt@myseneca.ca
3. Nishit Rathod - Seneca ID - 133411223 - nsrathod@myseneca.ca
 