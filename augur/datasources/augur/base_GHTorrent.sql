DROP INDEX `comment_id` ON `commit_comments`;
DROP INDEX `commit_comments_ibfk_1` ON `commit_comments`;
DROP INDEX `commit_comments_ibfk_2` ON `commit_comments`;
DROP INDEX `commit_parents_ibfk_1` ON `commit_parents`;
DROP INDEX `commit_parents_ibfk_2` ON `commit_parents`;
DROP INDEX `sha` ON `commits`;
DROP INDEX `commits_ibfk_1` ON `commits`;
DROP INDEX `commits_ibfk_2` ON `commits`;
DROP INDEX `commits_ibfk_3` ON `commits`;
DROP INDEX `follower_fk2` ON `followers`;
DROP INDEX `follower_id` ON `followers`;
DROP INDEX `issue_comments_ibfk_1` ON `issue_comments`;
DROP INDEX `issue_comments_ibfk_2` ON `issue_comments`;
DROP INDEX `issue_events_ibfk_1` ON `issue_events`;
DROP INDEX `issue_events_ibfk_2` ON `issue_events`;
DROP INDEX `issue_labels_ibfk_1` ON `issue_labels`;
DROP INDEX `issues_ibfk_1` ON `issues`;
DROP INDEX `issues_ibfk_2` ON `issues`;
DROP INDEX `issues_ibfk_3` ON `issues`;
DROP INDEX `issues_ibfk_4` ON `issues`;
DROP INDEX `organization_members_ibfk_2` ON `organization_members`;
DROP INDEX `project_commits_ibfk_1` ON `project_commits`;
DROP INDEX `commit_id` ON `project_commits`;
DROP INDEX `project_id` ON `project_languages`;
DROP INDEX `project_members_ibfk_2` ON `project_members`;
DROP INDEX `projects_ibfk_1` ON `projects`;
DROP INDEX `projects_ibfk_2` ON `projects`;
DROP INDEX `name` ON `projects`;
DROP INDEX `pull_request_comments_ibfk_1` ON `pull_request_comments`;
DROP INDEX `pull_request_comments_ibfk_2` ON `pull_request_comments`;
DROP INDEX `pull_request_comments_ibfk_3` ON `pull_request_comments`;
DROP INDEX `pull_request_commits_ibfk_2` ON `pull_request_commits`;
DROP INDEX `pull_request_history_ibfk_1` ON `pull_request_history`;
DROP INDEX `pull_request_history_ibfk_2` ON `pull_request_history`;
DROP INDEX `pullreq_id` ON `pull_requests`;
DROP INDEX `pull_requests_ibfk_1` ON `pull_requests`;
DROP INDEX `pull_requests_ibfk_2` ON `pull_requests`;
DROP INDEX `pull_requests_ibfk_3` ON `pull_requests`;
DROP INDEX `pull_requests_ibfk_4` ON `pull_requests`;
DROP INDEX `repo_labels_ibfk_1` ON `repo_labels`;
DROP INDEX `repo_milestones_ibfk_1` ON `repo_milestones`;
DROP INDEX `login` ON `users`;
DROP INDEX `watchers_ibfk_2` ON `watchers`;

DROP TABLE `commit_comments`;
DROP TABLE `commit_parents`;
DROP TABLE `commits`;
DROP TABLE `followers`;
DROP TABLE `issue_comments`;
DROP TABLE `issue_events`;
DROP TABLE `issue_labels`;
DROP TABLE `issues`;
DROP TABLE `organization_members`;
DROP TABLE `project_commits`;
DROP TABLE `project_languages`;
DROP TABLE `project_members`;
DROP TABLE `project_topics`;
DROP TABLE `projects`;
DROP TABLE `pull_request_comments`;
DROP TABLE `pull_request_commits`;
DROP TABLE `pull_request_history`;
DROP TABLE `pull_requests`;
DROP TABLE `repo_labels`;
DROP TABLE `repo_milestones`;
DROP TABLE `schema_info`;
DROP TABLE `users`;
DROP TABLE `watchers`;

CREATE TABLE `commit_comments` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`commit_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`body` varchar(256) NULL DEFAULT NULL,
`line` int(11) NULL DEFAULT NULL,
`position` int(11) NULL DEFAULT NULL,
`comment_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `comment_id` (`comment_id` ASC) USING BTREE,
INDEX `commit_comments_ibfk_1` (`commit_id` ASC) USING BTREE,
INDEX `commit_comments_ibfk_2` (`user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 5952036
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `commit_parents` (
`commit_id` int(11) NOT NULL,
`parent_id` int(11) NOT NULL,
INDEX `commit_parents_ibfk_1` (`commit_id` ASC) USING BTREE,
INDEX `commit_parents_ibfk_2` (`parent_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `commits` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`sha` varchar(40) NULL DEFAULT NULL,
`author_id` int(11) NULL DEFAULT NULL,
`committer_id` int(11) NULL DEFAULT NULL,
`project_id` int(11) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `sha` (`sha` ASC) USING BTREE,
INDEX `commits_ibfk_1` (`author_id` ASC) USING BTREE,
INDEX `commits_ibfk_2` (`committer_id` ASC) USING BTREE,
INDEX `commits_ibfk_3` (`project_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 1182678117
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `followers` (
`follower_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`follower_id`, `user_id`) ,
INDEX `follower_fk2` (`user_id` ASC) USING BTREE,
INDEX `follower_id` (`follower_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `issue_comments` (
`issue_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`comment_id` mediumtext NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX `issue_comments_ibfk_1` (`issue_id` ASC) USING BTREE,
INDEX `issue_comments_ibfk_2` (`user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `issue_events` (
`event_id` mediumtext NOT NULL,
`issue_id` int(11) NOT NULL,
`actor_id` int(11) NOT NULL,
`action` varchar(255) NOT NULL,
`action_specific` varchar(50) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX `issue_events_ibfk_1` (`issue_id` ASC) USING BTREE,
INDEX `issue_events_ibfk_2` (`actor_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `issue_labels` (
`label_id` int(11) NOT NULL,
`issue_id` int(11) NOT NULL,
PRIMARY KEY (`issue_id`, `label_id`) ,
INDEX `issue_labels_ibfk_1` (`label_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `issues` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`repo_id` int(11) NULL DEFAULT NULL,
`reporter_id` int(11) NULL DEFAULT NULL,
`assignee_id` int(11) NULL DEFAULT NULL,
`pull_request` tinyint(1) NOT NULL,
`pull_request_id` int(11) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`issue_id` int(11) NOT NULL,
PRIMARY KEY (`id`) ,
INDEX `issues_ibfk_1` (`repo_id` ASC) USING BTREE,
INDEX `issues_ibfk_2` (`reporter_id` ASC) USING BTREE,
INDEX `issues_ibfk_3` (`assignee_id` ASC) USING BTREE,
INDEX `issues_ibfk_4` (`pull_request_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 87987040
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `organization_members` (
`org_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`org_id`, `user_id`) ,
INDEX `organization_members_ibfk_2` (`user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `project_commits` (
`project_id` int(11) NOT NULL DEFAULT 0,
`commit_id` int(11) NOT NULL DEFAULT 0,
INDEX `project_commits_ibfk_1` (`project_id` ASC) USING BTREE,
INDEX `commit_id` (`commit_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `project_languages` (
`project_id` int(11) NOT NULL,
`language` varchar(255) NULL DEFAULT NULL,
`bytes` int(11) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX `project_id` (`project_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `project_members` (
`repo_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`ext_ref_id` varchar(24) NOT NULL DEFAULT '0',
PRIMARY KEY (`repo_id`, `user_id`) ,
INDEX `project_members_ibfk_2` (`user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `project_topics` (
`project_id` int(11) NOT NULL,
`topic_name` varchar(255) NOT NULL DEFAULT '',
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`deleted` tinyint(1) NOT NULL DEFAULT 0,
PRIMARY KEY (`project_id`, `topic_name`) 
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `projects` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`url` varchar(255) NULL DEFAULT NULL,
`owner_id` int(11) NULL DEFAULT NULL,
`name` varchar(255) NOT NULL,
`description` varchar(255) NULL DEFAULT NULL,
`language` varchar(255) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`forked_from` int(11) NULL DEFAULT NULL,
`deleted` tinyint(1) NOT NULL DEFAULT 0,
`updated_at` timestamp NOT NULL DEFAULT '1970-01-01 01:00:01',
PRIMARY KEY (`id`) ,
INDEX `projects_ibfk_1` (`owner_id` ASC) USING BTREE,
INDEX `projects_ibfk_2` (`forked_from` ASC) USING BTREE,
INDEX `name` (`name` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 114811906
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `pull_request_comments` (
`pull_request_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`comment_id` mediumtext NOT NULL,
`position` int(11) NULL DEFAULT NULL,
`body` varchar(256) NULL DEFAULT NULL,
`commit_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX `pull_request_comments_ibfk_1` (`pull_request_id` ASC) USING BTREE,
INDEX `pull_request_comments_ibfk_2` (`user_id` ASC) USING BTREE,
INDEX `pull_request_comments_ibfk_3` (`commit_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `pull_request_commits` (
`pull_request_id` int(11) NOT NULL,
`commit_id` int(11) NOT NULL,
PRIMARY KEY (`pull_request_id`, `commit_id`) ,
INDEX `pull_request_commits_ibfk_2` (`commit_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `pull_request_history` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`pull_request_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`action` varchar(255) NOT NULL,
`actor_id` int(11) NULL DEFAULT NULL,
PRIMARY KEY (`id`) ,
INDEX `pull_request_history_ibfk_1` (`pull_request_id` ASC) USING BTREE,
INDEX `pull_request_history_ibfk_2` (`actor_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 126865248
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `pull_requests` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`head_repo_id` int(11) NULL DEFAULT NULL,
`base_repo_id` int(11) NOT NULL,
`head_commit_id` int(11) NULL DEFAULT NULL,
`base_commit_id` int(11) NOT NULL,
`pullreq_id` int(11) NOT NULL,
`intra_branch` tinyint(1) NOT NULL,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `pullreq_id` (`pullreq_id` ASC, `base_repo_id` ASC) USING BTREE,
INDEX `pull_requests_ibfk_1` (`head_repo_id` ASC) USING BTREE,
INDEX `pull_requests_ibfk_2` (`base_repo_id` ASC) USING BTREE,
INDEX `pull_requests_ibfk_3` (`head_commit_id` ASC) USING BTREE,
INDEX `pull_requests_ibfk_4` (`base_commit_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 48550421
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `repo_labels` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`repo_id` int(11) NULL DEFAULT NULL,
`name` varchar(24) NOT NULL,
PRIMARY KEY (`id`) ,
INDEX `repo_labels_ibfk_1` (`repo_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 299720027
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `repo_milestones` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`repo_id` int(11) NULL DEFAULT NULL,
`name` varchar(24) NOT NULL,
PRIMARY KEY (`id`) ,
INDEX `repo_milestones_ibfk_1` (`repo_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `schema_info` (
`version` int(11) NOT NULL DEFAULT 0
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
CREATE TABLE `users` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`login` varchar(255) NOT NULL,
`company` varchar(255) NULL DEFAULT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`type` varchar(255) NOT NULL DEFAULT 'USR',
`fake` tinyint(1) NOT NULL DEFAULT 0,
`deleted` tinyint(1) NOT NULL DEFAULT 0,
`long` decimal(11,8) NULL DEFAULT NULL,
`lat` decimal(10,8) NULL DEFAULT NULL,
`country_code` char(3) NULL DEFAULT NULL,
`state` varchar(255) NULL DEFAULT NULL,
`city` varchar(255) NULL DEFAULT NULL,
`location` varchar(255) NULL DEFAULT NULL,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `login` (`login` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 47149986
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = dynamic;
CREATE TABLE `watchers` (
`repo_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`repo_id`, `user_id`) ,
INDEX `watchers_ibfk_2` (`user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = fixed;
