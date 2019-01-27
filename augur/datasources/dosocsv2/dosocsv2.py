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

        subprocess.call(['git', 'clone', repo_url, repo_path], shell=False)
        istr = subprocess.check_output(['dosocs2', 'oneshot', repo_path])

        print(istr.decode('UTF-8'))
