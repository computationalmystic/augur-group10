import os
import pytest

@pytest.fixture(scope="module")
def dosocs2():
    import augur
    augur_app = augur.Application()
    return augur_app['dosocs2']()

