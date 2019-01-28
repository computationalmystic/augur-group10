#SPDX-License-Identifier: MIT
"""
Data source that uses the DoSOCSv2 scanner to identify SPDX license information. 
"""

import json
import re
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
        # self.retrieve_license_information('test', 'string')
        # self.scan('nebrethar', 'DoSOCSv2')

    def scan(self, owner, repo):
        repo_url = 'https://github.com/' + owner + '/' + repo + '.git'

        repo_path = os.path.join(self.__repo_folder, repo)

        temp = open("temp.txt", "r+")
        subprocess.call(['sudo', 'git', 'clone', repo_url, '/home/repos/' + repo], shell=False)
        pope = subprocess.Popen(['sudo', 'dosocs2', 'oneshot', '/home/repos/' + repo, '-T', '/home/nebrethar/augur/2.0.tag'], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = pope.communicate()
        if out:
            print(out)
        if err:
            print(err)
        print (out)
        scan_results = re.findall(r'\n(LicenseID): (.*[^\s]*)\n(LicenseName): (.*[^s])\n(ExtractedText): b\'(.*[^s])\'\n(LicenseCrossReference): (.*)\n(LicenseComment): (.*[^s])', out.decode('UTF-8'))
        print(scan_results)
        #scan_results = [('LicenseID', 'LicenseRef-Python', 'LicenseName', 'Python', 'ExtractedText', 'licenses/CNRI-Python.html",\\n        "is_spdx_official": true,\\n        "name": "CNRI Python License', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n'), ('LicenseID', 'LicenseRef-IJG-possibility', 'LicenseName', 'IJG-possibility', 'ExtractedText', 'Independent JPEG Group', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n'), ('LicenseID', 'LicenseRef-Classpath-exception-2.0', 'LicenseName', 'Classpath-exception-2.0', 'ExtractedText', 'Classpath exception', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n')]
        return scan_results

    def retrieve_license_information(self, owner, repo):
        results = self.scan(owner, repo)

        license_information = []

        for i in range(0, len(results)):
            temp = {}
            temp[results[i][0]] = results[i][1]
            temp[results[i][2]] = results[i][3]
            temp[results[i][4]] = results[i][5]
            temp[results[i][6]] = results[i][7]
            temp[results[i][8]] = results[i][9]
            license_information.append(temp)

        return json.dumps(license_information)


