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
	
	
	BLACK='\033[0;30m'
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	YELLOW='\033[0;33m'
	BLUE='\033[0;34m'
	MAGENTA='\033[0;35m'
	CYAN='\033[0;36m'
	GRAY='\033[0;37m'
	WHITE='\e[1;37m'
	BREAK='\033[m'
	
	function LANG_RU(){
		LANG_FOUND="Найден"
		LANG_NOTFOUND="Не найден"
		LANG_ERROR="Ошибка"
		LANG_INSTALL_BIN="Ставлю бинарник.."
		LANG_DOWNLOAD="Загружаю с репозитория.."
		LANG_UNZIP="Распаковываю.."
		LANG_MAGIC="Творю чудо.."
		LANG_DELETE="Удаляю.."
	}
	
	LANG_RU

	#function LANG_EN(){
	#	LANG_INSTALL_BIN="Installing bin.."
	#}
	
	#function LANG_UA(){
	#	LANG_INSTALL_BIN="Встановлюю бінарник.."
	#}
	
	
	echo -en "${WHITE}"
	echo " _______ _______ _______        _______ _     _"
	echo "    |    |______ |______ |      |______  \___/ "
	echo "    |    |______ ______| |_____ |______ _/   \_"
	echo ""
	echo ""  
	
	DISTRO=$(lsb_release -i | cut -f 2-)
	CHECK_CURL=$(dpkg -s curl | grep Status)
	CURL_C=0
	if [ -n "$CHECK_CURL" ] ; then
		CURL="${GREEN}${LANG_FOUND}"	
		CURL_C=$[$CURL_C+1]		
	else
		CURL="${RED}${LANG_NOTFOUND}"
	fi
	wget repo.teslex.tech/peinstaller/ver.txt 2> /dev/null
	
	CURRENT_VER=$(cat ver.txt)
	VERSION="0.5-BETA"
		if [[ $CURRENT_VER == $VERSION ]] ; then 
			CVT="${GREEN}Новая"
		else
			CVT="${RED}Устаревшая"
		fi
	rm ver.txt
		
	IP=$(echo `hostname --ip-address`)
	HOST=$(echo `hostname -f`)
	DATE=`date +%Y-%m-%d:%H:%M:%S`
	
	echo -en "		${YELLOW}[ ${GRAY}Srcipt version: ${WHITE}${VERSION}${GRAY}(${CVT}${WHITE}${BREAK}) ${YELLOW}]${BREAK}\n"
	echo -en "		${YELLOW}[ ${GRAY}OS: ${WHITE}${DISTRO} ${YELLOW}]${BREAK}\n"
	echo -en "		${YELLOW}[ ${GRAY}IP: ${WHITE}${IP} ${YELLOW}]${BREAK}\n"
	echo -en "		${YELLOW}[ ${GRAY}Host: ${WHITE}${HOST} ${YELLOW}]${BREAK}\n"
	echo -en "		${YELLOW}[ ${GRAY}Date: ${WHITE}${DATE} ${YELLOW}]${BREAK}\n"
	echo -en "		${YELLOW}[ ${GRAY}cURL: ${WHITE}${CURL} ${YELLOW}]${BREAK}\n"
	echo ""
	echo ""  
	
	if [ CURL_C = 0 ] ; then
		echo -en "${BLUE}| ${GRAY}Пытаюсь установить cURL\n"
		apt-get install curl >> /dev/null
		yum install curl 2> /dev/null
	fi
	
	
	function CHECK_CORE(){
		if [[ $CORE = "1" || $CORE = "Genisys" || $CORE = "genisys" ]] ; then
			LINK=https://github.com/iTXTech/Genisys/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Genisys-master
		elif [[ $CORE = "2" || $CORE = "Tesseract" || $CORE = "tesseract" ]] ; then
			LINK=https://github.com/TesseractTeam/Tesseract/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Tesseract-master
		elif [[ $CORE = "3" || $CORE = "Elywing" || $CORE = "elywing" ]] ; then
			LINK=https://github.com/H4PM/Elywing/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=Elywing-master
		elif [[ $CORE = "5" || $CORE = "Pm-mp" || $CORE = "pm-mp" || $CORE = "PM-MP"  || $CORE = "Pmmp" || $CORE = "pmmp" || $CORE = "PMMP" ]] ; then 
			LINK=https://github.com/pmmp/PocketMine-MP/archive/master.tar.gz
			ARCHIVE=master.tar.gz
			CORE_DIR=PocketMine-MP-master
		fi
	}
	
	function INSTALL(){
		CHECK_CORE
		echo -en "${BLUE}| ${GRAY}${LANG_DOWNLOAD}\n"
		wget $LINK 2> /dev/null
		echo -en "${BLUE}| ${GRAY}${LANG_UNZIP}\n" 
		tar -xvf $ARCHIVE >> /dev/null
		echo -en "${BLUE}| ${GRAY}${LANG_MAGIC}\n" 
		cp -a $CORE_DIR/src . 2> /dev/null
		cp -a $CORE_DIR/start.sh . 2> /dev/null
		rm -rf $CORE_DIR 2> /dev/null
		rm -rf $ARCHIVE 2> /dev/null
		GET_BIN
		CHECK_INSTALL
	}
	
	function INSTALL_NUKKIT(){
		echo -en "${RED}| ${GRAY}Для установки Nukkit надо иметь доступ к правам администратора!\nЕсли ты имеешь доступ пиши 'да', иначе - 'нет': "
		read eee
		if [[ $eee = "да" ]] ; then
			echo -en "${BLUE}| ${GRAY}Укажи какой у тебя дистрибутив ${YELLOW}(Debian): "
			read dist
				case "$dist" in
						"1" | "Debian" | "debian" )echo -en "${MAGENTA}| ${GRAY}Делаю что-то плохое...\n"
										echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
										echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
										echo -en "${MAGENTA}| ${GRAY}Шучу...\n"
										echo -en "${MAGENTA}| ${GRAY}-----------------\n"
										apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 >> /dev/null
										echo -en "${MAGENTA}| ${GRAY}-----------------\n"
										echo -en "${MAGENTA}| ${GRAY}Обновляю пакеты...\n"
										apt-get update >> /dev/null 
										T=0
										echo -en "${MAGENTA}| ${GRAY}Щас пойдет установка JAVA, соглашайся на все что возможно!\n"
										while [[ "$T" -lt 10 ]]; do
											echo -en "${YELLOW}-"
											T=$(($T+1))
											sleep 1
										done
										apt-get install oracle-java8-installer
										echo -en "${MAGENTA}| ${GRAY}Загружаю Nukkit(может длится оч. долго)\nЕсли грузит слишком долго, жмякни Ctrl+C и попробуй еще раз!\n"
										wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null
										echo "java -jar nukkit-1.0-SNAPSHOT.jar" > start.sh
										CHECK_INSTALL_NUKKIT;;
					esac
		else
			echo -en "${RED}> ${GRAY}Увы, но наккита тебе не поставить :(\n${BREAK}"
		fi
	}
	
	function UPDATE(){
		CHECK_CORE
		rm -rf $CORE_DIR
		rm -rf $ARCHIVE
		echo -en "${BLUE}| ${GRAY}${LANG_DOWNLOAD}\n"
		wget $LINK 2> /dev/null
		echo -en "${BLUE}| ${GRAY}${LANG_UNZIP}\n" 
		tar -xvf $ARCHIVE >> /dev/null
		echo -en "${BLUE}| ${GRAY}${LANG_MAGIC}\n" 
		rm -rf src
		cp -a $CORE_DIR/src . 2> /dev/null
		rm -rf $CORE_DIR 2> /dev/null
		GET_BIN
		CHECK_INSTALL
	}
	
	function UPDATE_NUKKIT(){
		rm -rf nukkit-1.0-SNAPSHOT.jar
		echo -en "${MAGENTA}| ${GRAY}Загружаю Nukkit(может длится оч. долго)\nЕсли грузит слишком долго, жмякни Ctrl+C и попробуй еще раз!\n"
		wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null	
		CHECK_INSTALL_NUKKIT
	}
	
	function REINSTALL(){
		rm -rf $CORE_DIR
		echo -en "${BLUE}| ${GRAY}Удаляю предыдущий сервер..\n"
		rm -rf src start.sh server.log plugins players banned-players.txt banned-cids.txt banned-ips.txt crashdumps ops.txt pocketmine.yml server.properties tesseract.yml genisys.yml worlds white-list.txt PocketMine* bin nukk*
		INSTALL
	}
	
	function RE_NUKKIT(){
		rm -rf src start.sh server.log plugins players banned-players.txt banned-cids.txt banned-ips.txt crashdumps ops.txt pocketmine.yml server.properties tesseract.yml genisys.yml worlds white-list.txt PocketMine* bin nukk*
		UPDATE_NUKKIT
	}
	
	function GET_BIN(){
		echo -en "${BLUE}| ${GRAY}${LANG_INSTALL_BIN}\n"
		wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
		tar -xvf bin.tar.gz >> /dev/null 
		rm -rf bin.tar.gz 2> /dev/null 
	}
	
	function BACKUP(){
		echo -en "${RED}| ${GRAY}Куда заливать бэкап?:${YELLOW}\n  1)Оставить тут\n  2)На сервера TesLex(позволяет восстановить с любого другого вдс тем же скриптом)\n  3)Яндекс.Диск(не позволяет восстановить с любого другого вдс тем же скриптом)\n${GRAY}: "
		read WHAT
		case "$WHAT" in
			  
			"1" | "оставить тут" | "Оставить тут" | "оставить" | "Оставить" ) MAKE_BACKUP;;
				
			"2" | "На сервера TesLex" | "На сервера teslex" | "на сервера TesLex" | "на сервера teslex" ) TO_TESLEX;;
			  
			"3" | "Яндекс.Диск" | "яндекс.диск" ) TO_DISK;;
	
			*) echo -en "${RED}| ${GRAY}Надо-бы выбрать куда грузить-то!\n${BREAK}";;
	
		esac
	}
	
	function MAKE_BACKUP(){
		mkdir backups
		tar cfJ backups/backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* white* worlds server* 2> /dev/null
	}
	
	function TO_TESLEX(){
		echo -en "${RED}| ${GRAY}Придумай пароль(желательно сложный): "
		read pass
		hashing=$(echo -n "$pass" | md5sum | cut -d" " -f1 | sha256sum | cut -d" " -f1 | sha512sum | cut -d" " -f1) 2> /dev/null
		echo -en "${RED}| ${GRAY}Создаю бэкап..\n"
		if [ ! -e backups ] ; then
			mkdir backups
		fi
		tar cfJ backups/$hashing.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* white* worlds server* 2> /dev/null
		cd backups
		echo -en "${RED}| ${GRAY}Загружаю на сервер..\n"
		curl -XPOST -F "filename=@$hashing.tar.xz" https://repo.teslex.tech/peinstaller/backups/upload.php 2> /dev/null
		echo -en "${GREEN}| ${GRAY} Ссылка на скачивание: ${GREEN}http://repo.teslex.tech/peinstaller/backups/$hashing-$DATE.tar.xz\n${BREAK}"

		wget "http://repo.teslex.tech/peinstaller/mail.php?status=Backup&dist=$DISTRO&host=$HOST&ip=$IP&func=BackupToTesLex&core=none&date=$DATE" 2> /dev/null 
		rm -rf mail.php* 
	}
	
	function TO_DISK(){
		echo -en "${RED}| ${GRAY}Введи логин от диска: "
		read USER
		echo -en "${RED}| ${GRAY}Введи пароль от диска: "
		read PASSWORD
		echo -en "${RED}| ${GRAY}Создаю бэкап..\n"
		tar cfJ backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* white* worlds server* 2> /dev/null
		echo -en "${RED}| ${GRAY}Загружаю на диск..\n"
		curl --user $USER:$PASSWORD -T "{backup.tar.xz}" https://webdav.yandex.ru/

		wget "http://repo.teslex.tech/peinstaller/mail.php?status=Backup&dist=$OS&host=$HOST&ip=$IP&func=BackupToDisk&core=none&date=$DATE" 2> /dev/null 
		rm -rf mail.php?* 

		unlink backup.tar.xz
	}
	
	RESTORE_BACKUP(){
		echo -en "${RED}| ${GRAY} Введи свой пароль: "
		read pass
		hashing=$(echo -n "$pass" | md5sum | cut -d" " -f1 | sha256sum | cut -d" " -f1 | sha512sum | cut -d" " -f1)
		echo -en "${BLUE}| ${GRAY} Качаю бэкап..\n"
		wget http://repo.teslex.tech/peinstaller/backups/$hashing.tar.xz 2> /dev/null
		if [ ! -e backups ] ; then
			mkdir backupsOUT
		fi
		cp -a $hashing.tar.xz backupsOUT
		cd backupsOUT
		echo -en "${BLUE}| ${GRAY} Восстанавливаю..\n"
		tar -xvf $hashing.tar.xz >> /dev/null
		echo -en "${GREEN}| ${GRAY} Готово! Бэкап восстановлен в папку backupsOUT\n${BREAK}"
	}
	
	function CHECK_INSTALL(){
		STARTER=start.sh
		SRC_DIR=src
		BIN_DIR=bin
		C=0
		if [ ! -e $SRC_DIR ] ; then
			echo -en "${RED}| ${GRAY}${LANG_ERROR} ${RED}000x1${GRAY}! ${LANG_NOTFOUND} ${RED}src! \n${BREAK}"
			C=$[$C+1]
		fi
		if [ ! -e $BIN_DIR ] ; then
			echo -en "${RED}| ${GRAY}${LANG_ERROR} ${RED}000x2${GRAY}! ${LANG_NOTFOUND} ${RED}bin! \n${BREAK}"
			C=$[$C+1]
		fi 
		if [ ! -f $STARTER ] ; then
			echo -en "${RED}| ${GRAY}${LANG_ERROR} ${RED}000x3${GRAY}! ${LANG_NOTFOUND} ${RED}start.sh! \n${BREAK}"
			C=$[$C+1]
		fi

		if [[ $C = 0 ]] ; then
			chmod +x ./start.sh 2> /dev/null 
			echo -en "${YELLOW}--------------------\n"
			echo -en "${YELLOW}| ${GRAY}Скрипт разработан TesLex Team\n${BREAK}"
			echo -en "${YELLOW}| ${GRAY}Наш сайт: teslex.tech\n${BREAK}"
			echo -en "${YELLOW}| ${GRAY}Мы в вк: vk.com/teslex.team\n${BREAK}"
			echo -en "${YELLOW}--------------------\n"
			wget "http://repo.teslex.tech/peinstaller/mail.php?status=Success&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${GREEN}| ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"	
		else
			wget "http://repo.teslex.tech/peinstaller/mail.php?status=Failed&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${RED}| ${GRAY}Для получения помощи пиши нам: vk.com/teslex.team\n${BREAK}"
			echo $C
		fi
	}
	
	function CHECK_INSTALL_NUKKIT(){
		STARTER=start.sh
		NUKKIT_FILE=nukkit-1.0-SNAPSHOT.jar
		С=0
		if [ ! -f $STARTER ] ; then
			echo -en "${RED}| ${GRAY}${LANG_ERROR} ${RED}000x3${GRAY}! ${LANG_NOTFOUND} ${RED}start.sh! \n${BREAK}"
			C=$[$C+1]
		fi
		if [ ! -f $NUKKIT_FILE ] ; then
			echo -en "${RED}| ${GRAY}${LANG_ERROR} ${RED}000x4${GRAY}! ${LANG_NOTFOUND} ${RED}nukkit-1.0-SNAPSHOT.jar! \n${BREAK}"
			C=$[$C+1]
		fi
		
		if [[ $C = 0 ]] ; then
			chmod +x ./start.sh 2> /dev/null 
			echo -en "${YELLOW}--------------------\n"
			echo -en "${YELLOW}| ${GRAY}Скрипт разработан TesLex Team\n${BREAK}"
			echo -en "${YELLOW}| ${GRAY}Наш сайт: teslex.tech\n${BREAK}"
			echo -en "${YELLOW}| ${GRAY}Мы в вк: vk.com/teslex.team\n${BREAK}"
			echo -en "${YELLOW}--------------------\n"
			wget "http://repo.teslex.tech/peinstaller/mail.php?status=Success&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${GREEN}| ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"	
		else
			wget "http://repo.teslex.tech/peinstaller/mail.php?status=Failed&dist=$DISTRO&host=$HOST&ip=$IP&func=$ACTION&core=$CORE&date=$DATE" 2> /dev/null 
			rm -rf mail.php?* 
			echo -en "${RED}| ${GRAY}Для получения помощи пиши нам: vk.com/teslex.team\n${BREAK}"
		fi
	}
	
	echo -en "${CYAN}| ${GRAY}Выбери что надо сделать:${YELLOW}\n  1)Установить\n  2)Обновить\n  3)Переустановить\n  4)Бэкап(BETA)\n${GRAY}: "
	read ACTION
	if [[ $ACTION = "1" || $ACTION = "установить" || $ACTION = "Установить" ]] ; then

		echo -en "${CYAN}| ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n  4)Nukkit\n  5)PM-MP\n${GRAY}: "
		read CORE
		case "$CORE" in
			  
			"1" | "Genisys" | "genisys" ) INSTALL;;
			  
			"2" | "Tesseract" | "tesseract" ) INSTALL;;
			  
			"3" | "Elywing" | "elywing" ) INSTALL;;
	
			"4" | "Nukkit" | "nukkit" ) INSTALL_NUKKIT;;
			
			"5" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) INSTALL;;
	
			*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
		esac

	elif [[ $ACTION = "2" || $ACTION = "обновить" || $ACTION = "Обновить" ]] ; then
		echo -en "${CYAN}| ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n  4)Nukkit\n  5)PM-MP\n${GRAY}: "
		read CORE
	
			case "$CORE" in
			  
			"1" | "Genisys" | "genisys" ) UPDATE;;
			  
			"2" | "Tesseract" | "tesseract" ) UPDATE;;
			  
			"3" | "Elywing" | "elywing" ) UPDATE;;
	
			"4" | "Nukkit" | "nukkit" ) UPDATE_NUKKIT;;
			
			"5" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) UPDATE;;
	
			*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
		esac
		
	elif [[ $ACTION = "3" || $ACTION = "переустановить" || $ACTION = "Переустановить" ]] ; then
		echo -en "${RED}| ${GRAY}Переустановка удалит все данные текущего сервера(плагины, игроков и тд.)! Ты согласен на переустановку?:${YELLOW}\n  1)Да\n  2)Нет\n${GRAY}: "
		read WTF
		if [[ $WTF = "1" || $WTF = "да" || $WTF = "Да" ]] ; then
	
			case "$CORE" in
			  
			"1" | "Genisys" | "genisys" ) REINSTALL;;
			  
			"2" | "Tesseract" | "tesseract" ) REINSTALL;;
			  
			"3" | "Elywing" | "elywing" ) REINSTALL;;
	
			"4" | "Nukkit" | "nukkit" ) RE_NUKKIT;;
			
			"5" | "PM-MP" | "Pm-mp" | "pm-mp" | "Pmmp" | "PMMP" | "Pmmp" ) REINSTALL;;
	
			*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
		esac
		
		fi
	elif [[ $ACTION = "4" || $ACTION = "бэкап" || $ACTION = "Бэкап" ]] ; then
		echo -en "${BLUE}| ${GRAY}Что именно:${YELLOW}\n  1)Создать\n  2)Восстановить\n${GRAY}: "
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
