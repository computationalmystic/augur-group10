#SPDX-License-Identifier: MIT
"""
Data source that uses the DoSOCSv2 scanner to identify SPDX license information. 
"""

import re
from collections import deque
import subprocess
import os
from augur import logger
from augur.util import annotate

class DoSOCSv2(object):
    """Uses the DoSOCSv2 database to return dataframes with interesting GitHub indicators"""

    def __init__(self, repo_folder):
        """
        Connect to DoSOCSv2
        """
        self.__repo_folder = repo_folder
        self.scan('chaoss', 'augur')

    def scan(self, owner, repo):
        repo_url = 'https://github.com/' + owner + '/' + repo + '.git'

        repo_path = os.path.join(self.__repo_folder, repo)

        redirect = open(r"temp.txt", "w")
        subprocess.call(['git', 'clone', repo_url, repo_path], shell=False)
        LSTRING = subprocess.Popen(['dosocs2', 'oneshot', repo_path], shell=False, stdout=subprocess.PIPE)
        istr = subprocess.check_output(['dosocs2', 'oneshot', repo_path])
        direct = open("/home/nebrethar/augur/temp.txt", "r")
        direct.tell()
        direct.seek(0)
        direct.tell()
        lstr = direct.read()


        print("OUTPUTS")
        print(redirect)
        print(istr.decode('UTF-8'))
