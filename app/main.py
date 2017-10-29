#!/usr/bin/env python
# coding=utf-8

import commands
import json
import os
import sys

import x
from x import log, u, C, su

local = False

SUB_VER = "DEV"
VER = "0.1"

CONTACT_LINK = "t.me/teslx"

FUCKING_LANG = "en"

LANG = {
	"en": {
		"title": "English",
		"path": "Choose path to install",
		"downloading": "Downloading",
		"extracting": "Extracting",
		"gstart": "Generating starter",
		"core": "Choose core",
		"installing": "Installing",
		"updating": "Updating",
		"reinstalling": "Reinstalling",
		"ok": "The server was be installed! Try to start the server by command",
		"rei_warning": "WARNING! This action delete all files! Ok? (Yes/No)",
		"action": "Action",
		"install": "Install",
		"update": "Update",
		"reinstall": "Reinstall"
	},
	"ru": {
		"title": "Русский",
		"path": "Укажи путь к установке",
		"downloading": "Загрузка",
		"extracting": "Расспаковка",
		"gstart": "Генерация стартера",
		"core": "Выбери ядро",
		"installing": "Установка",
		"updating": "Обновление",
		"reinstalling": "Переустановка",
		"ok": "Сервер успешно установлен! Ты можешь запустить его коммандой",
		"action": "Действие",
		"install": "Установить",
		"update": "Обновить",
		"reinstall": "Переустановить"
	},
	"uk": {
		"title": "Українська",
		"path": "Вкажи шлях для встановлення",
		"downloading": "Завантаження",
		"extracting": "Розархівування",
		"gstart": "Генерація стартера",
		"core": "Вибери ядро",
		"installing": "Встановлення",
		"updating": "Оновлення",
		"reinstalling": "Перевстановка",
		"ok": "Сервер успішно встановлено! Ти можеш запустити його командою",
		"action": "Дія",
		"install": "Встановити",
		"update": "Оновити",
		"reinstall": "Перевстановити"
	}
}

SERVERS = [
	{
		"name": "PocketMine-MP(dont use)",
		"type": "jenkins",
		"start_cmd": "php PocketMine-MP_1.6.2dev-353_2103c981_API-3.0.0-ALPHA7.phar",
		"download": {
			"link": "https://jenkins.pmmp.io/job/PocketMine-MP/",
			"file": "PocketMine-MP.phar",
			"dirname": "-"
		},
		"bin": {
			"link": "http://jenkins.pmmp.io/job/PHP-7.0-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz",
			"file": "PHP_Linux-x86_64.tar.gz"
		}
	},
	{
		"name": "Nukkit",
		"type": "file",
		"start_cmd": "java -jar nukkit-1.0-SNAPSHOT.jar",
		"download": {
			"link": "http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar",
			"file": "nukkit-1.0-SNAPSHOT.jar",
			"dirname": "-"
		},
		"bin": {
			"link": "-",
			"file": "-"
		}
	},
	{
		"name": "Leveryl",
		"type": "archive",
		"starter_file": "start.sh",
		"start_cmd": "bash start.sh",
		"download": {
			"link": "http://github.com/LeverylTeam/Leveryl/archive/master.tar.gz",
			"file": "master.tar.gz",
			"dirname": "Leveryl-master"
		},
		"bin": {
			"link": "http://jenkins.pmmp.io/job/PHP-7.0-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz",
			"file": "PHP_Linux-x86_64.tar.gz"
		}
	},
	{
		"name": "GenisysPro",
		"type": "archive",
		"starter_file": "start.sh",
		"start_cmd": "bash start.sh",
		"download": {
			"link": "http://github.com/GenisysPro/GenisysPro/archive/master.tar.gz",
			"file": "master.tar.gz",
			"dirname": "GenisysPro-master"
		},
		"bin": {
			"link": "http://jenkins.pmmp.io/job/PHP-7.0-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz",
			"file": "PHP_Linux-x86_64.tar.gz"
		}
	}
]

HEADER = '	      __   ___  __          __  ___                 ___  __  \n' \
         '	|\/| |__) |__  /__` | |\ | /__`  |   /\  |    |    |__  |__) \n' \
         '	|  | |    |___ .__/ | | \| .__/  |  /~~\ |___ |___ |___ |  \ \n' \
         '                                   Oxygon [ PRE-ALPHA 0.2 ]    \n'


def main():
	global SERVERS

	if not os.path.exists('~/.mpesinstaller/'):
		cmd = commands.getoutput('mkdir -p ~/.mpesinstaller/')

	if not os.path.exists('~/.mpesinstaller/lang.json'):
		with open(x.home + '/.mpesinstaller/lang.json', 'w') as f:
			f.write(json.dumps(LANG, sort_keys=True, ensure_ascii=False))
		# cmd = commands.getoutput(
		# 	'echo "' + str(
		# 		json.dumps(LANG, sort_keys=True, ensure_ascii=False)) + '" > ' + x.home + '/.mpesinstaller/lang.json')

	if not os.path.exists('~/.mpesinstaller/servers.json'):
		with open(x.home + '/.mpesinstaller/servers.json', 'w') as f:
			f.write(json.dumps(SERVERS, sort_keys=True, ensure_ascii=False))
		# cmd = commands.getoutput('echo "' + str(json.dumps(SERVERS)) + '" > ' + x.home + '/.mpesinstaller/servers.json')

	x.LANG = u.lang()

	for i, s in enumerate(sys.argv):
		if i > 0:
			if s == '-local' or s == '--loc':
				_local = True

	print(HEADER)

	if u.request(
			'https://raw.githubusercontent.com/TesLex/MPESInstaller/master/version.txt').read().strip() != VER:
		log.warn(
			"Please upgrade the installer by command: " + C.HEADER + "apt-get --only-upgrade install mpesinstaller\n")

	log.info(LANG[FUCKING_LANG]['action'] + ' (1):')
	log.info(C.YELLOW + '1) ' + C.NULL + LANG[FUCKING_LANG]['install'], '   ')
	log.info(C.YELLOW + '2) ' + C.NULL + LANG[FUCKING_LANG]['update'], '   ')
	log.info(C.YELLOW + '3) ' + C.NULL + LANG[FUCKING_LANG]['reinstall'], '   ')
	action = u.input(" : " + C.YELLOW, "1", False)

	log.info(LANG[FUCKING_LANG]['path'] + ' (.):')
	path = u.input(' : ', '.', False)

	if path != '.' and not os.path.exists(path):
		cmd = commands.getoutput('mkdir -p ' + path)

	if local:
		SERVERS = u.servers()
	else:
		SERVERS = json.load(u.request('http://raw.githubusercontent.com/TesLex/MPESInstaller/master/servers.json'))

	log.info(LANG[FUCKING_LANG]['core'] + ' (1):')
	for i, s in enumerate(SERVERS):
		log.warn(s['name'], '   ' + str(i + 1) + ') ')
	input = u.input(' : ', '1', False)

	try:
		if int(action) == 1:
			log.info(LANG[FUCKING_LANG]['installing'] + ' ' + SERVERS[int(input) - 1]['name'])
			su.install(SERVERS[int(input) - 1], path)
		elif int(action) == 2:
			log.error("In develop")
		elif int(action) == 3:
			log.error("In develop")
		else:
			log.error("not found")
	except Exception as e:
		log.error(str(e))
		log.info('Please contact with us: ' + C.GREEN + CONTACT_LINK)

	exit(0)

def parse_argument(arg):
	return arg.split(':')[1]


main()
