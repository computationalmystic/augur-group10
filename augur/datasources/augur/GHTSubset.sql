--GHTorrent Subsetting:
select * from projects WHERE
replace(url, 'https://api.github.com/repos/','') like 'twitter/%';
-- owner_id = 5092
