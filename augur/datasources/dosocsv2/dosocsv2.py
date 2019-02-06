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
    
        repo_url = 'https://github.com/' + 'rails' + '/' + 'rails' + '.git'

        repo_path = os.path.join(self.__repo_folder, repo)
        cwd = os.path.dirname(os.path.realpath(__file__))

        temp = open("temp.txt", "r+")
        subprocess.call(['sudo', 'git', 'clone', repo_url, cwd + '/repodl/' + repo], shell=False)
        pope = subprocess.Popen(['sudo', 'dosocs2', 'oneshot', cwd + '/repodl/' + repo, '-T', cwd + '/2.0.tag.3'], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        subprocess.call(['sudo', 'dosocs2', 'oneshot', cwd + '/repodl/' + repo], shell=False, stdout=temp)
        out, err = pope.communicate()
        #if out:
            #print(out)
        if err:
            print(err)
        #print (out)
        scan_results = re.findall(r'(PackageName): (.*)\n(SPDXID): (.*)\n(PackageVersion|):? ?(.*|)\n?(PackageFileName): (.*)\n(PackageSupplier): (.*)\n(PackageOriginator): (.*)\n(PackageDownloadLocation): (.*)\n(PackageVerificationCode): (.*)\n(PackageChecksum|):? ?(.*|)\n?(PackageHomePage): (.*)\n(PackageLicenseConcluded): (.*)\n*(PackageLicenseDeclared): (.*)\n(PackageLicenseComments): (.*)\n(PackageCopyrightText): (.*)\n(PackageSummary): (.*)\n(PackageDescription): (.*)\n(PackageComment): (.*|)', out.decode('UTF-8'))
        scan_results_l = re.findall(r'(PackageLicenseInfoFromFiles): (.*)\n?', out.decode('UTF-8')),
        def concat():
            return (scan_results, scan_results_l)
        #scan_results = [('LicenseID', 'LicenseRef-Python', 'LicenseName', 'Python', 'ExtractedText', 'licenses/CNRI-Python.html",\\n        "is_spdx_official": true,\\n        "name": "CNRI Python License', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n'), ('LicenseID', 'LicenseRef-IJG-possibility', 'LicenseName', 'IJG-possibility', 'ExtractedText', 'Independent JPEG Group', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n'), ('LicenseID', 'LicenseRef-Classpath-exception-2.0', 'LicenseName', 'Classpath-exception-2.0', 'ExtractedText', 'Classpath exception', 'LicenseCrossReference', '', 'LicenseComment', 'found by nomos\n')]
        return concat()

    def retrieve_license_information(self, owner, repo):
        results, results_l = self.scan(owner, repo)

        #print(results_l)
        license_information = []
        print('\n')
        print(results_l)
        print('\n')
        temp = {}
        for i in range(0, 17):
            j = i*2
            temp[results[0][j]] = results[0][j+1]

        license_information.append(temp)

        temp_l = {}
        i = 0
        for i in range(0, len(results_l[0])):
            temp_l["License #" + str(i)] = results_l[0][i][1]
            i += 1
        print(temp_l)
        license_information.append(temp_l)
        #dfinal = dict(temp)
        #dfinal.update(temp_l)
        return json.dumps(license_information)


