#SPDX-License-Identifier: MIT
"""
Creates routes for the GHTorrent data source plugin
"""

from flask import request, Response

def create_routes(server):

    dosocsv2 = server._augur['dosocsv2']()

    @server.app.route("/{}/<owner>/<repo>/dosocsv2/retrieve_license_information".format(server.api_version))
    def retrieve_license_information(owner, repo):
        return Response(response=dosocsv2.retrieve_license_information(owner, repo),
                        status=200,
                        mimetype="application/json")
