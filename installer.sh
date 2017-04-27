#!/bin/bash

	###################################
	# 
	#	Скрипт писался левой ногой,
	# 	поэтому если Вам что-то в 
	# 	нём не нравиться - посмотрите
	# 	на свою левую ногу и попробуйте
	# 	написать ею что-либо.
	#
	###################################
	
	
	# Сброс
	Color_Off='\e[0m'       # Text Reset

	# Обычные цвета
	Black='\e[0;30m'        # Black
	Red='\e[0;31m'          # Red
	Green='\e[0;32m'        # Green
	Yellow='\e[0;33m'       # Yellow
	Blue='\e[0;34m'         # Blue
	Purple='\e[0;35m'       # Purple
	Cyan='\e[0;36m'         # Cyan
	White='\e[0;37m'        # White

	# Жирные
	BBlack='\e[1;30m'       # Black
	BRed='\e[1;31m'         # Red
	BGreen='\e[1;32m'       # Green
	BYellow='\e[1;33m'      # Yellow
	BBlue='\e[1;34m'        # Blue
	BPurple='\e[1;35m'      # Purple
	BCyan='\e[1;36m'        # Cyan
	BWhite='\e[1;37m'       # White

	# Подчёркнутые
	UBlack='\e[4;30m'       # Black
	URed='\e[4;31m'         # Red
	UGreen='\e[4;32m'       # Green
	UYellow='\e[4;33m'      # Yellow
	UBlue='\e[4;34m'        # Blue
	UPurple='\e[4;35m'      # Purple
	UCyan='\e[4;36m'        # Cyan
	UWhite='\e[4;37m'       # White

	# Фоновые
	On_Black='\e[40m'       # Black
	On_Red='\e[41m'         # Red
	On_Green='\e[42m'       # Green
	On_Yellow='\e[43m'      # Yellow
	On_Blue='\e[44m'        # Blue
	On_Purple='\e[45m'      # Purple
	On_Cyan='\e[46m'        # Cyan
	On_White='\e[47m'       # White

	# Высоко Интенсивные
	IBlack='\e[0;90m'       # Black
	IRed='\e[0;91m'         # Red
	IGreen='\e[0;92m'       # Green
	IYellow='\e[0;93m'      # Yellow
	IBlue='\e[0;94m'        # Blue
	IPurple='\e[0;95m'      # Purple
	ICyan='\e[0;96m'        # Cyan
	IWhite='\e[0;97m'       # White

	# Жирные Высоко Интенсивные
	BIBlack='\e[1;90m'      # Black
	BIRed='\e[1;91m'        # Red
	BIGreen='\e[1;92m'      # Green
	BIYellow='\e[1;93m'     # Yellow
	BIBlue='\e[1;94m'       # Blue
	BIPurple='\e[1;95m'     # Purple
	BICyan='\e[1;96m'       # Cyan
	BIWhite='\e[1;97m'      # White

	# Высоко Интенсивные фоновые
	On_IBlack='\e[0;100m'   # Black
	On_IRed='\e[0;101m'     # Red
	On_IGreen='\e[0;102m'   # Green
	On_IYellow='\e[0;103m'  # Yellow
	On_IBlue='\e[0;104m'    # Blue
	On_IPurple='\e[0;105m'  # Purple
	On_ICyan='\e[0;106m'    # Cyan
	On_IWhite='\e[0;107m'   # White

	VERSION="0.7-BETA"
	DISTRO=$(lsb_release -i | cut -f 2-)
	IP=$(echo `hostname --ip-address`)
	HOST=$(echo `hostname -f`)
	DATE=`date +%Y-%m-%d:%H:%M:%S`
	
	function LANG_RU(){
		LANG_FOUND="Найден"
		LANG_NOTFOUND="Не найден"
		LANG_ERROR="Ошибка"
		LANG_INSTALL_BIN="Ставлю бинарник.."
		LANG_DOWNLOAD="Загружаю с репозитория.."
		LANG_UNZIP="Распаковываю.."
		LANG_MAGIC="Творю чудо.."
		LANG_DELETE="Удаляю.."
		LANG_INSTALL="Установить"
		LANG_NEW="Новая"
		LANG_OLD="Устаревшая"
		LANG_SELDIST="Укажи свой дистрибутив"
		LANG_UPDATE="Обновить"
		LANG_REINSTALL="Переустановить"
		LANG_CHOSE_CORE="Выбери ядро"
		LANG_ACTION="Действие"
	}

	function LANG_EN(){
		LANG_FOUND="Found"
		LANG_NOTFOUND="Not found"
		LANG_ERROR="Error"
		LANG_INSTALL_BIN="Installing bin.."
		LANG_DOWNLOAD="Downloading.."
		LANG_UNZIP="Unzipping.."
		LANG_MAGIC="Makes magic.."
		LANG_DELETE="Deleting.."
		LANG_INSTALL="Install"
		LANG_NEW="New"
		LANG_OLD="Old"
		LANG_SELDIST="Select your dist"
		LANG_UPDATE="Update"
		LANG_REINSTALL="Reinstall"
		LANG_CHOSE_CORE="Select core"
		LANG_ACTION="Action"
	}
	
	function LANG_UK(){
		LANG_FOUND="Знайдено"
		LANG_NOTFOUND="Не знайдено"
		LANG_ERROR="Помилка"
		LANG_INSTALL_BIN="Встановлюю бынарник.."
		LANG_DOWNLOAD="Завантажую з репозиторія.."
		LANG_UNZIP="Розпаковую.."
		LANG_MAGIC="Чарую.."
		LANG_DELETE="Видаляю.."
		LANG_INSTALL="Встановити"
		LANG_NEW="Нова"
		LANG_OLD="Застаріла"
		LANG_SELDIST="Вибери свій дистрибутив"
		LANG_UPDATE="Оновити"
		LANG_REINSTALL="Перевстановити"
		LANG_CHOSE_CORE="Вибери ядро"
		LANG_ACTION="Дія"
	}

	function CHECK_VERSION(){
		wget srv1.teslex.tech:8080/mcpesrvinstaller/ver.txt 2> /dev/null
		CURRENT_VER=$(cat ver.txt)
		if [[ $CURRENT_VER == $VERSION ]] ; then 
			CVT="${Green}${LANG_NEW}"
		else
			CVT="${Red}${LANG_OLD}"
		fi
		rm ver.txt
	}

	function CHECK_LANG(){
		if [ ! -e "mpesinstaller_data" ] ; then
			mkdir mpesinstaller_data
		fi

		if [[ ! -f "mpesinstaller_data/lang.txt" ]]	; then
			echo -en "${CYAN}| ${IWhite}Select lang:${Yellow}\n  1)English\n  2)Русский\n  3)Українська\n${IWhite}: "
			read LANG
			LANG=$(echo "${LANG}" | tr -s '[:upper:]' '[:lower:]')
			case "${LANG}" in
				  
				"1" | "english" ) echo "EN" > mpesinstaller_data/lang.txt && LANG_EN;;
				  
				"2" | "Русский" | "русский" ) echo "RU" > mpesinstaller_data/lang.txt && LANG_RU;;
				  
				"3" | "Українська" | "українська" ) echo "UK" > mpesinstaller_data/lang.txt && LANG_UK;;
		
				*) echo "EN" > mpesinstaller_data/lang.txt && LANG_EN;;
			esac
		else
			if [[ $(cat mpesinstaller_data/lang.txt) = "EN" ]]; then
				LANG_EN
			elif [[ $(cat mpesinstaller_data/lang.txt) = "RU" ]]; then
				LANG_RU
			elif [[ $(cat mpesinstaller_data/lang.txt) = "UK" ]]; then
				LANG_UK
			fi
		fi
	}
	
	
	echo -en "${White}"
	echo " _______ _______ _______        _______ _     _"
	echo "    |    |______ |______ |      |______  \___/ "
	echo "    |    |______ ______| |_____ |______ _/   \_"
	echo -en "				${White}| ${IBlue}MPESInstaller${White} |${Color_Off}"
	echo "						"  
	echo "						"  

	CHECK_LANG
	CHECK_VERSION
	
	echo -en "		${Yellow}[ ${IWhite}Script version: ${White}${VERSION}${IWhite}(${CVT}${White}${Color_Off}) ${Yellow}]${Color_Off}\n"
	echo -en "		${Yellow}[ ${IWhite}OS: ${White}${DISTRO} ${Yellow}]${Color_Off}\n"
	echo -en "		${Yellow}[ ${IWhite}IP: ${White}${IP} ${Yellow}]${Color_Off}\n"
	echo -en "		${Yellow}[ ${IWhite}Host: ${White}${HOST} ${Yellow}]${Color_Off}\n"
	echo -en "		${Yellow}[ ${IWhite}Date: ${White}${DATE} ${Yellow}]${Color_Off}\n"
	echo ""
	echo ""  

	function CHECK_CORE(){
		if [[ "$1" = "111" ]] ; then
			LINK=https://github.com/iTXTech/Genisys/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Genisys-master
		elif [[ "$1" = "1" ]] ; then
			LINK=https://github.com/TesseractTeam/Tesseract/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Tesseract-master
		elif [[ "$1" = "222" ]] ; then
			LINK=https://github.com/H4PM/Elywing/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Elywing-master
		elif [[ "$1" = "3" ]] ; then 
			LINK=https://github.com/pmmp/PocketMine-MP/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=PocketMine-MP-master
		elif [[ "$1" = "4" ]] ; then 
			LINK=https://github.com/EventaxhlTeam/Eventaxhl/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Eventaxhl-master
		fi
	}
	
	function INSTALL(){
		CHECK_CORE "$1"
		echo -en "${Blue}| ${IWhite}${LANG_DOWNLOAD}\n"
		wget $LINK 2> /dev/null
		echo -en "${Blue}| ${IWhite}${LANG_UNZIP}\n" 
		tar -xvf $ARCHIVE >> /dev/null
		echo -en "${Blue}| ${IWhite}${LANG_MAGIC}\n" 
		cp -a $CORE_DIR/src . 2> /dev/null
		cp -a $CORE_DIR/start.sh . 2> /dev/null
		rm -rf $CORE_DIR 2> /dev/null
		rm -rf $ARCHIVE 2> /dev/null
		GET_BIN
		CHECK_INSTALL
	}
	
	function INSTALL_NUKKIT(){
		echo -en "${Blue}| ${IWhite}${LANG_SELDIST} ${Yellow}(Debian): "
		read dist
		case "$dist" in
				"1" | "Debian" | "debian" )echo -en "${Purple}| ${IWhite}${INSTALL}...\n"
								echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
								echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
								echo -en "${Purple}| ${IWhite}-----------------\n"
								apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 >> /dev/null
								echo -en "${Purple}| ${IWhite}-----------------\n"
								echo -en "${Purple}| ${IWhite}Updates...\n"
								apt-get update >> /dev/null 
								T=0
								echo -en "${Purple}| ${IWhite}Installing java..\n"
								while [[ "$T" -lt 5 ]]; do
									echo -en "${Yellow}-"
									T=$(($T+1))
									sleep 1
								done
								apt-get install oracle-java8-installer
								echo -en "${Purple}| ${IWhite}Downloading nukkit(может длится оч. долго)\nIf downloading very lazy, click Ctrl+C!\n"
								wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null
								echo "java -jar nukkit-1.0-SNAPSHOT.jar" > start.sh
								CHECK_INSTALL_NUKKIT;;
		esac
	}
	
	function UPDATE(){
		CHECK_CORE "$1"
		rm -rf $CORE_DIR
		rm -rf $ARCHIVE
		echo -en "${Blue}| ${IWhite}${LANG_DOWNLOAD}\n"
		wget $LINK 2> /dev/null
		echo -en "${Blue}| ${IWhite}${LANG_UNZIP}\n" 
		tar -xvf $ARCHIVE >> /dev/null
		echo -en "${Blue}| ${IWhite}${LANG_MAGIC}\n" 
		rm -rf src
		cp -a $CORE_DIR/src . 2> /dev/null
		rm -rf $CORE_DIR 2> /dev/null
		GET_BIN
		CHECK_INSTALL
	}
	
	function UPDATE_NUKKIT(){
		rm -rf nukkit-1.0-SNAPSHOT.jar
		echo -en "${Purple}| ${IWhite}Downloading nukkit(может длится оч. долго)\nIf downloading very lazy, click Ctrl+C!\n"
		wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null	
		CHECK_INSTALL_NUKKIT
	}
	
	function REINSTALL(){
		rm -rf $CORE_DIR
		echo -en "${Blue}| ${IWhite}Удаляю предыдущий сервер..\n"
		rm -rf src start.sh server.log plugins players banned-players.txt banned-cids.txt banned-ips.txt crashdumps ops.txt pocketmine.yml server.properties tesseract.yml genisys.yml worlds White-list.txt PocketMine* bin nukk*
		INSTALL "$1"
	}
	
	function RE_NUKKIT(){
		rm -rf src start.sh server.log plugins players banned-players.txt banned-cids.txt banned-ips.txt crashdumps ops.txt pocketmine.yml server.properties tesseract.yml genisys.yml worlds White-list.txt PocketMine* bin nukk*
		UPDATE_NUKKIT
	}
	
	function GET_BIN(){
		echo -en "${Blue}| ${IWhite}${LANG_INSTALL_BIN}\n"
		wget https://dl.bintray.com/pocketmine/PocketMine/PHP_7.0.6_x86-64_Linux.tar.gz 2> /dev/null 
		mv PHP_7.0.6_x86-64_Linux.tar.gz bin.tar.gz
		tar -xvf bin.tar.gz >> /dev/null 
		rm -rf bin.tar.gz 2> /dev/null 
	}
	
	function BACKUP(){
		echo -en "${Red}| ${IWhite}Куда заливать бэкап?:${Yellow}\n  1)Оставить тут\n  2)На сервера TesLex(позволяет восстановить с любого другого вдс тем же скриптом)\n  3)Яндекс.Диск(не позволяет восстановить с любого другого вдс тем же скриптом)\n${IWhite}: "
		read WHAT
		case "$WHAT" in
			  
			"1" | "оставить тут" | "Оставить тут" | "оставить" | "Оставить" ) MAKE_BACKUP;;
				
			"2" | "На сервера TesLex" | "На сервера teslex" | "на сервера TesLex" | "на сервера teslex" ) TO_TESLEX;;
			  
			"3" | "Яндекс.Диск" | "яндекс.диск" ) TO_DISK;;
	
			*) echo -en "${Red}| ${IWhite}Надо-бы выбрать куда грузить-то!\n${Color_Off}";;
	
		esac
	}
	
	function MAKE_BACKUP(){
		mkdir backups
		tar cfJ backups/backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* White* worlds server* 2> /dev/null
	}
	
	function TO_TESLEX(){
		echo -en "${Red}| ${IWhite}Придумай пароль(желательно сложный): "
		read pass
		hashing=$(echo -n "$pass" | md5sum | cut -d" " -f1 | sha256sum | cut -d" " -f1 | sha512sum | cut -d" " -f1) 2> /dev/null
		echo -en "${Red}| ${IWhite}Создаю бэкап..\n"
		if [ ! -e backups ] ; then
			mkdir backups
		fi
		tar cfJ backups/$hashing.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* White* worlds server* 2> /dev/null
		cd backups
		echo -en "${Red}| ${IWhite}Загружаю на сервер..\n"
		curl -XPOST -F "filename=@$hashing.tar.xz" https://srv1.teslex.tech/mcpesrvinstaller/backups/upload.php 2> /dev/null
		echo -en "${Green}| ${IWhite} Ссылка на скачивание: ${Green}http://srv1.teslex.tech/mcpesrvinstaller/backups/$hashing-$DATE.tar.xz\n${Color_Off}"

		wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Backup&dist=$DISTRO&host=$HOST&ip=$IP&func=BackupToTesLex&core=none&date=$DATE" 2> /dev/null 
		rm -rf mail.php* 
	}
	
	function TO_DISK(){
		echo -en "${Red}| ${IWhite}Введи логин от диска: "
		read USER
		echo -en "${Red}| ${IWhite}Введи пароль от диска: "
		read PASSWORD
		echo -en "${Red}| ${IWhite}Создаю бэкап..\n"
		tar cfJ backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* White* worlds server* 2> /dev/null
		echo -en "${Red}| ${IWhite}Загружаю на диск..\n"
		curl --user $USER:$PASSWORD -T "{backup.tar.xz}" https://webdav.yandex.ru/

		wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Backup&dist=$OS&host=$HOST&ip=$IP&func=BackupToDisk&core=none&date=$DATE" 2> /dev/null 
		rm -rf mail.php?* 

		unlink backup.tar.xz
	}
	
	RESTORE_BACKUP(){
		echo -en "${Red}| ${IWhite} Введи свой пароль: "
		read pass
		hashing=$(echo -n "$pass" | md5sum | cut -d" " -f1 | sha256sum | cut -d" " -f1 | sha512sum | cut -d" " -f1)
		echo -en "${Blue}| ${IWhite} Качаю бэкап..\n"
		wget http://srv1.teslex.tech/mcpesrvinstaller/backups/$hashing.tar.xz 2> /dev/null
		if [ ! -e backups ] ; then
			mkdir backupsOUT
		fi
		cp -a $hashing.tar.xz backupsOUT
		cd backupsOUT
		echo -en "${Blue}| ${IWhite} Восстанавливаю..\n"
		tar -xvf $hashing.tar.xz >> /dev/null
		echo -en "${Green}| ${IWhite} Готово! Бэкап восстановлен в папку backupsOUT\n${Color_Off}"
	}
	
	function CHECK_INSTALL(){
		STARTER=start.sh
		SRC_DIR=src
		BIN_DIR=bin
		C=0
		if [ ! -e $SRC_DIR ] ; then
			echo -en "${Red}| ${IWhite}${LANG_ERROR} ${Red}000x1${IWhite}! ${LANG_NOTFOUND} ${Red}src! \n${Color_Off}"
			C=$[$C+1]
		fi
		if [ ! -e $BIN_DIR ] ; then
			echo -en "${Red}| ${IWhite}${LANG_ERROR} ${Red}000x2${IWhite}! ${LANG_NOTFOUND} ${Red}bin! \n${Color_Off}"
			C=$[$C+1]
		fi 
		if [ ! -f $STARTER ] ; then
			echo -en "${Red}| ${IWhite}${LANG_ERROR} ${Red}000x3${IWhite}! ${LANG_NOTFOUND} ${Red}start.sh! \n${Color_Off}"
			C=$[$C+1]
		fi

		if [[ $C = 0 ]] ; then
			chmod +x ./start.sh 2> /dev/null 
			echo -en "${Yellow}--------------------\n"
			echo -en "${Yellow}| ${IWhite}Скрипт разработан TesLex Team\n${Color_Off}"
			echo -en "${Yellow}| ${IWhite}Наш сайт: teslex.tech\n${Color_Off}"
			echo -en "${Yellow}| ${IWhite}Мы в вк: vk.com/teslex.team\n${Color_Off}"
			echo -en "${Yellow}--------------------\n"
			wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Success&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${Green}| ${IWhite}Готово! Пробуй запустить сервер командой ${Green}./st*\n${Color_Off}"	
		else
			wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Failed&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${Red}| ${IWhite}Для получения помощи пиши нам: vk.com/teslex.team\n${Color_Off}"
			echo $C
		fi
	}
	
	function CHECK_INSTALL_NUKKIT(){
		STARTER=start.sh
		NUKKIT_FILE=nukkit-1.0-SNAPSHOT.jar
		С=0
		if [ ! -f $STARTER ] ; then
			echo -en "${Red}| ${IWhite}${LANG_ERROR} ${Red}000x3${IWhite}! ${LANG_NOTFOUND} ${Red}start.sh! \n${Color_Off}"
			C=$[$C+1]
		fi
		if [ ! -f $NUKKIT_FILE ] ; then
			echo -en "${Red}| ${IWhite}${LANG_ERROR} ${Red}000x4${IWhite}! ${LANG_NOTFOUND} ${Red}nukkit-1.0-SNAPSHOT.jar! \n${Color_Off}"
			C=$[$C+1]
		fi
		
		if [[ $C = 0 ]] ; then
			chmod +x ./start.sh 2> /dev/null 
			echo -en "${Yellow}--------------------\n"
			echo -en "${Yellow}| ${IWhite}Скрипт разработан TesLex Team\n${Color_Off}"
			echo -en "${Yellow}| ${IWhite}Наш сайт: teslex.tech\n${Color_Off}"
			echo -en "${Yellow}| ${IWhite}Мы в вк: vk.com/teslex.team\n${Color_Off}"
			echo -en "${Yellow}--------------------\n"
			wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Success&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${Green}| ${IWhite}Готово! Пробуй запустить сервер командой ${Green}./st*\n${Color_Off}"	
		else
			wget "http://srv1.teslex.tech/mcpesrvinstaller/mail.php?status=Failed&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${Red}| ${IWhite}Для получения помощи пиши нам: vk.com/teslex.team\n${Color_Off}"
		fi
	}
	
	echo -en "${CYAN}| ${IWhite}${LANG_ACTION}:${Yellow}\n  1)${LANG_INSTALL}\n  2)${LANG_UPDATE}\n  3)${LANG_REINSTALL}\n: "
	read ACTION
	if [[ $ACTION = "1" || $ACTION = "установить" || $ACTION = "Установить" ]] ; then

		echo -en "${CYAN}| ${IWhite}${LANG_CHOSE_CORE}:${Yellow}\n  1)Tesseract\n  2)Nukkit\n  3)PM-MP\n  4)Eventaxhl\n${IWhite}: "
		read CORE
		case "$CORE" in
			  
			"111" | "Genisys" | "genisys" ) INSTALL "111";;
			  
			"1" | "Tesseract" | "tesseract" ) INSTALL "1";;
			  
			"222" | "Elywing" | "elywing" ) INSTALL "222";;
	
			"2" | "Nukkit" | "nukkit" ) INSTALL_NUKKIT;;
			
			"3" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) INSTALL "3";;

			"4" | "Eventaxhl" | "eventaxhl" ) INSTALL "4";;
	
			*) echo -en "${Red}| ${IWhite}Надо-бы ядро выбрать!\n${Color_Off}";;
	
		esac

	elif [[ $ACTION = "2" || $ACTION = "обновить" || $ACTION = "Обновить" ]] ; then
		echo -en "${CYAN}| ${IWhite}${LANG_CHOSE_CORE}:${Yellow}\n  1)Tesseract\n  2)Nukkit\n  3)PM-MP\n  4)Eventaxhl\n${IWhite}: "
		read CORE
	
			case "$CORE" in
			  
			"111" | "Genisys" | "genisys" ) UPDATE "111";;
			  
			"1" | "Tesseract" | "tesseract" ) UPDATE "1";;
			  
			"222" | "Elywing" | "elywing" ) UPDATE "222";;
	
			"2" | "Nukkit" | "nukkit" ) UPDATE_NUKKIT;;
			
			"3" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) UPDATE "3";;

			"4" | "Eventaxhl" | "eventaxhl" ) UPDATE "4";;
	
			*) echo -en "${Red}| ${IWhite}Надо-бы ядро выбрать!\n${Color_Off}";;
	
		esac
		
	elif [[ $ACTION = "3" || $ACTION = "переустановить" || $ACTION = "Переустановить" ]] ; then
		echo -en "${Red}| ${IWhite}Переустановка удалит все данные текущего сервера(плагины, игроков и тд.)! Ты согласен на переустановку?:${Yellow}\n  1)Yes\n  2)No\n${IWhite}: "
		read WTF
		if [[ $WTF = "1" || $WTF = "yes" || $WTF = "Yes" ]] ; then
			echo -en "${CYAN}| ${IWhite}${LANG_CHOSE_CORE}:${Yellow}\n  1)Tesseract\n  2)Nukkit\n  3)PM-MP\n  4)Eventaxhl\n${IWhite}: "
			read CORE
			case "$CORE" in
				  
				"111" | "Genisys" | "genisys" ) REINSTALL "111";;
				  
				"1" | "Tesseract" | "tesseract" ) REINSTALL "1";;
				  
				"222" | "Elywing" | "elywing" ) REINSTALL "222";;
		
				"2" | "Nukkit" | "nukkit" ) REINSTALL_NUKKIT;;
				
				"3" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) REINSTALL "3";;

				"4" | "Eventaxhl" | "eventaxhl" ) REINSTALL "4";;
		
				*) echo -en "${Red}| ${IWhite}Надо-бы ядро выбрать!\n${Color_Off}";;
		
			esac
		fi
	elif [[ $ACTION = "4" || $ACTION = "бэкап" || $ACTION = "Бэкап" ]] ; then
		echo -en "${Blue}| ${IWhite}Что именно:${Yellow}\n  1)Создать\n  2)Восстановить\n${IWhite}: "
		read mr
		if [[ $mr = "1" || $mr = "создать" || $mr = "Создать" ]] ; then	
			BACKUP
		else 	
			RESTORE_BACKUP
		fi
	elif [[ $ACTION = "5" || $ACTION = "игра" || $ACTION = "Игра" ]] ; then
		RULLET=$((0 + RANDOM % 2))
		if [[ $RULLET = 0 ]] ; then
			echo "Ты умер"
		else 
			echo "Повезло, сцука"
		fi
	fi
	
exit
