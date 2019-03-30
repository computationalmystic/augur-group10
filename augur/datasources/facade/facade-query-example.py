    @annotate(tag='')
    def cd_rg_tp_interval_loc_commits(self, repo_url, calendar_year=None, interval=None, repo_group=None):
        """
        For each repository in a collection of repositories, all the commits and lines of code occuring for the specified year, 
        grouped by repository and the specified interval (week or month). Results ordered by repo. 
        
        :param repo_url: the repository's URL
        :param calendar_year: the calendar year a repo is created in to be considered "new"
        :param interval: Month or week. The periodocity of which to examine data within the given calendar_year
        :param repo_group: the group of repositories to analyze
        """

        if calendar_year == None:
            calendar_year = 2019

        if interval == None:
            interval = 'month'

        if repo_group == None:
            repo_group = 'facade_project'

        cdRgTpIntervalLocCommitsSQL = None

        if repo_group == 'facade_project':
            if interval == "month":
                cdRgTpIntervalLocCommitsSQL = s.sql.text("""
                    SELECT name, added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.month
                    FROM (SELECT month FROM repo_monthly_cache GROUP BY month) a 
                    LEFT JOIN
                    (
                        SELECT repos.name, SUM(repo_monthly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, month, SUM(patches) as patches
                        FROM repo_monthly_cache, repos, projects
                        WHERE repo_monthly_cache.repos_id = repos.id
                        AND repos.projects_id = (SELECT projects.id FROM repos, projects 
                            WHERE git LIKE :repourl
                            and repos.projects_id = projects.id
                            LIMIT 1)
                        AND projects.id = repos.projects_id
                        AND repos_id = repos.id
                        AND year = :calendar_year
                        GROUP BY month, repos.name
                    ) b ON a.month = b.month
                    ORDER BY month, name
                """)
            elif interval == "week":
                cdRgTpIntervalLocCommitsSQL = s.sql.text("""
                    SELECT name, added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.week
                    FROM (SELECT week FROM repo_weekly_cache GROUP BY week) a 
                    LEFT JOIN
                    (
                        SELECT repos.name, SUM(repo_weekly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, week, SUM(patches) as patches
                        FROM repo_weekly_cache, repos, projects
                        WHERE repo_weekly_cache.repos_id = repos.id
                        AND repos.projects_id = (SELECT projects.id FROM repos, projects 
                            WHERE git LIKE :repourl
                            and repos.projects_id = projects.id
                            LIMIT 1)
                        AND projects.id = repos.projects_id
                        AND repos_id = repos.id
                        AND year = :calendar_year
                        GROUP BY week, repos.name
                    ) b ON a.week = b.week
                    ORDER BY week, name
                """)
        else:
            if interval == "month":
                cdRgTpIntervalLocCommitsSQL = s.sql.text("""
                    SELECT name, added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.month
                    FROM (SELECT month FROM repo_monthly_cache GROUP BY month) a 
                    LEFT JOIN
                    (
                        SELECT repos.name, SUM(repo_monthly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, month, SUM(patches) as patches
                        FROM repo_monthly_cache, repos, projects
                        WHERE repo_monthly_cache.repos_id = repos.id
                        AND repos.projects_id = :repo_group
                        AND projects.id = repos.projects_id
                        AND repos_id = repos.id
                        AND year = :calendar_year
                        GROUP BY month, repos.name
                    ) b ON a.month = b.month
                    ORDER BY month, name
                """)
            elif interval == "week":
                cdRgTpIntervalLocCommitsSQL = s.sql.text("""
                    SELECT name, added, whitespace, removed, (cast(IFNULL(added, 0) as signed) - cast(IFNULL(removed, 0) as signed) - cast(IFNULL(whitespace, 0) as signed)) as net_lines_minus_whitespace, patches, a.week
                    FROM (SELECT week FROM repo_weekly_cache GROUP BY week) a 
                    LEFT JOIN
                    (
                        SELECT repos.name, SUM(repo_weekly_cache.added) AS added, SUM(whitespace) as whitespace, SUM(removed) as removed, week, SUM(patches) as patches
                        FROM repo_weekly_cache, repos, projects
                        WHERE repo_weekly_cache.repos_id = repos.id
                        AND repos.projects_id = :repo_group
                        AND projects.id = repos.projects_id
                        AND repos_id = repos.id
                        AND year = :calendar_year
                        GROUP BY week, repos.name
                    ) b ON a.week = b.week
                    ORDER BY week, name
                """)
        results = pd.read_sql(cdRgTpIntervalLocCommitsSQL, self.db, params={"repourl": '%{}%'.format(repo_url), "calendar_year": calendar_year, "repo_group": repo_group})
        return results 