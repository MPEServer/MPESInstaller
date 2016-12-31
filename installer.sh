#!/bin/bash


BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
BREAK='\033[m'


echo " _______ _______ _______        _______ _     _"
echo "    |    |______ |______ |      |______  \___/ "
echo "    |    |______ ______| |_____ |______ _/   \_"
echo ""
echo ""                                               
  
echo -en "${BLUE}| ${GRAY}Запуск...\n"

checkDist(){
	arch=$(uname -m)
	kernel=$(uname -r)
	if [ -f /etc/lsb-release ]; then
			os=$(lsb_release -s -d)
	elif [ -f /etc/debian_version ]; then
			os="Debian_$(cat /etc/debian_version)"
	elif [ -f /etc/redhat-release ]; then
        os=`cat /etc/redhat-release`
	else
		os="$(uname -s) $(uname -r)"
	fi
}

checkOS=$os
checkHOST=$(echo `hostname -f`)
checkIP=$(echo `hostname --ip-address`)
pids=$checkHOST

dateinfo=$(date +%d%h%y) 

echo -en "${BLUE}| ${GRAY}Проверка системы...\n"
checkDist 



getBin(){

	echo -en "${BLUE}| ${GRAY}Ставлю бинарник...\n"
	wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
	tar -xvf bin.tar.gz >> /dev/null 
	rm -rf bin.tar.gz 2> /dev/null 
	
}

check(){

	
    checkSTART=start.sh
	checkSRC=src
	checkBIN=bin 
	C=0
	if [ ! -e $checkSRC ] ; then
		echo -en "${RED}| ${GRAY}Щито пошло не так. Не найдено директории ${RED}src${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -e $corecheckSRC ] ; then
		echo -en "${RED}| ${GRAY}Щито пошло не так. Не найдено директории ${RED}bin${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi 
	if [ ! -f $checkSTART ] ; then
		echo -en "${RED}| ${GRAY}Щито пошло не так. Не найдено файла ${RED}start.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./start.sh 2> /dev/null 
		echo -en "${YELLOW}--------------------\n"
		echo -en "${YELLOW}| ${GRAY}Скрипт разработан TesLex Team\n${BREAK}"
		echo -en "${YELLOW}| ${GRAY}Наш сайт: teslex.tech\n${BREAK}"
		echo -en "${YELLOW}| ${GRAY}Мы в вк: vk.com/teslex.team\n${BREAK}"
		echo -en "${YELLOW}--------------------\n"
		wget "http://repo.teslex.tech/peinstaller/mail.php?status=Success&dist=$checkOS&host=$pids&ip=$checkIP&func=$ev&core=$core&date=$dateinfo" 2> /dev/null 
		rm -rf mail.php?* 
		echo -en "${GREEN}| ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"

	else
		wget "http://repo.teslex.tech/peinstaller/mail.php?status=Failed&dist=$checkOS&host=$pids&ip=$checkIP&func=$ev&core=$core&date=$dateinfo" 2> /dev/null 
		rm -rf mail.php?* 
		echo -en "${RED}| ${GRAY}Ашибачкиии! Напиши нам: vk.com/teslex.team\n${BREAK}"
		echo $C
	fi
	
}

checknukkit(){

    checkSTART=stnukkit.sh
	checkNUKKIT=nukkit-1.0-SNAPSHOT.jar
	C=0
	if [ ! -f $checkNUKKIT ] ; then
		echo -en "${RED}| ${GRAY}Щито пошло не так. Не найдено файла ${RED}nukkit-1.0-SNAPSHOT.jar${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -f $checkSTART ] ; then
		echo -en "${RED}| ${GRAY}Щито пошло не так. Не найдено файла ${RED}stnukkit.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./stnukkit.sh 2> /dev/null
		echo -en "${GREEN}| ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"
		 wget "http://repo.teslex.tech/peinstaller/mail.php?status=Success&dist=$checkOS&host=$checkHOST&ip=$checkIP&func=$ev&core=$core&date=$dateinfo" 2> /dev/null 
	else
		echo -en "${RED}| ${GRAY}Ашибачкиии! Напиши нам: vk.com/teslex.team\n${BREAK}"
		 wget "http://repo.teslex.tech/peinstaller/mail.php?status=Failed&dist=$checkOS&host=$checkHOST&ip=$checkIP&func=$ev&core=$core&date=$dateinfo" 2> /dev/null 
	fi
	
}

checkCore(){

	if [[ $core = "1" || $core = "Genisys" || $core = "genisys" ]] ; then
		link=https://gitlab.com/itxtech/genisys/repository/archive.tar.gz
		achive=archive.tar.gz
		checkSRCict=genisys-master-*
	elif [[ $core = "2" || $core = "Tesseract" || $core = "tesseract" ]] ; then
		link=https://github.com/TesseractTeam/Tesseract/archive/master.tar.gz
		achive=master.tar.gz
		checkSRCict=Tesseract-master
	elif [[ $core = "3" || $core = "Elywing" || $core = "elywing" ]] ; then
		link=https://github.com/H4PM/Elywing/archive/master.tar.gz
		achive=master.tar.gz
		checkSRCict=Elywing-master
	fi
	
}



install(){

	checkCore
	echo -en "${BLUE}| ${GRAY}Скачиваю с репозитория...\n"
	wget $link 2> /dev/null
	echo -en "${BLUE}| ${GRAY}Распаковываю...\n" 
	tar -xvf $achive >> /dev/null
	echo -en "${BLUE}| ${GRAY}Делаю чудеса...\n" 
	cp -a $checkSRCict/src . 2> /dev/null
	cp -a $checkSRCict/start.sh . 2> /dev/null
	rm -rf $checkSRCict 2> /dev/null
	rm -rf $achive 2> /dev/null
	getBin
	check
	
}

update(){

	checkCore
	rm -rf $checkSRCict
	rm -rf $achive
	echo -en "${BLUE}| ${GRAY}Скачиваю с репозитория...\n"
	wget $link 2> /dev/null
	echo -en "${BLUE}| ${GRAY}Распаковываю...\n" 
	tar -xvf $achive >> /dev/null
	echo -en "${BLUE}| ${GRAY}Делаю чудеса...\n" 
	rm -rf src
	cp -a $checkSRCict/src . 2> /dev/null
	rm -rf $checkSRCict 2> /dev/null
	check
	
}

reinstall(){

	checkCore
	rm -rf $checkSRCict
	echo -en "${BLUE}| ${GRAY}Удаляю предыдущий сервер..\n"
		rm -rf src
		rm -rf start.sh
		rm -rf server.log
		rm -rf plugins
		rm -rf players
		rm -rf banned-players.txt
		rm -rf banned-cids.txt
		rm -rf banned-ips.txt
		rm -rf crashdumps
		rm -rf ops.txt
		rm -rf pocketmine.yml
		rm -rf server.properties
		rm -rf tesseract.yml
		rm -rf genisys.yml
		rm -rf worlds
		rm -rf white-list.txt
		rm -rf bin
	echo -en "${BLUE}| ${GRAY}Скачиваю с репозитория...\n"
		wget $link 2> /dev/null
	echo -en "${BLUE}| ${GRAY}Распаковываю...\n" 
		tar -xvf $achive >> /dev/null
	echo -en "${BLUE}| ${GRAY}Делаю чудеса...\n" 
		cp -a $checkSRCict/src . 2> /dev/null
		cp -a $checkSRCict/start.sh . 2> /dev/null
		rm -rf $checkSRCict 2> /dev/null
	getBin
	check
	
}

wtBackup(){
	echo -en "${RED}| ${GRAY}Куда заливать бэкап?:${YELLOW}\n  1)Оставить тут\n  2)На сервера TesLex(позволяет восстановить с любого другого вдс тем же скриптом)\n  3)Яндекс.Диск(не позволяет восстановить с любого другого вдс тем же скриптом)\n${GRAY}: "
	read kuda
	case "$kuda" in
			  
		"1" | "оставить тут" | "Оставить тут" | "оставить" | "Оставить" ) install;;
			  
		"2" | "На сервера TesLex" | "На сервера teslex" | "на сервера TesLex" | "на сервера teslex" ) install;;
			  
		"3" | "Яндекс.Диск" | "яндекс.диск" ) install;;
	
		*) echo -en "${RED}| ${GRAY}Надо-бы выбрать куда грузить-то!\n${BREAK}";;
	
	esac
}
makeBackup(){
	mkdir backups
	tar cfJ backups/backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* white* worlds server* 2> /dev/null
}

loadToTL(){
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
	curl -XPOST -F "filename=@$hashing.tar.xz" http://repo.teslex.tech/peinstaller/backups/upload.php 2> /dev/null
	echo -en "${GREEN}| ${GRAY} Ссылка на скачивание: ${GREEN}http://repo.teslex.tech/peinstaller/backups/$hashing-$dateinfo.tar.xz\n${BREAK}"

wget "http://repo.teslex.tech/peinstaller/mail.php?status=Hz&dist=$checkOS&host=$pids&func=BackupToTesLex&core=none&date=$dateinfo" 2> /dev/null 
		rm -rf mail.php?* 
}

loadToYD(){

	echo -en "${RED}| ${GRAY}Введи логин от диска: "
		read USER
	echo -en "${RED}| ${GRAY}Введи пароль от диска: "
		read PASSWORD
	echo -en "${RED}| ${GRAY}Создаю бэкап..\n"
	tar cfJ backup.tar.xz plugins players bin src pocketm* gen* Pock* Gen* Ely* ely* st* tess* Tess* ban* ops* white* worlds server* 2> /dev/null
	echo -en "${RED}| ${GRAY}Загружаю на диск..\n"
	curl --user $USER:$PASSWORD -T "{backup.tar.xz}" https://webdav.yandex.ru/

wget "http://repo.teslex.tech/peinstaller/mail.php?status=Hz&dist=$checkOS&host=$pids&func=BackupToDisk&core=none&date=$dateinfo" 2> /dev/null 
		rm -rf mail.php?* 

unlink backup.tar.xz


}

wtBackup(){
	echo -en "${RED}| ${GRAY}Куда заливать бэкап?:${YELLOW}\n  1)Оставить тут\n  2)На сервера TesLex(позволяет восстановить с любого другого вдс тем же скриптом)\n  3)Яндекс.Диск(не позволяет восстановить с любого другого вдс тем же скриптом)\n${GRAY}: "
	read kuda
	case "$kuda" in
			  
		"1" | "оставить тут" | "Оставить тут" | "оставить" | "Оставить" )	makeBackup
																			echo -en "${BLUE}| ${GRAY}Ну ок\n${BREAK}";;
			  
		"2" | "На сервера TesLex" | "На сервера teslex" | "на сервера TesLex" | "на сервера teslex" ) loadToTL;;
			  
		"3" | "Яндекс.Диск" | "яндекс.диск" ) loadToYD;;
		
		*) echo -en "${RED}| ${GRAY}Надо-бы выбрать куда грузить-то!\n${BREAK}";;
	
	esac
}

restoreBackup(){
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

installNukkit(){
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
    						  		sudo apt-get install oracle-java8-installer
							  		echo -en "${MAGENTA}| ${GRAY}Загружаю Nukkit(может длится оч. долго)\nЕсли грузит слишком долго, жмякни Ctrl+C и попробуй еще раз!\n"
    						  		wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null
							  		echo "java -jar nukkit-1.0-SNAPSHOT.jar" > stnukkit.sh
							  		checknukkit;;
    			esac
	else
		echo -en "${RED}> ${GRAY}Увы, но наккита тебе не поставить :(\n${BREAK}"
	fi
}

echo -en "${CYAN}| ${GRAY}Выбери что надо сделать:${YELLOW}\n  1)Установить\n  2)Обновить\n  3)Переустановить\n  4)Бэкап(BETA)\n${GRAY}: "
read ev
if [[ $ev = "1" || $ev = "установить" || $ev = "Установить" ]] ; then

	echo -en "${CYAN}| ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n  4)Nukkit\n${GRAY}: "
	read core
	case "$core" in
			  
		"1" | "Genisys" | "genisys" ) install;;
			  
		"2" | "Tesseract" | "tesseract" ) install;;
			  
		"3" | "Elywing" | "elywing" ) install;;
	
		"4" | "Nukkit" | "nukkit" ) installNukkit;;
	
		*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
	esac

elif [[ $ev = "2" || $ev = "обновить" || $ev = "Обновить" ]] ; then
	echo -en "${CYAN}| ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n${GRAY}: "
	read core
	case "$core" in
			  
		"1" | "Genisys" | "genisys" ) update;;
			  
		"2" | "Tesseract" | "tesseract" ) update;;
			  
		"3" | "Elywing" | "elywing" ) update;;
	
		*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
	esac
elif [[ $ev = "3" || $ev = "переустановить" || $ev = "Переустановить" ]] ; then
	echo -en "${RED}| ${GRAY}Переустановка удалит все данные текущего сервера(плагины, игроков и тд.)! Ты согласен на переустановку?:${YELLOW}\n  1)Да\n  2)Нет\n${GRAY}: "
	read checkReinstall
	if [[ $checkReinstall = "1" || $checkReinstall = "да" || $checkReinstall = "Да" ]] ; then
	
		echo -en "${CYAN}| ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n${GRAY}: "
		read core
		case "$core" in
			  
			"1" | "Genisys" | "genisys" ) reinstall;;
			  
			"2" | "Tesseract" | "tesseract" ) reinstall;;
			  
			"3" | "Elywing" | "elywing" ) reinstall;;
	
			*) echo -en "${RED}| ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
		esac
	fi
elif [[ $ev = "4" || $ev = "бэкап" || $ev = "Бэкап" ]] ; then
	echo -en "${BLUE}| ${GRAY}Что именно:${YELLOW}\n  1)Создать\n  2)Восстановить\n${GRAY}: "
	read mr
	if [[ $mr = "1" || $mr = "создать" || $mr = "Создать" ]] ; then	
		wtBackup
	else 	
		restoreBackup
	fi
elif [[ $ev = "5" || $ev = "игра" || $ev = "Игра" ]] ; then
	rullet=$((0 + RANDOM % 2))
	if [[ $rullet = 0 ]] ; then
		echo "Ты умер"
	else 
		echo "Повезло, сцука"
	fi
fi


exit 0
