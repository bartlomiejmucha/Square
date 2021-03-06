# Square
A Sitecore Helix based solution with all my ideas.

# Installation


Square contains **improved** installation scripts, configurations and custom powershell modules, that you can use to install clean Sitecore 9.0 update 2 with Solr 6.6.2 for your local development.

Compared to official scripts, Square do additional things like:
* Installs Solr from zip file,
* Generates certificate for Solr,
* Configures Solr to work over HTTPS,
* Configures Solr to have custom host name like: *https://square.solr*,
* Installs Solr as a windows service using NSSM,
* Generates certificate for XConnect host,
* Configures XConnect host to work over HTTPS,
* Keeps clean installation folder structure with separate subfolders for sitecore, xconnect, solr and certificates,

And if you don't need it or would like to reinstall it, there is *uninstall.ps1* script that removes everything from your PC including certificates, databases, hosts entries from window's hosts file, sites on IIS, solr service, and all installation folders from disk.

It has been tested to work with Sitecore 9.0 update 2, SIF 1.2.1, SF 1.1, Solr 6.6.2 and Windows 10.

After installation you will get root installation folder (like C:\Websites\Square) with subfolders structure like this:
* certificates subfolder, like C:\Websites\Square\certificates
* xconnect subfolder, like C:\Websites\Square\xconnect
* solr subfodler, like C:\Websites\Square\solr
* sitecore subfolder, like C:\Websites\Square\sitecore.


## How to use installation script?

Inside *install* folder with three powershell scripts:
* *parameters.ps1*
* *install.ps1*
* *uninstall.ps1*

The first one *parameters.ps1* is included by other two files. It contains all prameters and variables required for installation and uninstallation.
The *parameters.ps1* file loads *parameters-local.ps1* file from inside. Thanks to this you can override some default parameters in your local enviroment without editing *parameters.ps1* file. For example your *parameters-local.ps1* file can looks like this:
```powershell
##
## LOCAL PARAMETERS ##
##

$prefix = "square"

$installRootPath = "D:\websites\$prefix"
$licenseFilePath = "D:\websites\license.xml"

#database
$dbServer = "."
$dbUser = "username" 
$dbPassword="pass"

#tools
$keytoolPath = "C:\Program Files\Java\jdk1.8.0_144\bin\keytool.exe"
$nssmPath = "C:\Program Files\nssm\win64\nssm.exe"
```

There are also two subfolders: *configuration files* with json files that defines installation steps and *modules* with custom powershell modules for some custom installation tasks.

Inside *configuration files* there are official XP0 Single configuration files with some minimal modifications that were required for me (You can use kdiff and compare with original files to find modifications). There are also three custom configuration files:
* *custom-install-solr.json* - it defines tasks required to install solr locally, create cetificate for solr and configure it to work over HTTPS and with custom host name,
* *custom-xconnect-create-host-cert.json* - it defines tasks required to create certificate for xconnect host,
* *custom-uninstall.json* - it defines tasks required to uninstall everything from PC.

To use these instlalation scripts follow below steps:

  1. Create *zip* subfolder under *install* folder (you can create it in different place but you have to update path inside *parametrs.ps1* file),
  2. Download packages for XP Single, for On Premises deployment from official url: https://dev.sitecore.net/Downloads/Sitecore_Experience_Platform/90/Sitecore_Experience_Platform_90_Update2.aspx
  3. Unzip downloaded file. You will get folder with two WDP packages inside. Copy *Sitecore 9.0.2 rev. 180604 (OnPrem)_single.scwdp.zip* and *Sitecore 9.0.2 rev. 180604 (OnPrem)_xp0xconnect.scwdp.zip* into *zip* folder created in step 1,
  4. Open *paramters.ps1* file and review all parameters. On the top of the file there is #MAIN PARAMETERS" section with most important settings that you have to configure. Override parameters inside *parameters-local.ps1* file or in *parameters.ps1* file directly.
     a. Set the installation path,
     b. Set the path to license file,
     c. Set the db settings,
     d. Set the path to keytool.exe from JDK. You can download it here: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
     e. Set the path to nssm.exe tool. You can download it here: https://nssm.cc/download
  6. Open powershell and execute *install.ps1* script.

## How to use uninstall script?

Open powershell and execute *uninstall.ps1* script. The script loads parameters from *parameters.ps1* and *parameters-local.ps1* files.

## Helix Publishing Pipeline by Richard Szalay https://github.com/richardszalay/helix-publishing-pipeline

Square uses HPP developed by Richard Szalay. It has configured following features:
* Website project, that is representation of your iis application. This is where HPP nuget is installed to.
* Website project autodiscovers Foundation, Feature and Project modules.
* When you build Website project it automatically publish your website. It is much faster than build project and then publishing.
* Delayed transformation of web.config file: The Web.Helix.config file is applayed over Web.config file in your publish folder.
* If you publish outside local environment, for example on VSTS the Web.Helix.config file is included in build package, so you can apply it over Web.config in your enviroments.*
* Sitecore dlls and Website project dlls are excluded from publish.

## [ToDo] How to deploy Square code into your local Sitecore installation

1. Open Square.sln. 
2. Create publishsettings.targets.user file and set publishUrl. Set it as a path instead of hostname. It will speed up publishing a bit.
2. Edit gulp-config.js file.
3. Edit publishsettings.targets file.
4. Execute default gulp task.
