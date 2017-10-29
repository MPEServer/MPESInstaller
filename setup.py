from setuptools import setup

setup(
	name="MPESInstaller",
	version="1.0",
	author="TesLex Tech. (expexes)",
	author_email="devid.kohut@gmail.com",
	description="Minecraft Pocket Edition server installer",
	long_description="Minecraft Pocket Edition server installer writen on python",
	license="GPL-3",
	url="https://github.com/MPEServer/MPESInstaller",
	packages=['app'],
	entry_points={
		'console_scripts': ['mpesi = app.main:main', 'mpesinstaller = app.main:main']
	},
	data_files=[
		# ('share/applications/', ['vxlabs-myscript.desktop'])
	],
	classifiers=[
		'Programming Language :: Python :: 2',
		'Programming Language :: Python :: 2.7',
		'Programming Language :: Python :: 3',
		'Programming Language :: Python :: 3.3',
		'Programming Language :: Python :: 3.4',
		'Programming Language :: Python :: 3.5',
	],
)
