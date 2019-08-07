@ECHO OFF

:choice1
set /P c=This script will replace your current VIM configuration. Do you want to continue? [y/n] 
if /I "%c%" EQU "Y" goto :create_links
if /I "%c%" EQU "N" goto :end
echo "Please answer yes or no."
goto :choice1

:create_links
mklink \H vimrc %USERHOME%\_vimrc
mklink \D vim %USERHOME%\vimfiles

:choice2
set /P c=Do you want to install plug.vim? [y/n]
if /I "%c%" EQU "Y" goto :install_plug
if /I "%c%" EQU "N" goto :end
echo "Please answer yes or no."
goto :choice2

:install_plug

mkdir vim\autoload
bitsadmin /transfer plugDownload /download /priority normal https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim %cd%\vim\autoload\plug.vim

:end
