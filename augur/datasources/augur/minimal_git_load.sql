insert into git_minimal.affiliations select * from facade.affiliations;
insert into git_minimal.aliases select * from facade.aliases;
insert into git_minimal.analysis_data select * from facade.analysis_data
  where  facade.analysis_data.repos_id >=1 and facade.analysis_data.repos_id <= 107;
insert into git_minimal.project_annual_cache select * from facade.project_annual_cache
  where facade.project_annual_cache.projects_id =1;
insert into git_minimal.project_monthly_cache select * from facade.project_monthly_cache
  where facade.project_monthly_cache.projects_id =1;
insert into git_minimal.project_weekly_cache select * from facade.project_weekly_cache
  where facade.project_weekly_cache.projects_id =1;
insert into git_minimal.projects select * from facade.projects where facade.projects.id = 1;
insert into git_minimal.repo_annual_cache select * from facade.repo_annual_cache
  where facade.repo_annual_cache.repos_id >=1 and facade.repo_annual_cache.repos_id <= 107;
insert into git_minimal.repo_monthly_cache select * from facade.repo_monthly_cache
  where facade.repo_monthly_cache.repos_id >=1 and facade.repo_monthly_cache.repos_id <= 107;
insert into git_minimal.repo_weekly_cache select * from facade.repo_weekly_cache
  where facade.repo_weekly_cache.repos_id >=1 and facade.repo_weekly_cache.repos_id <= 107;
insert into git_minimal.repos select * from facade.repos
  where facade.repos.projects_id = 1;
