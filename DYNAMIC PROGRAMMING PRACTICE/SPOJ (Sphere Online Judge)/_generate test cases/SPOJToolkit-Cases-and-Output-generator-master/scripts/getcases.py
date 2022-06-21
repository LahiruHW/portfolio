try:
    from urllib2 import urlopen
except:
    from urllib.request import urlopen
try:
    from HTMLParser import HTMLParser
except:
    from html.parser import HTMLParser

from sys import argv
from subprocess import call
from functools import partial, wraps
import re
import argparse
import os

class TestCaseParser(HTMLParser):
	def __init__(self):
		HTMLParser.__init__(self)
		self.test_cases = []
		self.flag = False

	def handle_starttag(self, tag, attrs):
		if tag == 'pre':
			self.flag = True

	def handle_data(self, data):
		if self.flag:
			self.test_cases.append(data)

	def handle_endtag(self, tag):
		if tag == 'pre':
			self.flag = False


	
def parse_problem(problemID):
		url = 'http://www.spojtoolkit.com/history/%s' % (problemID)
		html = urlopen(url).read()
		parser = TestCaseParser()
		parser.feed(html.decode('utf-8'))
		return parser


def main():
	problemID = argv[1]
	data = parse_problem(problemID)
	i = 1
	os.mkdir(problemID)
	os.chdir(problemID)
	for testcase in data.test_cases:
		f = open('%s.in' % (i), 'w')
		f.write(testcase)
		f.close()
		i += 1

main()

