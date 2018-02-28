# Square
A Sitecore Helix based solution with all my ideas.

# Installation


Square contains **improved** installation scripts, configurations and custom powershell modules, that you can use to install clean Sitecore 9.0 update 1 with Solr 6.6.2 for your local development.

Compared to official scripts, Square do additional things like:
* Installs Solr from zip file,
* Generates certificate for Solr,
* Configures Solr to work over HTTPS,
* Configures Solr to have custom host name like: *https://square.solr*,
* Generates certificate for XConnect host,
* Configures XConnect host to work over HTTPS,
* Keeps clean installation folder structure with separate subfolders for sitecore, xconnect, solr and certificates,

And if you don't need it or would like to reinstall it, there is *uninstall.ps1* script that removes everything from your PC including certificates, databases, hosts, sites on IIS and installation folders.

It has been tested to work with Sitecore 9.0 update 1, SIF 1.2, Solr 6.6.2 and Windows 10.

## How to use installation script?

Inside *install* folder with three powershell scripts:
* *parameters.ps1*
* *install.ps1*
* *uninstall.ps1*

The first one *parameters.ps1* is included by other two files. It contains all prameters and variables required for instlalation and uninstallation.
There are also two subfolders: *configuration files* with json files that defines installation steps and *modules* with custom powershell modules.

To use those instlalation scripts follow below steps:

  1. Create *zip* subfolder under *install* folder (you can create it in different place but you have to update path inside *parametrs.ps1* file),
  2. Download packages for XP Single, for On Premises deployment from official url: https://dev.sitecore.net/Downloads/Sitecore_Experience_Platform/90/Sitecore_Experience_Platform_90_Update1.aspx
  3. Unzip downloaded file. You will get folder with two WDP packages inside. Copy *Sitecore 9.0.1 rev. 171219 (OnPrem)_single.scwdp.zip* and *Sitecore 9.0.1 rev. 171219 (OnPrem)_xp0xconnect.scwdp.zip* into *zip* folder created in step 1,
  4. Open *paramters.ps1* file and review all parameters. On the top of the file there is #MAIN PARAMETERS" section with most important settings that you have to configure.
     a. Set the installation path,
     b. Set the path to license file,
     c. Set the db settings,
     d. Set the path to keytool.exe from JDK. You can download it here: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
     e. Set the path to nssm.exe tool. You can download it here: https://nssm.cc/download
  6. Open powershell and execute *install.ps1* script.

## How to use uninstall script?

Open powershell and execute *uninstall.ps1* script. The script loads parameters from *parameters.ps1*.

## [ToDo] How to deploy Square code into your locall Sitecore installation

1. Open Square.sln. 
2. Edit gulp-config.js file.
3. Edit publishsettings.targets file.
4. Execute default gulp task.
