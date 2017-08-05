#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys, json, tarfile, zipfile, commands, os, platform, urllib2, unicodedata

VERSION='2.1'

class Color:
	HEADER = '\033[0;95m'
	BLUE = '\033[0;94m'
	CYAN = '\033[0;96m'
	YELLOW = '\033[0;93m'
	RED = '\033[0;91m'
	ENDC = '\033[0m'
	GREEN = '\033[0;92m'
	WHITE = '\033[0;97m'
	BLACK = '\033[0;90m'

class Utils:
	@staticmethod
	def download(url, path, text):
		print(text.encode('utf-8'))
		resource = urllib2.urlopen(url)
		out = open(path, 'wb')
		# totalLength=float(resource.headers['content-length'])
		# dwnLength=0
		# tmp=resource.read(1024)
		# while(tmp!=''):
		# 	out.write(tmp)
		# 	dwnLength+=len(tmp)
		# 	percent = float(dwnLength/totalLength*100) / 100
		# 	hashes = '#' * int(round(percent * 20))
		# 	spaces = ' ' * (20 - len(hashes))
		# 	sys.stdout.write('\r{2}{6}: {2}[{4}{0}{2}] {3}{1}%{5}'.format(hashes + spaces, int(round(percent * 100)), Color.WHITE, Color.YELLOW, Color.GREEN, Color.ENDC, text.encode('utf-8')))
		# 	sys.stdout.flush()
		# 	sys.stdout.flush()
		# 	tmp=resource.read(1024)
		out.write(resource.read())
		out.close()

	@staticmethod
	def request(url):
		return urllib2.urlopen(url)

	@staticmethod
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
			raise ValueError, 'Could not extract `%s` as no appropriate extractor is found' % path

	@staticmethod
	def install(srv, path):
		print(Color.HEADER + ' - ' + Color.ENDC + LANG[FUCKING_LANG]['installing'] + ' ' + Color.WHITE + srv['name'] + Color.ENDC + ':')
	
		srv['download']['link'] = srv['download']['link'].replace('https', 'http')
		if (srv['type'] != 'jenkins'):
			Utils.download(srv['download']['link'], path + '/tmp/' + srv['download']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
			if (srv['type'] == 'archive'):
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
				Utils.extract_file(path + '/tmp/' + srv['download']['file'], path + '/tmp')
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/src ' + path)
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/start.sh ' + path)
			elif (srv['type'] == 'github'):
				#In dev
				print("this function in develop")
			elif (srv['type'] == 'file'):
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['file'] + ' ' + path)
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
				cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

			if (srv['bin']['file'] != '-'):
				print(Color.HEADER + ' - ' + Color.ENDC + 'Installing bin:')
				Utils.download(srv['bin']['link'], path + '/tmp/' + srv['bin']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
				Utils.extract_file(path + '/tmp/' + srv['bin']['file'], path)
		else:
			file_name = json.loads(Utils.request(srv['download']['link'] + '/lastSuccessfulBuild/api/python?pretty=true').read())
			download_url = srv['download']['link'] + '/lastSuccessfulBuild/artifact/' + file_name['artifacts'][0]['fileName']

			Utils.download(download_url, path + '/tmp/' + file_name, Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
			cmd = commands.getoutput('cp -a ' + path + '/tmp/' + file_name + ' ' + path)
			print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
			cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

			

		

		cmd = commands.getoutput('rm -rf ' + path + '/tmp')
		cmd = commands.getoutput('chmod +x ' + path + '/start.sh')

		if (path == '.'):
			starter = './start.sh'
		else:
			starter = 'cd ' + path + ' && ./start.sh'

		print(Color.ENDC + '  ----------------------------------------')
		print(Color.WHITE + '  ' + LANG[FUCKING_LANG]['ok'] + ' ' + Color.GREEN + starter + Color.ENDC)

	@staticmethod
	def update(srv, path):
		print(Color.HEADER + ' - ' + Color.ENDC + LANG[FUCKING_LANG]['updating'] + ' ' + Color.WHITE + srv['name'] + Color.ENDC + ':')
		cmd = commands.getoutput('rm -rf src ' + path + '/PocketMin* ' + path + '/start.sh ' + path + '/nukkit-*.jar')
		
		srv['download']['link'] = srv['download']['link'].replace('https', 'http')
		if (srv['type'] != 'jenkins'):
			Utils.download(srv['download']['link'], path + '/tmp/' + srv['download']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
			if (srv['type'] == 'archive'):
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
				Utils.extract_file(path + '/tmp/' + srv['download']['file'], path + '/tmp')
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/src ' + path)
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/start.sh ' + path)
			elif (srv['type'] == 'github'):
				#In dev
				print("this function in develop")
			elif (srv['type'] == 'file'):
				cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['file'] + ' ' + path)
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
				cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

			if (srv['bin']['file'] != '-'):
				print(Color.HEADER + ' - ' + Color.ENDC + 'Installing bin:')
				Utils.download(srv['bin']['link'], path + '/tmp/' + srv['bin']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
				print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
				Utils.extract_file(path + '/tmp/' + srv['bin']['file'], path)
		else:
			file_name = json.loads(Utils.request(srv['download']['link'] + '/lastSuccessfulBuild/api/python?pretty=true').read())
			download_url = srv['download']['link'] + '/lastSuccessfulBuild/artifact/' + file_name['artifacts'][0]['fileName']

			Utils.download(download_url, path + '/tmp/' + file_name, Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
			cmd = commands.getoutput('cp -a ' + path + '/tmp/' + file_name + ' ' + path)
			print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
			cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

		cmd = commands.getoutput('rm -rf ' + path + '/tmp')
		cmd = commands.getoutput('chmod +x ' + path + '/start.sh')

		if (path == '.'):
			starter = './start.sh'
		else:
			starter = 'cd ' + path + ' && ./start.sh'

		print(Color.ENDC + '  ----------------------------------------')
		print(Color.WHITE + '  ' + LANG[FUCKING_LANG]['ok'] + ' ' + Color.GREEN + starter + Color.ENDC)
		
		@staticmethod
		def reinstall(srv, path):

			print(Color.RED + ' + ' + Color.ENDC + LANG[FUCKING_LANG]['rei_warning'] + ' ' + Color.WHITE + '(1)' + Color.ENDC + ': ' + Color.WHITE)
			input = Utils.input(' : ' + Color.WHITE, 'No', False)

			if input != 'No':
				print(Color.HEADER + ' - ' + Color.ENDC + LANG[FUCKING_LANG]['reinstalling'] + ' ' + Color.WHITE + srv['name'] + Color.ENDC + ':')
				cmd = commands.getoutput('rm -rf src ' + path + '/PocketMin* ' + path + '/start.sh ' + path + '/nukkit-*.jar'+ path + '/pl*'+ path + '/*.jar'+ path + '/*.phar'+ path + '/*ump*'+ path + '/server*'+ path + '/pocket*'+ path + '/nukkit*')
				srv['download']['link'] = srv['download']['link'].replace('https', 'http')
				if (srv['type'] != 'jenkins'):
					Utils.download(srv['download']['link'], path + '/tmp/' + srv['download']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
					if (srv['type'] == 'archive'):
						print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
						Utils.extract_file(path + '/tmp/' + srv['download']['file'], path + '/tmp')
						cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/src ' + path)
						cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['dirname'] + '/start.sh ' + path)
					elif (srv['type'] == 'github'):
						#In dev
						print("this function in develop")
					elif (srv['type'] == 'file'):
						cmd = commands.getoutput('cp -a ' + path + '/tmp/' + srv['download']['file'] + ' ' + path)
						print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
						cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

					if (srv['bin']['file'] != '-'):
						print(Color.HEADER + ' - ' + Color.ENDC + 'Installing bin:')
						Utils.download(srv['bin']['link'], path + '/tmp/' + srv['bin']['file'], Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
						print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['extracting'] + '..')
						Utils.extract_file(path + '/tmp/' + srv['bin']['file'], path)
				else:
					file_name = json.loads(Utils.request(srv['download']['link'] + '/lastSuccessfulBuild/api/python?pretty=true').read())
					download_url = srv['download']['link'] + '/lastSuccessfulBuild/artifact/' + file_name['artifacts'][0]['fileName']

					Utils.download(download_url, path + '/tmp/' + file_name, Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['downloading'] + '..')
					cmd = commands.getoutput('cp -a ' + path + '/tmp/' + file_name + ' ' + path)
					print(Color.YELLOW + '  + ' + Color.ENDC + LANG[FUCKING_LANG]['gstart'] + '..')
					cmd = commands.getoutput('echo "' + srv['start_cmd'] + '" > ' + path + '/start.sh')

				cmd = commands.getoutput('rm -rf ' + path + '/tmp')
				cmd = commands.getoutput('chmod +x ' + path + '/start.sh')

				if (path == '.'):
					starter = './start.sh'
				else:
					starter = 'cd ' + path + ' && ./start.sh'

				print(Color.ENDC + '  ----------------------------------------')
				print(Color.WHITE + '  ' + LANG[FUCKING_LANG]['ok'] + ' ' + Color.GREEN + starter + Color.ENDC)
			else:
				try:
					sys.exit(0)
				except SystemExit:
					os._exit(0)

	@staticmethod
	def input(description, default, tpl):
		try:
			if tpl:
				return raw_input (Color.YELLOW + ' + ' + Color.ENDC + description + Color.WHITE + '(' + str(default) + ')' + Color.ENDC + ': ' + Color.WHITE) or default
			else:
				return raw_input (description) or default
		except KeyboardInterrupt:
			print '\n' + Color.RED + ' + ' + Color.ENDC +'Interrupted'
			try:
				sys.exit(0)
			except SystemExit:
				os._exit(0)
	
	@staticmethod
	def checkLang():
		if not os.path.exists('mpesinstaller_data'):
			cmd = commands.getoutput('mkdir mpesinstaller_data')
			if not os.path.exists('mpesinstaller_data/lang.txt'):
				print(Color.YELLOW + ' + ' + Color.ENDC + 'Select lang ' + Color.WHITE + '(1)' + Color.ENDC + ': ' + Color.WHITE)
				print(Color.YELLOW + '   ' + Color.GREEN + '1' + Color.ENDC + ') ' + Color.WHITE + 'English' + Color.ENDC)
				print(Color.YELLOW + '   ' + Color.GREEN + '2' + Color.ENDC + ') ' + Color.WHITE + 'Українська' + Color.ENDC)
				print(Color.YELLOW + '   ' + Color.GREEN + '3' + Color.ENDC + ') ' + Color.WHITE + 'Русский' + Color.ENDC)
				lang = Utils.input(' : ' + Color.WHITE, 1, False)

				lang = int(lang)

				if lang == 1:
					cmd = commands.getoutput('echo "en" > mpesinstaller_data/lang.txt')
				elif lang == 2:
					cmd = commands.getoutput('echo "uk" > mpesinstaller_data/lang.txt')
				elif lang == 3:
					cmd = commands.getoutput('echo "ru" > mpesinstaller_data/lang.txt')

		return commands.getoutput('cat mpesinstaller_data/lang.txt')
		

class Main:
	@staticmethod
	def run():
		print Color.WHITE
		print '	      __   ___  __          __  ___                 ___  __  '
		print '	|\/| |__) |__  /__` | |\ | /__`  |   /\  |    |    |__  |__) '
		print '	|  | |    |___ .__/ | | \| .__/  |  /~~\ |___ |___ |___ |  \ '
		print '						' + Color.ENDC + 'by' + Color.WHITE + ' T' + Color.ENDC + 'es' + Color.WHITE + 'L' + Color.ENDC + 'ex '
		print ''

		if Utils.request('https://raw.githubusercontent.com/TesLex/MPESInstaller/master/version.txt').read().strip() != VERSION:
			print Color.RED + ' --------------------------------------------------------------------------------------------------------------------                                    '
			print(Color.RED + ' +' + Color.ENDC + ' Please update the script! Command: ' + Color.RED + '                                                                              + ')
			print(Color.RED + ' +' + Color.WHITE + ' wget -O installer.py "teslex.github.io/MPESInstaller/installer.py" && chmod +x ./installer.py && ./installer.py ' + Color.RED + ' + ')
			print Color.RED + ' --------------------------------------------------------------------------------------------------------------------                                    '
			print ''

		print(Color.YELLOW + ' + ' + Color.ENDC + LANG[FUCKING_LANG]['action'] + ' ' + Color.WHITE + '(1)' + Color.ENDC + ': ' + Color.WHITE)
		print(Color.YELLOW + '   ' + Color.GREEN + '1' + Color.ENDC + ') ' + Color.WHITE + LANG[FUCKING_LANG]['install'] + Color.ENDC)
		print(Color.YELLOW + '   ' + Color.GREEN + '2' + Color.ENDC + ') ' + Color.WHITE + LANG[FUCKING_LANG]['update'] + Color.ENDC)
		print(Color.YELLOW + '   ' + Color.GREEN + '3' + Color.ENDC + ') ' + Color.WHITE + LANG[FUCKING_LANG]['reinstall'] + Color.ENDC)
		action = Utils.input(' : ' + Color.WHITE, 1, False)

		print(Color.YELLOW + ' + ' + Color.ENDC + LANG[FUCKING_LANG]['path'] + ' ' + Color.WHITE + '(.)' + Color.ENDC + ': ' + Color.WHITE)
		iPath = Utils.input(' : ' + Color.WHITE, u'.', False)

		if iPath != '.' and not os.path.exists(iPath):
			cmd = commands.getoutput('mkdir -p ' + iPath)

		cmd = commands.getoutput('mkdir ' + iPath + '/tmp')

		servers = json.load(Utils.request('http://raw.githubusercontent.com/TesLex/MPESInstaller/master/servers.json'))
		
		print(Color.YELLOW + ' + ' + Color.ENDC + LANG[FUCKING_LANG]['core'] + ' ' + Color.WHITE + '(1)' + Color.ENDC + ': ' + Color.WHITE)
		i = 0
		for srv in servers:
			i += 1
			print(Color.YELLOW + '   ' + Color.GREEN + str(i) + Color.ENDC + ') ' + Color.WHITE + srv['name'] + Color.ENDC)
		input = Utils.input(' : ' + Color.WHITE, 1, False)

		if int(action) == 1:
			Utils.install(servers[int(input)-1], iPath)
		elif int(action) == 2:
			Utils.update(servers[int(input)-1], iPath)
		elif int(action) == 3:
			Utils.reinstall(servers[int(input)-1], iPath)
		else:
			print 'error'
		


try:	
	LANG = json.load(Utils.request('http://raw.githubusercontent.com/TesLex/MPESInstaller/master/lang.json'))
	FUCKING_LANG = Utils.checkLang()
	Main.run()
except Exception as e:
		print(Color.RED + ' + ' + Color.WHITE + 'ERROR ' + Color.RED + ': ' + str(e))
		print(Color.YELLOW + ' + ' + Color.WHITE + 'Please contact with us: ' + Color.YELLOW + 'https://t.me/joinchat/FlA3Aw6se0Qu7YXx0xfbZQ' + Color.ENDC)
