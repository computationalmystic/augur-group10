import os
import pytest
import time
import augur.server
import requests

@pytest.fixture(scope="module")
def metrics_status():
    import augur
    augur_app = augur.Application()
    augur.server.run_shell()

    metrics_status_data = augur_app['metrics_status']().metrics_status

    return metrics_status_data

# def test_tag(metrics_status):
#     code_commits = next((metric for metric in metrics_status if metric['tag'] == "code-commits"), None)
#     assert code_commits is not None

def test_status(metrics_status):
    code_commits = next((metric for metric in metrics_status if metric['tag'] == "code-commits"), None)
    assert code_commits is None

# def test_lines_changed_by_week(metrics_status):
#     assert False

# def test_lines_changed_by_month(metrics_status):
#     assert False

# def test_commits_by_week(metrics_status):
#     assert False
