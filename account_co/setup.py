"""
El archivo setup.py describe cómo debe instalarse su módulo.
"""

#!/usr/bin/env python3
# This file is part of Tryton.  The COPYRIGHT file at the top level of
# this repository contains the full copyright notices and license terms.

from setuptools import setup
import re
import os
import io
from configparser import ConfigParser

MODULE = 'account_co'
PREFIX = 'tryton'
MODULE2PREFIX = {}


def read(fname):
    return io.open(
        os.path.join(os.path.dirname(__file__), fname),
        'r', encoding='utf-8').read()


def get_require_version(name):
    if minor_version % 2:
        require = '%s >= %s.%s.dev0, < %s.%s'
    else:
        require = '%s >= %s.%s, < %s.%s'
    require %= (name, major_version, minor_version,
        major_version, minor_version + 1)
    return require


config = ConfigParser()
config.readfp(open('tryton.cfg'))
info = dict(config.items('tryton'))
for key in ('depends', 'extras_depend', 'xml'):
    if key in info:
        info[key] = info[key].strip().splitlines()
version = info.get('version', '0.0.1')
major_version, minor_version, _ = version.split('.', 2)
major_version = int(major_version)
minor_version = int(minor_version)
name = '%s_%s' % (PREFIX, MODULE)

download_url = 'http://downloads.tryton.org/%s.%s/' % (
    major_version, minor_version)
if minor_version % 2:
    version = '%s.%s.dev0' % (major_version, minor_version)
    download_url = (
        'hg+http://hg.tryton.org/modules/%s#egg=%s-%s' % (
            name[8:], name, version))

requires = ['python-sql >= 0.4']
for dep in info.get('depends', []):
    if not re.match(r'(ir|res)(\W|$)', dep):
        requires.append(get_require_version('trytond_%s' % dep))
requires.append(get_require_version('trytond'))

tests_require = [get_require_version('proteus')]
dependency_links = []
if minor_version % 2:
    # Add development index for testing with proteus
    dependency_links.append('https://trydevpi.tryton.org/')

setup(name=name,
    version=version,
    description='Tryton module cdst conector',
    long_description=read('README.md'),
    author='Cristhian Lancheros',
    author_email='clancheros@cdst.com',
    url='http://www.cdst.com/',
    download_url="https://github.com/lancheros/%s" % name,
    keywords='tryton %s' % MODULE,
    package_dir={'trytond.modules.%s' % MODULE: '.'},
    packages=[
        'trytond.modules.%s' % MODULE,
        'trytond.modules.%s.tests' % MODULE,
        ],
    package_data={
        'trytond.modules.%s' % MODULE: (info.get('xml', [])
            + ['tryton.cfg', 'view/*.xml', 'locale/*.po', '*.fodt',
                '*.fods']),
        },
    #classifiers=[
    #    'Development Status :: 5 - Production/Stable',
    #    'Environment :: Plugins',
    #    'Framework :: Tryton',
    #    'Intended Audience :: Developers',
    #    'Intended Audience :: Financial and Insurance Industry',
    #    'Intended Audience :: Legal Industry',
    #    'License :: OSI Approved :: GNU General Public License (GPL)',
    #    'Natural Language :: English',
    #    'Natural Language :: Spanish',
    #    'Operating System :: OS Independent',
    #    'Programming Language :: Python :: 2.7',
    #    'Programming Language :: Python :: 3.3',
    #    'Programming Language :: Python :: 3.4',
    #    'Programming Language :: Python :: 3.5',
    #    'Programming Language :: Python :: Implementation :: CPython',
    #    'Programming Language :: Python :: Implementation :: PyPy',
    #    'Topic :: Office/Business',
    #    'Topic :: Office/Business :: Financial :: Accounting',
    #    ],
    platforms='any',
    license='GPL-3',
    python_requires='>=3.4',
    install_requires=requires,
    dependency_links=dependency_links,
    zip_safe=False,
    entry_points="""
    [trytond.modules]
    %s = trytond.modules.%s
    """ % (MODULE, MODULE),
    #test_suite='tests',
    #test_loader='trytond.test_loader:Loader',
    #tests_require=tests_require,
    #use_2to3=True,
    #convert_2to3_doctests=[
    #    'tests/scenario.rst',
    #    ],
    )