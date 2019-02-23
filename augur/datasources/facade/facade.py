#SPDX-License-Identifier: MIT
"""
Data source that uses Facade's tables
"""

import base64
import pandas as pd
import sqlalchemy as s
from augur import logger
from augur.util import annotate
# end imports
# (don't remove the above line, it's for a script)


class Facade(object):
    """Queries Facade"""

    def __init__(self, user, password, host, port, dbname, projects=None):
        """
        Connect to the database

        :param dbstr: The [database string](http://docs.sqlalchemy.org/en/latest/core/engines.html) to connect to the GHTorrent database
        """
        self.DB_STR = 'mysql+pymysql://{}:{}@{}:{}/{}'.format(
            user, password, host, port, dbname
        )
        logger.debug('Facade: Connecting to {}:{}/{} as {}'.format(host, port, dbname, user))
        self.db = s.create_engine(self.DB_STR, poolclass=s.pool.NullPool)
        self.projects = projects

    #####################################
    ###    DIVERSITY AND INCLUSION    ###
    #####################################

    #####################################
    ### GROWTH, MATURITY, AND DECLINE ###
    #####################################


    #####################################
    ###            RISK               ###
    #####################################


    #####################################
    ###            VALUE              ###
    #####################################


    #####################################
    ###           ACTIVITY            ###
    #####################################


    #####################################
    ###         EXPERIMENTAL          ###
    #####################################

    @annotate(tag='downloaded-repos')
    def downloaded_repos(self):
        """
        Returns all repository names, URLs, and base64 URLs in the facade database
        """
        downloadedReposSQL = s.sql.text("""
            SELECT git AS url, status, projects.name as project_name
            FROM repos
            JOIN projects
            ON repos.projects_id = projects.id
        """)
        results = pd.read_sql(downloadedReposSQL, self.db)
        results['url'] = results['url'].apply(lambda datum: datum.split('//')[1])
        if self.projects:
            results = results[results.project_name.isin(self.projects)]

        b64_urls = []
        for i in results.index:
            b64_urls.append(base64.b64encode((results.at[i, 'url']).encode()))
        results['base64_url'] = b64_urls

        return results

    @annotate(tag='lines-changed-by-author')
    def lines_changed_by_author(self, repo_url):
        """
        Returns number of lines changed per author per day 

        :param repo_url: the repository's URL
        """
        linesChangedByAuthorSQL = s.sql.text("""
            SELECT author_email, author_date, author_affiliation as affiliation, SUM(added) as additions, SUM(removed) as deletions, SUM(whitespace) as whitespace
            FROM analysis_data
            WHERE repos_id = (SELECT id FROM repos WHERE git LIKE :repourl LIMIT 1)
            GROUP BY repos_id, author_date, author_affiliation, author_email
            ORDER BY author_date ASC;
        """)
        results = pd.read_sql(linesChangedByAuthorSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='lines-changed-by-week')
    def lines_changed_by_week(self, repo_url):
        """
        Returns lines changed of a sent repository per week 

        :param repo_url: the repository's URL
        """
        linesChangedByWeekSQL = s.sql.text("""
            SELECT date(author_date) as date, SUM(added) as additions, SUM(removed) as deletions, SUM(whitespace) as whitespace
            FROM analysis_data
            WHERE repos_id = (SELECT id FROM repos WHERE git LIKE :repourl LIMIT 1)
            GROUP BY YEARWEEK(author_date) 
            ORDER BY YEARWEEK(author_date) ASC
        """)
        results = pd.read_sql(linesChangedByWeekSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='lines-changed-by-month')
    def lines_changed_by_month(self, repo_url):
        """
        Returns lines changed of a sent repository per month 

        :param repo_url: the repository's URL
        """
        linesChangedByMonthSQL = s.sql.text("""
            SELECT email as author_email, affiliation, month, year, SUM(added) as additions, SUM(removed) as deletions, SUM(whitespace) as whitespace FROM repo_monthly_cache 
            WHERE repos_id = (SELECT id FROM repos WHERE git LIKE :repourl LIMIT 1)
            GROUP BY email, month, year
            ORDER BY year, month, email ASC
        """)
        results = pd.read_sql(linesChangedByMonthSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='commits-by-week')
    def commits_by_week(self, repo_url):
        """
        Returns number of patches per commiter per week

        :param repo_url: the repository's URL
        """
        commitsByMonthSQL = s.sql.text("""
            SELECT email AS author_email, affiliation, WEEK AS `week`, YEAR AS `year`, patches FROM repo_weekly_cache 
            WHERE repos_id = (SELECT id FROM repos WHERE git LIKE :repourl LIMIT 1)
            GROUP BY email, WEEK, YEAR
            ORDER BY YEAR, WEEK, email ASC
        """)
        results = pd.read_sql(commitsByMonthSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    # cd - code
    # rg - repo group
    # tp - time period (fixed time period)
    # interval
    # ranked - ordered top to bottom
    # commits
    # loc - lines of code
    # rep - repo
    # ua - unaffiliated

    @annotate(tag='cd-rg-newrep-ranked-commits')
    def cd_rg_newrep_ranked_commits(self, repo_url, calendar_year=None, repo_group=None):
        """
        Returns top new repos this year by commits


        """
        if calendar_year == None:
            calendar_year == 'year'

        

        cdRgNewrepRankedCommitsSQL = s.sql.text("""
           SELECT repos_id, sum(cast(repo_monthly_cache.added as signed) - cast(removed as signed) - cast(whitespace as signed)) as net, patches, projects.name
           FROM repo_monthly_cache, projects, repos
           where projects.name = (SELECT projects.name FROM repos, projects
           WHERE git LIKE :repourl
           and repos.projects_id = projects.id
           and YEAR(repos.added) = YEAR(CURDATE())
           LIMIT 1)
           and repo_annual_cache.repos_id = repos.id
           and repos.projects_id = projects.id
           group by repos_id
           ORDER BY net desc
           LIMIT 10
        """)
        results = pd.read_sql(cdRgNewrepRankedCommitsSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='cd-rg-newrep-ranked-loc')
    def cd_rg_newrep_ranked_loc(self, repo_url, calendar_year=None, repo_group=None):
        """
        Returns top new repos this year by lines of code


        """       

        if calendar_year == None:
            calendar_year = 'year'

        cdRgNewrepRankedLocSQL = None
        if timeframe == 'year':
            cdRgNewrepRankedLocSQL = s.sql.text("""
                SELECT repos_id, sum(cast(repo_annual_cache.added as signed) - cast(removed as signed) - cast(whitespace as signed)) as net, patches, projects.name
               FROM repo_annual_cache, projects, repos
               where projects.name = (SELECT projects.name FROM repos, projects
               WHERE git LIKE :repourl
               and YEAR(repos.added) = YEAR(CURDATE())
               and repos.projects_id = projects.id
               LIMIT 1)
               and repo_annual_cache.repos_id = repos.id
               and repos.projects_id = projects.id
               group by repos_id
               ORDER BY net desc
               LIMIT 10
            """)
        elif timeframe == 'month':
            cdRgNewrepRankedLocSQL = s.sql.text("""
                SELECT repos_id, sum(cast(repo_annual_cache.added as signed) - cast(removed as signed) - cast(whitespace as signed)) as net, patches, projects.name
               FROM repo_annual_cache, projects, repos
               where projects.name = (SELECT projects.name FROM repos, projects
               WHERE git LIKE :repourl
               and MONTH(repos.added) = MONTH(CURDATE())
               and repos.projects_id = projects.id
               LIMIT 1)
               and repo_annual_cache.repos_id = repos.id
               and repos.projects_id = projects.id
               group by repos_id
               ORDER BY net desc
               LIMIT 10
            """)
        results = pd.read_sql(cdRgNewrepRankedLocSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='cd-rg-tp-ranked-commits')
    def cd_rg_tp_ranked_commits(self, repo_url, calendar_year=None, repo_group=None):
        """
        Returns top new repos of all time by commits within given repo's organization


        """       

        cdRgTpRankedCommitsSQL = s.sql.text("""
           SELECT repos_id, repos.name as name, sum(cast(repo_annual_cache.added as signed) - cast(removed as signed) - cast(whitespace as signed)) as net, patches
           FROM repo_annual_cache, projects, repos
           where projects.name = (SELECT projects.name FROM repos, projects
           WHERE git LIKE :repourl
           and repos.projects_id = projects.id
           LIMIT 1)
           and repo_annual_cache.repos_id = repos.id
           and repos.projects_id = projects.id
           group by repos_id
           ORDER BY net desc
           LIMIT 10
        """)
        results = pd.read_sql(cdRgTpRankedCommitsSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='cd-rg-tp-ranked-loc')
    def cd_rg_tp_ranked_loc(self, repo_url, calendar_year=None, repo_group=None):
        """
        Returns top new repos of all time by lines of code within given repo's organization

        :param limit: number of repos the user wishes to display
        """

        if calendar_year == None:
            calendar_year == 'year'

        cdRgTpRankedLocSQL = s.sql.text("""
            SELECT repos_id, repos.name as name, sum(cast(repo_annual_cache.added as signed) - cast(removed as signed) - cast(whitespace as signed)) as net, patches
           FROM repo_annual_cache, projects, repos
           where projects.name = (SELECT projects.name FROM repos, projects
           WHERE git LIKE :repourl
           and repos.projects_id = projects.id
           LIMIT 1)
           and repo_annual_cache.repos_id = repos.id
           and repos.projects_id = projects.id
           group by repos_id
           ORDER BY net desc
           LIMIT 10
        """)
        results = pd.read_sql(cdRgTpRankedLocSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='cd-rep-tp-interval-loc-commits')
    def cd_rep_tp_interval_loc_commits(self, repo_url, year=None, interval=None, repo_group=None):
        """
        Returns commits and lines of code data for a given time interval throughout the current or a given year

        :param year: 
        :param interval: 
        """

        if year == None:
            year = 2019
        if interval == None:
            interval = 'monthly'



        cdRepTpIntervalLocCommitsSQL = s.sql.text("""
            SELECT name, sum(cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, 
            sum(IFNULL(added, 0)) as added, sum(IFNULL(removed, 0)) as removed, sum(IFNULL(whitespace, 0)) as whitespace, 
            IFNULL(patches, 0) as commits, a.month, IFNULL(year, :year) as year
            FROM (select month from repo_monthly_cache group by month) a 
            LEFT JOIN (SELECT name, repo_monthly_cache.added, removed, whitespace, patches, month, IFNULL(year, :year) as year      
            FROM repo_monthly_cache, repos
            WHERE repos_id = (SELECT id FROM repos WHERE git LIKE :repourl LIMIT 1)
            AND year = :year
            AND repos.id = repos_id     
            GROUP BY month) b 
            ON a.month = b.month
            GROUP BY month
        """)
        results = pd.read_sql(cdRepTpIntervalLocCommitsSQL, self.db, params={"repourl": '%{}%'.format(repo_url), 'year': year})
        return results

    @annotate(tag='cd-rep-tp-interval-loc-commits-ua')
    def cd_rep_tp_interval_loc_commits_ua(self, repo_url, year=None, interval=None, repo_group=None):
        """
        Returns commits and lines of code data for a given time interval throughout the current or a given year

        :param year: 
        :param interval: 
        """

        cdRepTpIntervalLocCommitsUaSQL = s.sql.text("""
            SELECT added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.month, affiliation 
            FROM (SELECT month FROM repo_monthly_cache GROUP BY month) a 
            LEFT JOIN
            (
                SELECT SUM(repo_monthly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, month, SUM(patches) as patches, repo_monthly_cache.`affiliation` as affiliation
                FROM repo_monthly_cache, repos, projects
                WHERE repo_monthly_cache.repos_id = repos.id
                AND repos.projects_id = (SELECT projects.id FROM repos, projects 
                WHERE git LIKE 'https://github.com/twitter/twemoji' 
                and repos.projects_id = projects.id
                LIMIT 1)
                AND projects.id = repos.projects_id
                AND repo_monthly_cache.`affiliation` <> projects.name
                AND year = 2018
                GROUP BY month, affiliation
            ) b ON a.month = b.month
            ORDER BY month
        """)
        results = pd.read_sql(cdRepTpIntervalLocCommitsUaSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

    @annotate(tag='cd-rg-tp-interval-loc-commits')
    def cd_rg_tp_interval_loc_commits(self, repo_url, year=None, interval=None, repo_group=None):
        """
        Returns commits and lines of code data for a given time interval throughout the current or a given year

        :param year: 
        :param interval: 
        """

        cdRgTpIntervalLocCommitsSQL = s.sql.text("""
            SELECT name, added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.month
            FROM (SELECT month FROM repo_monthly_cache GROUP BY month) a 
            LEFT JOIN
            (
                SELECT repos.name, SUM(repo_monthly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, month, SUM(patches) as patches
                FROM repo_monthly_cache, repos, projects
                WHERE repo_monthly_cache.repos_id = repos.id
                AND repos.projects_id = (SELECT projects.id FROM repos, projects 
                    WHERE git LIKE 'https://github.com/twitter/twemoji' 
                    and repos.projects_id = projects.id
                    LIMIT 1)
                AND projects.id = repos.projects_id
                AND repos_id = repos.id
                AND year = 2018
                GROUP BY month, repos.name
            ) b ON a.month = b.month
            ORDER BY name, month
        """)
        results = pd.read_sql(cdRgTpIntervalLocCommitsSQL, self.db, params={"repourl": '%{}%'.format(repo_url)})
        return results

