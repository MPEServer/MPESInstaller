#!/bin/env python3

# -*- coding: utf-8 -*-
import json
import os
import sys
import tarfile
import zipfile
from subprocess import getoutput
from urllib.request import Request, urlopen


class C:
	HEADER = '\033[0;95m'
	BLUE = '\033[0;94m'
	CYAN = '\033[0;96m'
	YELLOW = '\033[0;80m'
	RED = '\033[0;91m'
	NULL = '\033[0m'
	GREEN = '\033[0;92m'
	WHITE = '\033[0;97m'
	BLACK = '\033[0;90m'
	ITALIC = '\033[3m'
	BOLD = '\033[1m'

VERSION = '3.0.0'

HEADER = '        __   ___  __          __  ___                 ___  __  \n' \
		 '  |\/| |__) |__  /__` | |\ | /__`  |   /\  |    |    |__  |__) \n' \
		 '  |  | |    |___ .__/ | | \| .__/  |  /~~\ |___ |___ |___ |  \ \n' \
		 '                                   by ' + C.ITALIC + C.BOLD + 'TesLex' + C.NULL + ' [ ' + VERSION + ' ]    \n'

CONTACT_LINK = 't.me/teslx'

USER_LANG = "en"

UPGRADE_COMMAND_URL = 'wget -O installer.py "raw.githubusercontent.com/MPEServer/MPESInstaller/master/installer.py" ; python installer.py'
VERSION_URL = 'https://raw.githubusercontent.com/TesLex/MPESInstaller/master/version.txt'
SERVERS_URL = 'http://raw.githubusercontent.com/TesLex/MPESInstaller/master/servers.json'
LANG_URL = 'http://raw.githubusercontent.com/TesLex/MPESInstaller/master/lang.json'


class log:
	@staticmethod
	def errorln(text, separ=' + '):
		print("\n" + C.RED + separ + "ERROR: " + C.NULL + text)

	@staticmethod
	def infoln(text, separ=' + '):
		print("\n" + C.BLUE + separ + C.NULL + text)

	@staticmethod
	def warnln(text, separ=' + '):
		print("\n" + C.YELLOW + separ + C.NULL + text)

	@staticmethod
	def successln(text, separ=' + '):
		print("\n" + C.GREEN + separ + C.NULL + text)

	@staticmethod
	def error(text, separ=' + '):
		print(C.RED + separ + "ERROR: " + C.NULL + text)

	@staticmethod
	def info(text, separ=' + '):
		print(C.BLUE + separ + C.NULL + text)

	@staticmethod
	def warn(text, separ=' + '):
		print(C.YELLOW + separ + C.NULL + text)

	@staticmethod
	def success(text, separ=' + '):
		print(C.GREEN + separ + C.NULL + text)



def download(url, path, text='Downloading.. '):
	req = Request(url, headers={'User-Agent': "Magic Browser"})
	resource = urlopen(req)
	out = open(path, 'wb')

	total_length = float(resource.headers['content-length'])
	dwn_length = 0
	tmp = resource.read(1024)

	while total_length != dwn_length:
		out.write(tmp)
		dwn_length += len(tmp)
		percent = float(dwn_length / total_length * 100) / 100
		percent_round = int(round(percent * 100))

		sys.stdout.write(
      		'\r{}{}%'.format(text, percent_round)
		)

		sys.stdout.flush()
		tmp = resource.read(1024)

	out.write(resource.read())
	out.close()
	print('')


def request(url):
	return urlopen(url)


def copyfile(source, to):
	return getoutput('cp -a ' + source + ' ' + to)


def extract_file(path, to_directory='.'):
	if path.endswith('.zip'):
		zip_ref = zipfile.ZipFile(path, 'r')
		zip_ref.extractall(to_directory)
		zip_ref.close()
	elif path.endswith('.tar.gz') or path.endswith('.tgz'):
		tar = tarfile.open(path)
		tar.extractall(to_directory)
		tar.close()
	elif path.endswith('.tar.bz2') or path.endswith('.tbz'):
		opener, mode = tarfile.open, 'r:bz2'
	else:
		raise ValueError('Could not extract `%s` as no appropriate extractor is found' % path)


def inputin(placeholder, default, tpl=True):
	try:
		if tpl:
			return input(C.YELLOW + ' + ' + C.NULL + placeholder + C.BLUE + ' (' + str(
				default) + ')' + C.NULL + ': ') or default
		else:
			return input(placeholder) or default
	except KeyboardInterrupt:
		log.errorln('Interrupted')
		try:
			sys.exit(0)
		except SystemExit:
			os._exit(0)


def check_lang():
	if not os.path.exists('mpesinstaller_data'):
		cmd = getoutput('mkdir mpesinstaller_data')

	if not os.path.exists('mpesinstaller_data/lang.txt'):
		print(C.YELLOW + ' + ' + C.NULL + 'Language ' + C.NULL + '(1)' + C.NULL + ': ' + C.NULL)
		print(C.YELLOW + '   ' + C.GREEN + '1' + C.NULL + ') ' + C.NULL + 'English' + C.NULL)
		print(C.YELLOW + '   ' + C.GREEN + '2' + C.NULL + ') ' + C.NULL + 'Українська' + C.NULL)
		print(C.YELLOW + '   ' + C.GREEN + '3' + C.NULL + ') ' + C.NULL + 'Русский' + C.NULL)

		lang = inputin(' : ' + C.NULL, 1, False)

		lang = int(lang)

		if lang == 1:
			cmd = getoutput('echo "en" > mpesinstaller_data/lang.txt')
		elif lang == 2:
			cmd = getoutput('echo "uk" > mpesinstaller_data/lang.txt')
		elif lang == 3:
			cmd = getoutput('echo "ru" > mpesinstaller_data/lang.txt')
		else:
			cmd = getoutput('echo "en" > mpesinstaller_data/lang.txt')

	return getoutput('cat mpesinstaller_data/lang.txt')

def i18(key):
	return LANG[USER_LANG][key]


def install(srv, path, is_bin_file=True):
	globals()['path'] = path
	stages = srv['stages']
	lang_props = srv['i18'] if 'i18' in srv else False

	variables = srv['vars']

	if variables:
		for variable, value in variables.items():
			globals()[variable] = value
			# eval(('{}={}'.format(variable, value if value.isdigit() else value if value is 'True' or value is 'False' else "\"" + value + "\"")).strip())

	if lang_props:
		if 'en' in lang_props:
			LANG['en'].update(lang_props['en'])
		if 'uk' in lang_props:
			LANG['uk'].update(lang_props['uk'])
		if 'ru' in lang_props:
			LANG['ru'].update(lang_props['ru'])

	for stage in stages:
		if 'script' in stage:
			name = eval(stage['name'])
			if name:
				log.warn(eval(stage['name']), '   ~ ')

			for s in stage['script']:
				if type(s) is list:
					if s:
						s = '\n'.join(map(str, s))
						exec(s)
				else:
					exec(s)


class Main:
	@staticmethod
	def run():
		print(HEADER)

		if request(VERSION_URL).read().strip().decode('UTF-8') != VERSION:
			log.warn('Please upgrade the installer by command: ' + C.HEADER + UPGRADE_COMMAND_URL + '\n')

		log.info(i18('action') + ' (1):')
		log.info(C.YELLOW + '1) ' + C.NULL + i18('install'), '   ')
		# log.info(C.YELLOW + '2) ' + C.NULL + i18('update'), '   ')
		# log.info(C.YELLOW + '3) ' + C.NULL + i18('reinstall'), '   ')
		action = inputin(" : " + C.YELLOW, "1", False)

		log.info(i18('path') + ' (.):')
		path = inputin(' : ', '.', False)

		if path != '.' and not os.path.exists(path):
			cmd = getoutput('mkdir -p ' + path)

		SERVERS = json.load(request(SERVERS_URL))

		# SERVERS = json.loads(open('servers.json').read())

		log.info('{} ({}):'.format(i18('core'), SERVERS[0]['name']))

		for i, s in enumerate(SERVERS):
			log.warn(s['name'], '   ' + str(i + 1) + ') ')

		SERVER = SERVERS[int(inputin(' : ', '1', False)) - 1]
		SERVER_NAME = SERVER['name']
		SERVER_VERSION = SERVER['version']

		if 'versions' in SERVER:
			log.info('{} ({}):'.format(i18('select_version'), SERVER['version']))

			log.warn(SERVER['version'], '   1) ')

			for i, s in enumerate(SERVER['versions']):
				log.warn(s['name'], '   ' + str(i + 2) + ') ')

			SEL_SERVER = int(inputin(' : ', '1', False))

			if SEL_SERVER > 1:
				SERVER = SERVER['versions'][SEL_SERVER - 2]
				SERVER_VERSION = SERVER['name']


		if int(action) == 1:
			log.info(i18('installing') + ' ' + SERVER_NAME + ' (' + C.BOLD + SERVER_VERSION + C.NULL + ')')
			install(SERVER, path)
		elif int(action) == 2:
			log.error("In develop")
		elif int(action) == 3:
			log.error("In develop")
		else:
			log.error("not found")
		exit(0)


try:
	LANG = json.load(request(LANG_URL))
	# LANG = json.loads(open('lang.json').read())
	USER_LANG = check_lang()
	Main.run()
except Exception as e:
	log.error(str(e))
	log.info('Please contact with us: ' + C.GREEN + CONTACT_LINK)