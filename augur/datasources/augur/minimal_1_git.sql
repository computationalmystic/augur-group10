-- Remove drop statements during first execution
DROP INDEX `domain,affiliation,start_date` ON `affiliations`;
DROP INDEX `domain,active` ON `affiliations`;
DROP INDEX `canonical,alias` ON `aliases`;
DROP INDEX `alias,active` ON `aliases`;
DROP INDEX `author_email,author_affiliation,author_date` ON `analysis_data`;
DROP INDEX `committer_email,committer_affiliation,committer_date` ON `analysis_data`;
DROP INDEX `repos_id,commit` ON `analysis_data`;
DROP INDEX `author_raw_email` ON `analysis_data`;
DROP INDEX `committer_raw_email` ON `analysis_data`;
DROP INDEX `author_affiliation` ON `analysis_data`;
DROP INDEX `committer_affiliation` ON `analysis_data`;
DROP INDEX `projects_id,affiliation` ON `project_annual_cache`;
DROP INDEX `projects_id,email` ON `project_annual_cache`;
DROP INDEX `projects_id,year,affiliation` ON `project_monthly_cache`;
DROP INDEX `projects_id,year,email` ON `project_monthly_cache`;
DROP INDEX `projects_id,affiliation` ON `project_monthly_cache`;
DROP INDEX `projects_id,email` ON `project_monthly_cache`;
DROP INDEX `projects_id,year,affiliation` ON `project_weekly_cache`;
DROP INDEX `projects_id,year,email` ON `project_weekly_cache`;
DROP INDEX `projects_id,affiliation` ON `project_weekly_cache`;
DROP INDEX `projects_id,email` ON `project_weekly_cache`;
DROP INDEX `repos_id,affiliation` ON `repo_annual_cache`;
DROP INDEX `repos_id,email` ON `repo_annual_cache`;
DROP INDEX `repos_id,year,affiliation` ON `repo_monthly_cache`;
DROP INDEX `repos_id,year,email` ON `repo_monthly_cache`;
DROP INDEX `repos_id,affiliation` ON `repo_monthly_cache`;
DROP INDEX `repos_id,email` ON `repo_monthly_cache`;
DROP INDEX `repos_id,year,affiliation` ON `repo_weekly_cache`;
DROP INDEX `repos_id,year,email` ON `repo_weekly_cache`;
DROP INDEX `repos_id,affiliation` ON `repo_weekly_cache`;
DROP INDEX `repos_id,email` ON `repo_weekly_cache`;

DROP TABLE `affiliations`;
DROP TABLE `aliases`;
DROP TABLE `analysis_data`;
DROP TABLE `project_annual_cache`;
DROP TABLE `project_monthly_cache`;
DROP TABLE `project_weekly_cache`;
DROP TABLE `projects`;
DROP TABLE `repo_annual_cache`;
DROP TABLE `repo_monthly_cache`;
DROP TABLE `repo_weekly_cache`;
DROP TABLE `repos`;

CREATE TABLE `affiliations` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`domain` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`start_date` date NOT NULL DEFAULT '1970-01-01',
`active` tinyint(1) NOT NULL DEFAULT 1,
`last_modified` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `domain,affiliation,start_date` (`domain` ASC, `affiliation` ASC, `start_date` ASC),
INDEX `domain,active` (`domain` ASC, `active` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 522
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `aliases` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`canonical` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`alias` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`active` tinyint(1) NOT NULL DEFAULT 1,
`last_modified` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `canonical,alias` (`canonical` ASC, `alias` ASC),
INDEX `alias,active` (`alias` ASC, `active` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `analysis_data` (
`repos_id` int(10) UNSIGNED NOT NULL,
`commit` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`author_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`author_raw_email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`author_email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`author_date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`author_affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`committer_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`committer_raw_email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`committer_email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`committer_date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`committer_affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`added` int(10) UNSIGNED NOT NULL,
`removed` int(10) UNSIGNED NOT NULL,
`whitespace` int(10) UNSIGNED NOT NULL,
`filename` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`date_attempted` timestamp NOT NULL DEFAULT current_timestamp,
INDEX `author_email,author_affiliation,author_date` (`author_email` ASC, `author_affiliation` ASC, `author_date` ASC),
INDEX `committer_email,committer_affiliation,committer_date` (`committer_email` ASC, `committer_affiliation` ASC, `committer_date` ASC),
INDEX `repos_id,commit` (`repos_id` ASC, `commit` ASC),
INDEX `author_raw_email` (`author_raw_email` ASC),
INDEX `committer_raw_email` (`committer_raw_email` ASC),
INDEX `author_affiliation` (`author_affiliation` ASC),
INDEX `committer_affiliation` (`committer_affiliation` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `project_annual_cache` (
`projects_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `projects_id,affiliation` (`projects_id` ASC, `affiliation` ASC),
INDEX `projects_id,email` (`projects_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `project_monthly_cache` (
`projects_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`month` tinyint(3) UNSIGNED NOT NULL,
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `projects_id,year,affiliation` (`projects_id` ASC, `year` ASC, `affiliation` ASC),
INDEX `projects_id,year,email` (`projects_id` ASC, `year` ASC, `email` ASC),
INDEX `projects_id,affiliation` (`projects_id` ASC, `affiliation` ASC),
INDEX `projects_id,email` (`projects_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `project_weekly_cache` (
`projects_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`week` tinyint(3) UNSIGNED NOT NULL,
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `projects_id,year,affiliation` (`projects_id` ASC, `year` ASC, `affiliation` ASC),
INDEX `projects_id,year,email` (`projects_id` ASC, `year` ASC, `email` ASC),
INDEX `projects_id,affiliation` (`projects_id` ASC, `affiliation` ASC),
INDEX `projects_id,email` (`projects_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `projects` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`website` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`recache` tinyint(1) NULL DEFAULT 1,
`last_modified` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `repo_annual_cache` (
`repos_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `repos_id,affiliation` (`repos_id` ASC, `affiliation` ASC),
INDEX `repos_id,email` (`repos_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `repo_monthly_cache` (
`repos_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`month` tinyint(3) UNSIGNED NOT NULL,
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `repos_id,year,affiliation` (`repos_id` ASC, `year` ASC, `affiliation` ASC),
INDEX `repos_id,year,email` (`repos_id` ASC, `year` ASC, `email` ASC),
INDEX `repos_id,affiliation` (`repos_id` ASC, `affiliation` ASC),
INDEX `repos_id,email` (`repos_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `repo_weekly_cache` (
`repos_id` int(10) UNSIGNED NOT NULL,
`email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`week` tinyint(3) UNSIGNED NOT NULL,
`year` smallint(5) UNSIGNED NOT NULL,
`added` bigint(20) UNSIGNED NOT NULL,
`removed` bigint(20) UNSIGNED NOT NULL,
`whitespace` bigint(20) UNSIGNED NOT NULL,
`files` bigint(20) UNSIGNED NOT NULL,
`patches` bigint(20) UNSIGNED NOT NULL,
INDEX `repos_id,year,affiliation` (`repos_id` ASC, `year` ASC, `affiliation` ASC),
INDEX `repos_id,year,email` (`repos_id` ASC, `year` ASC, `email` ASC),
INDEX `repos_id,affiliation` (`repos_id` ASC, `affiliation` ASC),
INDEX `repos_id,email` (`repos_id` ASC, `email` ASC)
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
CREATE TABLE `repos` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`projects_id` int(10) UNSIGNED NOT NULL,
`git` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NULL',
`added` timestamp NOT NULL DEFAULT current_timestamp,
`status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`id`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 172
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ROW_FORMAT = dynamic;
