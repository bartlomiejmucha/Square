# Square
A Sitecore Helix based solution with all my ideas.

# How to install clean Sitecore

1. Open /install/install.ps1 file and set all parameters,
2. Open /install/configuration files/install-solr.json file and on the bottom set correct paths to modules,
3. Open C:\Windows\System32\drivers\etc\hosts file and add host for your solr instance, (currently it's not done autoamtically yet),
4. Download solr zip and sitecore WDP packages and put them into /install/zips folder,
5. Insert license file into /install folder.
5. Execute install.ps1 from PowerShell.

# How to install Square

1. Open Square.sln. 
2. Edit gulp-config.js file.
3. Edit publishsettings.targets file.
4. Execute default gulp task.
