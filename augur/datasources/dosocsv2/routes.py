#SPDX-License-Identifier: MIT
"""
Creates routes for the GHTorrent data source plugin
"""

from flask import request, Response

def create_routes(server):

    dosocsv2 = server._augur['dosocsv2']()

    @server.app.route("/{}/<owner>/<repo>/dosocsv2/retrieve_license_information".format(server.api_version))
    def retrieve_license_information(owner, repo):
        respond = Response(response=dosocsv2.retrieve_license_information('nebrethar', 'DoSOCSv2'),
                        status=200,
                        mimetype="application/json")
        respond.headers['Access-Control-Allow-Origin'] = '*'
        respond.headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
        respond.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        respond.headers['Content-Security-Policy'] = "default-src 'self'"
        return respond
