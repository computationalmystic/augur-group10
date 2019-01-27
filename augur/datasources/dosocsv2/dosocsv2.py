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
        self.scan('nebrethar', 'DoSOCSv2')

    def scan(self, owner, repo):
        repo_url = 'https://github.com/' + owner + '/' + repo + '.git'

        repo_path = os.path.join(self.__repo_folder, repo)

        temp=open("temp.txt", "r+")
        subprocess.call(['git', 'clone', repo_url, '/home/repos/' + repo], shell=False)
        pope = subprocess.Popen(['sudo', 'dosocs2', 'oneshot', '/home/repos/' + repo, '-T', '/home/nebrethar/augur/2.0.tag'], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = pope.communicate()
        if out:
            print(out)
        if err:
            print(err)
        print (out)
        find = re.findall(r'\n(LicenseID): (.*[^\s]*)\n(LicenseName): (.*[^s])\n(ExtractedText): b\'(.*[^s])\'\n(LicenseCrossReference): (.*)\n(LicenseComment): (.*[^s])', out.decode('UTF-8'))
        print(find)
