import commands
import json
import os
import sys
import tarfile
import urllib2
import zipfile

from os.path import expanduser

LANG = []

FUCKING_LANG = "en"

home = expanduser("~")


class log:
	def __init__(self):
		pass

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


class u:
	def __init__(self):
		pass

	@staticmethod
	def lang():
		with open(home + "/.mpesinstaller/lang.json") as json_file:
			return json.load(json_file)

	@staticmethod
	def servers():
		with open(home + "/.mpesinstaller/servers.json") as json_file:
			return json.load(json_file)

	@staticmethod
	def download(url, path):
		resource = urllib2.urlopen(url)
		out = open(path, 'wb')
		out.write(resource.read())
		out.close()

	@staticmethod
	def request(url):
		return urllib2.urlopen(url)

	@staticmethod
	def input(placeholder, default, tpl=True):
		try:
			if tpl:
				return raw_input(C.YELLOW + ' + ' + C.NULL + placeholder + C.BLUE + ' (' + str(
					default) + ')' + C.NULL + ': ') or default
			else:
				return raw_input(placeholder) or default
		except KeyboardInterrupt:
			log.errorln('Interrupted')
			try:
				sys.exit(0)
			except SystemExit:
				os._exit(0)

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
			pass
		else:
			raise ValueError, 'Could not extract `%s` as no appropriate extractor is found' % path


class su:
	def __init__(self):
		pass

	@staticmethod
	def install(srv, path, is_bin_file=True):
		download_link = srv['download']['link']
		type = srv['type']
		download_file = srv['download']['file']
		download_dirname = srv['download']['dirname']
		bin_file = srv['bin']['file']
		start_cmd = srv['start_cmd']

		# srv['download']['link'] = srv['download']['link'].replace('https', 'http')
		if type != 'jenkins':
			log.warn(LANG[FUCKING_LANG]['downloading'] + '..', '   - ')
			u.download(download_link, '/tmp/' + download_file)
			if type == 'archive':
				log.warn(LANG[FUCKING_LANG]['extracting'] + '..', '   - ')
				u.extract_file('/tmp/' + download_file, '/tmp/')
				cmd = commands.getoutput('cp -a ' + '/tmp/' + download_dirname + '/src ' + path)
				cmd = commands.getoutput('cp -a ' + '/tmp/' + download_dirname + '/start.sh ' + path)
			elif type == 'github':
				# In dev
				log.error("this function in develop")
			elif type == 'file':
				cmd = commands.getoutput('cp -a ' + '/tmp/' + download_file + ' ' + path)
				log.warn(LANG[FUCKING_LANG]['gstart'] + '..', '   - ')
				cmd = commands.getoutput('echo "' + start_cmd + '" > ' + path + '/start.sh')

			if is_bin_file is True:
				if (bin_file != '-'):
					log.info('Installing bin:' + '..')
					log.warn(LANG[FUCKING_LANG]['downloading'] + '..', '   - ')
					u.download(srv['bin']['link'], '/tmp/' + bin_file)
					log.warn(LANG[FUCKING_LANG]['extracting'] + '..', '   - ')
					u.extract_file('/tmp/' + bin_file, path)
		else:
			file_name = json.loads(
				u.request(download_link + '/lastSuccessfulBuild/api/python?pretty=true').read())
			download_url = download_link + '/lastSuccessfulBuild/artifact/' + file_name['artifacts'][0][
				'fileName']

			u.download(download_url, '/tmp/' + file_name)
			cmd = commands.getoutput('cp -a ' + '/tmp/' + file_name + ' ' + path)
			log.warn(LANG[FUCKING_LANG]['gstart'] + '..', '   - ')
			cmd = commands.getoutput('echo "' + start_cmd + '" > ' + path + '/start.sh')

		cmd = commands.getoutput('rm -rf ' + path + '/tmp')
		cmd = commands.getoutput('chmod +x ' + path + '/start.sh')

		if path == '.':
			starter = './start.sh'
		else:
			starter = 'cd ' + path + ' && ./start.sh'

		log.success(LANG[FUCKING_LANG]['ok'] + ' ' + C.GREEN + starter + C.NULL)


class C:
	def __init__(self):
		pass

	HEADER = '\033[0;95m'
	BLUE = '\033[0;94m'
	CYAN = '\033[0;96m'
	YELLOW = '\033[0;93m'
	RED = '\033[0;91m'
	NULL = '\033[0m'
	GREEN = '\033[0;92m'
	WHITE = '\033[0;97m'
	BLACK = '\033[0;90m'
