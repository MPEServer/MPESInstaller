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

echo -en "${MAGENTA}> ${GRAY}Установщик by expexes\n"
echo -en "${MAGENTA}> ${GRAY}Запуск...\n"


check(){
    FILE=start.sh
	DIR=src
	BDIR=bin
	C=0
	if [ ! -e $DIR ] ; then
		echo -en "${RED}> ${GRAY}Щито пошло не так. Не найдено директории ${RED}src${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -e $BDIR ] ; then
		echo -en "${RED}> ${GRAY}Щито пошло не так. Не найдено директории ${RED}bin${GRAY}! Мб она потерялась когда качалась, а мб и вовсе не качалась..\n${BREAK}"
		C=$[$C+1]
	fi 
	if [ ! -f $FILE ] ; then
		echo -en "${RED}> ${GRAY}Щито пошло не так. Не найдено файла ${RED}start.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./start.sh 2> /dev/null
		echo -en "${GREEN}> ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"
		echo $C
	else
		echo -en "${RED}> ${GRAY}Ашибачкиии! Пиши мне: vk.com/devid.kohut\n${BREAK}"
		echo $C
	fi
}

checknukkit(){
    FILEK=stnukkit.sh
	NUKKIT=nukkit-1.0-SNAPSHOT.jar
	C=0
	if [ ! -f $NUKKIT ] ; then
		echo -en "${RED}> ${GRAY}Щито пошло не так. Не найдено файла ${RED}nukkit-1.0-SNAPSHOT.jar${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [ ! -f $FILEK ] ; then
		echo -en "${RED}> ${GRAY}Щито пошло не так. Не найдено файла ${RED}stnukkit.sh${GRAY}! Мб он потерялся когда качался, а мб и вовсе не качался..\n${BREAK}"
		C=$[$C+1]
	fi
	if [[ $C = 0 ]] ; then
		chmod +x ./stnukkit.sh 2> /dev/null
		echo -en "${GREEN}> ${GRAY}Готово! Пробуй запустить сервер командой ${GREEN}./st*\n${BREAK}"
	else
		echo -en "${RED}> ${GRAY}Ашибачкиии! Пиши мне: vk.com/devid.kohut\n${BREAK}"
	fi
}

echo -en "${CYAN}Выбери ядро${YELLOW} (Genisys/Tesseract/Elywing/Nukkit): "
read b
case "$b" in
  "Genisys" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://gitlab.com/itxtech/genisys/repository/archive.tar.gz 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  tar -xvf archive.tar.gz >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a genisys-master-*/src . 2> /dev/null 
			  cp -a genisys-master-*/start.sh . 2> /dev/null 
			  rm -rf genisys-master-* 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "Tesseract" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/TesseractTeam/Tesseract/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Tesseract-master/src . 2> /dev/null 
			  cp -a Tesseract-master/start.sh . 2> /dev/null 
			  rm -rf Tesseract-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "Elywing" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/H4PM/Elywing/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Elywing-master/src . 2> /dev/null 
			  cp -a Elywing-master/start.sh . 2> /dev/null 
			  rm -rf Elywing-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "Nukkit" ) echo -en "${RED}> ${GRAY}Для установки Nukkit надо иметь доступ к правам администратора!\nЕсли ты имеешь доступ пиши 'да', иначе - 'нет': "
        read eee
		if [[ $eee = "да" ]] ; then
            echo -en "${BLUE}> ${GRAY}Укажи какой у тебя дистрибутив ${YELLOW}(Debian): "
             read dist
    			   case "$dist" in
    			        "1" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
						"Debian" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
		fi;;
			  
  "genisys" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://gitlab.com/itxtech/genisys/repository/archive.tar.gz 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  tar -xvf archive.tar.gz >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a genisys-master-*/src . 2> /dev/null 
			  cp -a genisys-master-*/start.sh . 2> /dev/null 
			  rm -rf genisys-master-* 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "tesseract" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/TesseractTeam/Tesseract/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Tesseract-master/src . 2> /dev/null 
			  cp -a Tesseract-master/start.sh . 2> /dev/null 
			  rm -rf Tesseract-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "elywing" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/H4PM/Elywing/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Elywing-master/src . 2> /dev/null 
			  cp -a Elywing-master/start.sh . 2> /dev/null 
			  rm -rf Elywing-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "nukkit" ) echo -en "${RED}> ${GRAY}Для установки Nukkit надо иметь доступ к правам администратора!\nЕсли ты имеешь доступ пиши 'да', иначе - 'нет': "
        read eee
		if [[ $eee = "да" ]] ; then
            echo -en "${BLUE}> ${GRAY}Укажи какой у тебя дистрибутив ${YELLOW}(Debian): "
             read dist
    			   case "$dist" in
    			        "1" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
						"Debian" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
		fi;;
			  
  "1" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://gitlab.com/itxtech/genisys/repository/archive.tar.gz 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  tar -xvf archive.tar.gz >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a genisys-master-*/src . 2> /dev/null 
			  cp -a genisys-master-*/start.sh . 2> /dev/null 
			  rm -rf genisys-master-* 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "2" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/TesseractTeam/Tesseract/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Tesseract-master/src . 2> /dev/null 
			  cp -a Tesseract-master/start.sh . 2> /dev/null 
			  rm -rf Tesseract-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "3" ) echo -en "${MAGENTA}> ${GRAY}Скачиваю с репозитория...\n"
			  wget https://github.com/H4PM/Elywing/archive/master.zip 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Распаковываю...\n" 
			  unzip master >> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Делаю чудеса...\n" 
			  cp -a Elywing-master/src . 2> /dev/null 
			  cp -a Elywing-master/start.sh . 2> /dev/null 
			  rm -rf Elywing-master 2> /dev/null
			  echo -en "${MAGENTA}> ${GRAY}Ставлю бинарник...\n" 
			  wget http://repo.teslex.tech/peinstaller/bin.tar.gz 2> /dev/null 
			  tar -xvf bin.tar.gz >> /dev/null 
			  rm -rf bin.tar.gz 2> /dev/null
			  check;;
			  
  "4" ) echo -en "${RED}> ${GRAY}Для установки Nukkit надо иметь доступ к правам администратора!\nЕсли ты имеешь доступ пиши 'да', иначе - 'нет': "
        read eee
		if [[ $eee = "да" ]] ; then
            echo -en "${BLUE}> ${GRAY}Укажи какой у тебя дистрибутив ${YELLOW}(Debian): "
             read dist
    			   case "$dist" in
    			        "1" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
						"Debian" ) echo -en "${MAGENTA}> ${GRAY}Делаю что-то плохое...\n"
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
		fi;;
    esac
	

	
	
exit 0

