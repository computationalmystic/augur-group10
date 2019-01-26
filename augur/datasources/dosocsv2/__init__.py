#SPDX-License-Identifier: MIT
from augur.application import Application
from augur.augurplugin import AugurPlugin
from augur import logger

class DoSOCSv2Plugin(AugurPlugin):
    """
    This plugin serves as an example as to how to load plugins into Augur
    """
    def __init__(self, augur):
        self.__dosocsv2 = None
        # _augur will be set by the super init
        super().__init__(augur)

    def __call__(self):
        from .dosocsv2 import DoSOCSv2
        if self.__dosocsv2 is None:
            logger.debug('Initializing DoSOCSv2')
            self.__dosocsv2 = DoSOCSv2(
                repo_folder=self._augur.path('$(RUNTIME)/plugindata/dosocsv2/', create=True)
            )
        return self.__dosocsv2

    def create_routes(self, flask_app):
        """
        Responsible for adding this plugin's data sources to the API
        """
        from .routes import create_routes
        create_routes(flask_app)

DoSOCSv2Plugin.augur_plugin_meta = {
    'name': 'dosocsv2',
    'datasource': True
}

Application.register_plugin(DoSOCSv2Plugin)

__all__ = ['DoSOCSv2Plugin']
