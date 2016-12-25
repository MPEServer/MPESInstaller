#!/bin/bash


BLACK='\033[0;30m'     #  ${BLACK}    # чёрный цвет знаков
RED='\033[0;31m'       #  ${RED}      # красный цвет знаков
GREEN='\033[0;32m'     #  ${GREEN}    # зелёный цвет знаков
YELLOW='\033[0;33m'     #  ${YELLOW}    # желтый цвет знаков
BLUE='\033[0;34m'       #  ${BLUE}      # синий цвет знаков
MAGENTA='\033[0;35m'     #  ${MAGENTA}> ${GRAY}    # фиолетовый цвет знаков
CYAN='\033[0;36m'       #  ${CYAN}      # цвет морской волны знаков
GRAY='\033[0;37m'       #  ${GRAY}      # серый цвет знаков
BREAK='\033[m'       #  ${BREAK}    # все атрибуты по умолчанию

echo -en "${BLUE}• ${GRAY}Запуск...\n"

check(){

    FILE=start.sh
	DIR=src
	BDIR=bin
	C=0
	if [ ! -e $DIR ] ; then
		echo -en "${RED}• ${GRAY}Щито пошло не так. Не найдено директории ${RED}src${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -e $coreDIR ] ; then
		echo -en "${RED}• ${GRAY}Щито пошло не так. Не найдено директории ${RED}bin${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi 
	if [ ! -f $FILE ] ; then
		echo -en "${RED}• ${GRAY}Щито пошло не так. Не найдено файла ${RED}start.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./start.sh 2> /dev/null
		echo -en "${YELLOW}--------------------\n"
		echo -en "${YELLOW}• ${GRAY}Скрипт разработан TesLex Team\n${BREAK}"
		echo -en "${YELLOW}• ${GRAY}Наш сайт: teslex.tech\n${BREAK}"
		echo -en "${YELLOW}• ${GRAY}Мы в вк: vk.com/teslex.team\n${BREAK}"
		echo -en "${YELLOW}--------------------\n"
		echo -en "${GREEN}• ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"
	else
		echo -en "${RED}• ${GRAY}Ашибачкиии! Напиши нам: vk.com/teslex.team\n${BREAK}"
		echo $C
	fi
	
}

checknukkit(){

    FILEK=stnukkit.sh
	NUKKIT=nukkit-1.0-SNAPSHOT.jar
	C=0
	if [ ! -f $NUKKIT ] ; then
		echo -en "${RED}• ${GRAY}Щито пошло не так. Не найдено файла ${RED}nukkit-1.0-SNAPSHOT.jar${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -f $FILEK ] ; then
		echo -en "${RED}• ${GRAY}Щито пошло не так. Не найдено файла ${RED}stnukkit.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./stnukkit.sh 2> /dev/null
		echo -en "${GREEN}• ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"
	else
		echo -en "${RED}• ${GRAY}Ашибачкиии! Напиши нам: vk.com/teslex.team\n${BREAK}"
	fi
	
}

checkCore(){

	if [[ $core = "1" || $core = "Genisys" || $core = "genisys" ]] ; then
		link=https://gitlab.com/itxtech/genisys/repository/archive.tar.gz
		achive=archive.tar.gz
		dirict=genisys-master-*
	elif [[ $core = "2" || $core = "Tesseract" || $core = "tesseract" ]] ; then
		link=https://github.com/TesseractTeam/Tesseract/archive/master.tar.gz
		achive=master.tar.gz
		dirict=Tesseract-master
	elif [[ $core = "2" || $core = "Tesseract" || $core = "tesseract" ]] ; then
		link=https://github.com/H4PM/Elywing/archive/master.tar.gz
		achive=master.tar.gz
		dirict=Elywing-master
	fi
	
}

getBin(){

	echo -en "${BLUE}• ${GRAY}Ставлю бинарник...\n"
	wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
	tar -xvf bin.tar.gz >> /dev/null 
	rm -rf bin.tar.gz 2> /dev/null
	
}

install(){

	checkCore
	echo -en "${BLUE}• ${GRAY}Скачиваю с репозитория...\n"
	wget $link 2> /dev/null
	echo -en "${BLUE}• ${GRAY}Распаковываю...\n" 
	tar -xvf $achive >> /dev/null
	echo -en "${BLUE}• ${GRAY}Делаю чудеса...\n" 
	cp -a $dirict/src . 2> /dev/null
	cp -a $dirict/start.sh . 2> /dev/null
	rm -rf $dirict 2> /dev/null
	getBin
	check
	
}

update(){

	checkCore
	rm -rf $dirict
	rm -rf $achive
	echo -en "${BLUE}• ${GRAY}Скачиваю с репозитория...\n"
	wget $link 2> /dev/null
	echo -en "${BLUE}• ${GRAY}Распаковываю...\n" 
	tar -xvf $achive >> /dev/null
	echo -en "${BLUE}• ${GRAY}Делаю чудеса...\n" 
	rm -rf src
	rm -rf start.sh
	cp -a $dirict/src . 2> /dev/null
	cp -a $dirict/start.sh . 2> /dev/null
	rm -rf $dirict 2> /dev/null
	check
	
}

reinstall(){

	checkCore
	rm -rf $dirict
	echo -en "${BLUE}• ${GRAY}Удаляю предыдущий сервер..\n"
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
	echo -en "${BLUE}• ${GRAY}Скачиваю с репозитория...\n"
		wget $link 2> /dev/null
	echo -en "${BLUE}• ${GRAY}Распаковываю...\n" 
		tar -xvf $achive >> /dev/null
	echo -en "${BLUE}• ${GRAY}Делаю чудеса...\n" 
		cp -a $dirict/src . 2> /dev/null
		cp -a $dirict/start.sh . 2> /dev/null
		rm -rf $dirict 2> /dev/null
	getBin
	check
	
}
installNukkit(){
	echo -en "${RED}> ${GRAY}Для установки Nukkit надо иметь доступ к правам администратора!\nЕсли ты имеешь доступ пиши 'да', иначе - 'нет': "
    read eee
	if [[ $eee = "да" ]] ; then
        echo -en "${BLUE}> ${GRAY}Укажи какой у тебя дистрибутив ${YELLOW}(Debian): "
         read dist
			   case "$dist" in
			        "1" | "Debian" | "debian" )echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
			  				        echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
					     		    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list >> /dev/null
    						  		echo -en "${MAGENTA}> ${GRAY}Шучу...\n"
    							    echo -en "${MAGENTA}> ${GRAY}-----------------\n"
    						  		apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 >> /dev/null
    						  		echo -en "${MAGENTA}> ${GRAY}-----------------\n"
    						  		echo -en "${MAGENTA}> ${GRAY}Обновляю пакеты...\n"
    						  		apt-get update >> /dev/null 
    						  		T=0
    						  		echo -en "${MAGENTA}> ${GRAY}Щас пойдет установка JAVA, соглашайся на все что возможно!\n"
    						  		while [[ "$T" -lt 10 ]]; do
    									echo -en "${YELLOW}-"
    									T=$(($T+1))
    									sleep 1
    					      		done
    						  		sudo apt-get install oracle-java8-installer
							  		echo -en "${MAGENTA}> ${GRAY}Загружаю Nukkit(может длится оч. долго)\nЕсли грузит слишком долго, жмякни Ctrl+C и попробуй еще раз!\n"
    						  		wget http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar 2> /dev/null.jar >> /dev/null
							  		echo "java -jar nukkit-1.0-SNAPSHOT.jar" > stnukkit.sh
							  		checknukkit;;
    			esac
	else
		echo -en "${RED}> ${GRAY}Увы, но наккита тебе не поставить :(\n${BREAK}"
	fi
}

echo -en "${CYAN}• ${GRAY}Выбери что надо сделать:${YELLOW}\n  1)Установить\n  2)Обновить\n  3)Переустановить\n${GRAY}: "
read ev
if [[ $ev = "1" || $ev = "установить" || $ev = "Установить" ]] ; then

	echo -en "${CYAN}• ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n  4)Nukkit\n${GRAY}: "
	read core
	case "$core" in
			  
		"1" | "Genisys" | "genisys" ) install;;
			  
		"2" | "Tesseract" | "tesseract" ) install;;
			  
		"3" | "Elywing" | "elywing" ) install;;
	
		"4" | "Nukkit" | "nukkit" ) installNukkit;;
	
		*) echo -en "${RED}• ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
	esac

elif [[ $ev = "2" || $ev = "обновить" || $ev = "Обновить" ]] ; then
	echo -en "${CYAN}• ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n${GRAY}: "
	read core
	case "$core" in
			  
		"1" | "Genisys" | "genisys" ) update;;
			  
		"2" | "Tesseract" | "tesseract" ) update;;
			  
		"3" | "Elywing" | "elywing" ) update;;
	
		*) echo -en "${RED}• ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
	esac
elif [[ $ev = "3" || $ev = "переустановить" || $ev = "Переустановить" ]] ; then
	echo -en "${RED}• ${GRAY}Переустановка удалит все данные текущего сервера(плагины, игроков и тд.)! Ты согласен на переустановку?:${YELLOW}\n  1)Да\n  2)Нет\n${GRAY}: "
	read checkReinstall
	if [[ $checkReinstall = "1" || $checkReinstall = "да" || $checkReinstall = "Да" ]] ; then
	
		echo -en "${CYAN}• ${GRAY}Выбери ядро:${YELLOW}\n  1)Genisys\n  2)Tesseract\n  3)Elywing\n${GRAY}: "
		read core
		case "$core" in
			  
			"1" | "Genisys" | "genisys" ) reinstall;;
			  
			"2" | "Tesseract" | "tesseract" ) reinstall;;
			  
			"3" | "Elywing" | "elywing" ) reinstall;;
	
			*) echo -en "${RED}• ${GRAY}Надо-бы ядро выбрать!\n${BREAK}";;
	
		esac
	else 
		echo -en "${CYAN}• ${GRAY}Ну как хоч.\n${BREAK}"
	fi
fi

exit 0

