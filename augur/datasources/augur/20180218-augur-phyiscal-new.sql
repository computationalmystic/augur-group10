ALTER TABLE "repos" DROP CONSTRAINT "fk_repos_repo_groups_1";
ALTER TABLE "contributors_aliases" DROP CONSTRAINT "fk_contributors_aliases_contributors_1";
ALTER TABLE "contributor_affiliations" DROP CONSTRAINT "fk_contributor_affiliations_contributors_1";
ALTER TABLE "project_commits" DROP CONSTRAINT "fk_project_commits_commits_1";
ALTER TABLE "project_commits" DROP CONSTRAINT "fk_project_commits_repos_1";
ALTER TABLE "repos_meta" DROP CONSTRAINT "fk_repos_meta_repos_1";
ALTER TABLE "repos_stats" DROP CONSTRAINT "fk_repos_stats_repos_1";
ALTER TABLE "commit_parents" DROP CONSTRAINT "fk_commit_parents_commits_1";
ALTER TABLE "commit_parents" DROP CONSTRAINT "fk_commit_parents_commits_2";
ALTER TABLE "commits" DROP CONSTRAINT "fk_commits_contributors_1";
ALTER TABLE "commits" DROP CONSTRAINT "fk_commits_contributors_2";
ALTER TABLE "commits" DROP CONSTRAINT "fk_commits_commit_comment_ref_1";
ALTER TABLE "commit_comment_ref" DROP CONSTRAINT "fk_commit_comment_ref_message_1";
ALTER TABLE "repo_groups" DROP CONSTRAINT "fk_repo_groups_repo_groups_list_serve_1";
ALTER TABLE "repo_groups_list_serve" DROP CONSTRAINT "fk_repo_groups_list_serve_message_1";
ALTER TABLE "platform" DROP CONSTRAINT "fk_platform_message_1";

DROP INDEX "domain,affiliation,start_date";
DROP INDEX "domain,active";
DROP INDEX "canonical,alias";
DROP INDEX "alias,active";
DROP INDEX "author_email,author_affiliation,author_date";
DROP INDEX "committer_email,committer_affiliation,committer_date";
DROP INDEX "repos_id,commit";
DROP INDEX "author_raw_email";
DROP INDEX "committer_raw_email";
DROP INDEX "author_affiliation";
DROP INDEX "committer_affiliation";
DROP INDEX "projects_id,affiliation_copy_1";
DROP INDEX "projects_id,email_copy_1";
DROP INDEX "projects_id,year,affiliation_copy_1";
DROP INDEX "projects_id,year,email_copy_1";
DROP INDEX "projects_id,affiliation_copy_2";
DROP INDEX "projects_id,email_copy_2";
DROP INDEX "projects_id,year,affiliation";
DROP INDEX "projects_id,year,email";
DROP INDEX "projects_id,affiliation";
DROP INDEX "projects_id,email";
DROP INDEX "repos_id,affiliation_copy_1";
DROP INDEX "repos_id,email_copy_1";
DROP INDEX "repos_id,year,affiliation_copy_1";
DROP INDEX "repos_id,year,email_copy_1";
DROP INDEX "repos_id,affiliation_copy_2";
DROP INDEX "repos_id,email_copy_2";
DROP INDEX "repos_id,year,affiliation";
DROP INDEX "repos_id,year,email";
DROP INDEX "repos_id,affiliation";
DROP INDEX "repos_id,email";
DROP INDEX "forked";
DROP INDEX "comment_id";
DROP INDEX "commit_comments_ibfk_1";
DROP INDEX "commit_comments_ibfk_2";
DROP INDEX "commit_parents_ibfk_1";
DROP INDEX "commit_parents_ibfk_2";
DROP INDEX "project_commits_ibfk_1";
DROP INDEX "commit_id";
DROP INDEX "login";

DROP TABLE "contributor_affiliations";
DROP TABLE "contributors_aliases";
DROP TABLE "commits";
DROP TABLE "repo_group_annual_dm";
DROP TABLE "repo_group_monthly_dm";
DROP TABLE "repo_group_weekly_dm";
DROP TABLE "repo_groups";
DROP TABLE "repo_annual_dm";
DROP TABLE "repo_monthly_dm";
DROP TABLE "repo_weekly_dm";
DROP TABLE "repos";
DROP TABLE "commit_comment_ref";
DROP TABLE "commit_parents";
DROP TABLE "project_commits";
DROP TABLE "contributors";
DROP TABLE "repos_meta";
DROP TABLE "repos_stats";
DROP TABLE "platform";
DROP TABLE "message";
DROP TABLE "repo_groups_list_serve";

CREATE TABLE "contributor_affiliations" (
"ght_cntrb_id" int4 NOT NULL,
"ca_id" int4 NOT NULL,
"ca_domain" varchar(64) NOT NULL,
"ca_affiliation" varchar(64) NOT NULL,
"ca_start_date" date NOT NULL DEFAULT '\'1970-01-01\'',
"ca_active" int2 NOT NULL DEFAULT 1,
"ca_last_modified" timestamp(0) NOT NULL DEFAULT 'current_timestamp(6)',
PRIMARY KEY ("ca_id", "ght_cntrb_id") 
)
WITHOUT OIDS;
CREATE UNIQUE INDEX "domain,affiliation,start_date" ON "contributor_affiliations" ("ca_domain" ASC, "ca_affiliation" ASC, "ca_start_date" ASC);
CREATE INDEX "domain,active" ON "contributor_affiliations" ("ca_domain" ASC, "ca_active" ASC);

CREATE TABLE "contributors_aliases" (
"ght_cntrb_id" int4 NOT NULL,
"cntrb_a_id" int4 NOT NULL,
"cntrb_canonical" varchar(128) NOT NULL,
"cntrb_alias" varchar(128) NOT NULL,
"cntrb_active" int2 NOT NULL DEFAULT 1,
"cntrb_last_modified" timestamp(0) NOT NULL DEFAULT 'current_timestamp(6)',
PRIMARY KEY ("ght_cntrb_id", "cntrb_a_id") 
)
WITHOUT OIDS;
CREATE UNIQUE INDEX "canonical,alias" ON "contributors_aliases" ("cntrb_canonical" ASC, "cntrb_alias" ASC);
CREATE INDEX "alias,active" ON "contributors_aliases" ("cntrb_alias" ASC, "cntrb_active" ASC);
COMMENT ON TABLE "contributors_aliases" IS 'An alias will need to be created for every contributor in this model, otherwise we will have to look in 2 places. ';

CREATE TABLE "commits" (
"cmt_id" int4 NOT NULL,
"repos_id" int4 NOT NULL,
"cmt_commit" varchar(40) NOT NULL,
"cmt_author_name" varchar(128) NOT NULL,
"cmt_author_raw_email" varchar(128) NOT NULL,
"cmt_author_email" varchar(128) NOT NULL,
"cmt_author_date" varchar(10) NOT NULL,
"cmt_author_affiliation" varchar(128) DEFAULT 'NULL',
"cmt_committer_name" varchar(128) NOT NULL,
"cmt_committer_raw_email" varchar(128) NOT NULL,
"cmt_committer_email" varchar(128) NOT NULL,
"cmt_committer_date" varchar(10) NOT NULL,
"cmt_committer_affiliation" varchar(128) DEFAULT 'NULL',
"cmt_added" int4 NOT NULL,
"cmt_removed" int4 NOT NULL,
"cmt_whitespace" int4 NOT NULL,
"cmt_filename" varchar(4096) NOT NULL,
"cmt_date_attempted" timestamp(0) NOT NULL DEFAULT 'current_timestamp(6)',
"cmt_ght_author_id" int4,
"cmt_ght_committer_id" int4,
"cmt_ght_committed_at" timestamp(255),
PRIMARY KEY ("cmt_id") 
)
WITHOUT OIDS;
CREATE INDEX "author_email,author_affiliation,author_date" ON "commits" ("cmt_author_email" ASC, "cmt_author_affiliation" ASC, "cmt_author_date" ASC);
CREATE INDEX "committer_email,committer_affiliation,committer_date" ON "commits" ("cmt_committer_email" ASC, "cmt_committer_affiliation" ASC, "cmt_committer_date" ASC);
CREATE INDEX "repos_id,commit" ON "commits" ("repos_id" ASC, "cmt_commit" ASC);
CREATE INDEX "author_raw_email" ON "commits" ("cmt_author_raw_email" ASC);
CREATE INDEX "committer_raw_email" ON "commits" ("cmt_committer_raw_email" ASC);
CREATE INDEX "author_affiliation" ON "commits" ("cmt_author_affiliation" ASC);
CREATE INDEX "committer_affiliation" ON "commits" ("cmt_committer_affiliation" ASC);
COMMENT ON TABLE "commits" IS 'Starts with augur.analysis_data table and incorporates GHTorrent commit table attributes if different. 
Cmt_id is from get
The author and committer ID’s are at the bottom of the table and not required for now because we want to focus on the facade schema’s properties over the ghtorrent properties when they are in conflict. ';

CREATE TABLE "repo_group_annual_dm" (
"projects_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "projects_id,affiliation_copy_1" ON "repo_group_annual_dm" ("projects_id" ASC, "affiliation" ASC);
CREATE INDEX "projects_id,email_copy_1" ON "repo_group_annual_dm" ("projects_id" ASC, "email" ASC);

CREATE TABLE "repo_group_monthly_dm" (
"projects_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"month" int2 NOT NULL,
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "projects_id,year,affiliation_copy_1" ON "repo_group_monthly_dm" ("projects_id" ASC, "year" ASC, "affiliation" ASC);
CREATE INDEX "projects_id,year,email_copy_1" ON "repo_group_monthly_dm" ("projects_id" ASC, "year" ASC, "email" ASC);
CREATE INDEX "projects_id,affiliation_copy_2" ON "repo_group_monthly_dm" ("projects_id" ASC, "affiliation" ASC);
CREATE INDEX "projects_id,email_copy_2" ON "repo_group_monthly_dm" ("projects_id" ASC, "email" ASC);

CREATE TABLE "repo_group_weekly_dm" (
"projects_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"week" int2 NOT NULL,
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "projects_id,year,affiliation" ON "repo_group_weekly_dm" ("projects_id" ASC, "year" ASC, "affiliation" ASC);
CREATE INDEX "projects_id,year,email" ON "repo_group_weekly_dm" ("projects_id" ASC, "year" ASC, "email" ASC);
CREATE INDEX "projects_id,affiliation" ON "repo_group_weekly_dm" ("projects_id" ASC, "affiliation" ASC);
CREATE INDEX "projects_id,email" ON "repo_group_weekly_dm" ("projects_id" ASC, "email" ASC);

CREATE TABLE "repo_groups" (
"repos_group_id" int4 NOT NULL,
"rg_name" varchar(128) NOT NULL,
"rg_description" varchar(256) DEFAULT 'NULL',
"rg_website" varchar(128) DEFAULT 'NULL',
"rg_recache" int2 DEFAULT 1,
"rg_last_modified" timestamp(0) NOT NULL DEFAULT 'current_timestamp(6)',
PRIMARY KEY ("repos_group_id") 
)
WITHOUT OIDS;
CREATE TABLE "repo_annual_dm" (
"repos_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "repos_id,affiliation_copy_1" ON "repo_annual_dm" ("repos_id" ASC, "affiliation" ASC);
CREATE INDEX "repos_id,email_copy_1" ON "repo_annual_dm" ("repos_id" ASC, "email" ASC);

CREATE TABLE "repo_monthly_dm" (
"repos_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"month" int2 NOT NULL,
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "repos_id,year,affiliation_copy_1" ON "repo_monthly_dm" ("repos_id" ASC, "year" ASC, "affiliation" ASC);
CREATE INDEX "repos_id,year,email_copy_1" ON "repo_monthly_dm" ("repos_id" ASC, "year" ASC, "email" ASC);
CREATE INDEX "repos_id,affiliation_copy_2" ON "repo_monthly_dm" ("repos_id" ASC, "affiliation" ASC);
CREATE INDEX "repos_id,email_copy_2" ON "repo_monthly_dm" ("repos_id" ASC, "email" ASC);

CREATE TABLE "repo_weekly_dm" (
"repos_id" int4 NOT NULL,
"email" varchar(128) NOT NULL,
"affiliation" varchar(128) DEFAULT 'NULL',
"week" int2 NOT NULL,
"year" int2 NOT NULL,
"added" int8 NOT NULL,
"removed" int8 NOT NULL,
"whitespace" int8 NOT NULL,
"files" int8 NOT NULL,
"patches" int8 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "repos_id,year,affiliation" ON "repo_weekly_dm" ("repos_id" ASC, "year" ASC, "affiliation" ASC);
CREATE INDEX "repos_id,year,email" ON "repo_weekly_dm" ("repos_id" ASC, "year" ASC, "email" ASC);
CREATE INDEX "repos_id,affiliation" ON "repo_weekly_dm" ("repos_id" ASC, "affiliation" ASC);
CREATE INDEX "repos_id,email" ON "repo_weekly_dm" ("repos_id" ASC, "email" ASC);

CREATE TABLE "repos" (
"repos_id" int4 NOT NULL,
"repo_group_id" int4 NOT NULL,
"repo_git" varchar(256) NOT NULL,
"repo_path" varchar(256) DEFAULT 'NULL',
"repo_name" varchar(256) DEFAULT 'NULL',
"repo_added" timestamp(0) NOT NULL DEFAULT 'current_timestamp(6)',
"repo_status" varchar(32) NOT NULL,
"ght_url" varchar(255),
"ght_owner_id" int4,
"ght_description" varchar(255),
"ght_language" varchar(255),
"ght_created_at" varchar(255),
"ght_forked_from" int4,
"ght_deleted" int2,
"ght_updated_at" timestamp(0),
PRIMARY KEY ("repos_id") 
)
WITHOUT OIDS;
CREATE INDEX "forked" ON "repos" USING btree ("ght_forked_from" ASC);
COMMENT ON TABLE "repos" IS 'This table is a combination of the columns in Facade’s repos table and GHTorrent’s projects table. ';

CREATE TABLE "commit_comment_ref" (
"ght_comment_id" int4 NOT NULL,
"cmt_id" int4 NOT NULL,
"msg_id" int4 NOT NULL,
"user_id" int4 NOT NULL,
"body" varchar(256) DEFAULT NULL,
"line" int4 DEFAULT NULL,
"position" int4 DEFAULT NULL,
"comment_id" int4 NOT NULL,
"created_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY ("ght_comment_id") 
)
WITHOUT OIDS;
CREATE INDEX "comment_id" ON "commit_comment_ref" USING btree ("comment_id" ASC);
CREATE INDEX "commit_comments_ibfk_1" ON "commit_comment_ref" USING btree ("cmt_id" ASC);
CREATE INDEX "commit_comments_ibfk_2" ON "commit_comment_ref" USING btree ("user_id" ASC);

CREATE TABLE "commit_parents" (
"cmt_id" int4 NOT NULL,
"parent_id" int4 NOT NULL
)
WITHOUT OIDS;
CREATE INDEX "commit_parents_ibfk_1" ON "commit_parents" USING btree ("cmt_id" ASC);
CREATE INDEX "commit_parents_ibfk_2" ON "commit_parents" USING btree ("parent_id" ASC);

CREATE TABLE "project_commits" (
"repos_id" int4 NOT NULL DEFAULT 0,
"cmt_id" int4 NOT NULL DEFAULT 0
)
WITHOUT OIDS;
CREATE INDEX "project_commits_ibfk_1" ON "project_commits" USING btree ("repos_id" ASC);
CREATE INDEX "commit_id" ON "project_commits" USING btree ("cmt_id" ASC);

CREATE TABLE "contributors" (
"ght_cntrb_id" int4 NOT NULL,
"ght_cntrb_login" varchar(255) NOT NULL,
"ght_cntrb_company" varchar(255) DEFAULT NULL,
"ght_cntrb_created_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
"ght_cntrb_type" varchar(255) NOT NULL DEFAULT 'USR',
"ght_cntrb_fake" int2 NOT NULL DEFAULT 0,
"ght_cntrb_deleted" int2 NOT NULL DEFAULT 0,
"ght_cntrb_long" numeric(11,8) DEFAULT NULL,
"ght_cntrb_lat" numeric(10,8) DEFAULT NULL,
"ght_cntrb_country_code" char(3) DEFAULT NULL,
"ght_cntrb_state" varchar(255) DEFAULT NULL,
"ght_cntrb_city" varchar(255) DEFAULT NULL,
"ght_cntrb_location" varchar(255) DEFAULT NULL,
"cntrb_canonical" varchar(128),
PRIMARY KEY ("ght_cntrb_id") 
)
WITHOUT OIDS;
CREATE INDEX "login" ON "contributors" USING btree ("ght_cntrb_login" ASC);

CREATE TABLE "repos_meta" (
"repo_id" int4 NOT NULL,
"rmeta_id" int4 NOT NULL,
"rmeta_name" varchar(255),
"rmeta_value" varchar(255) DEFAULT 0,
PRIMARY KEY ("rmeta_id", "repo_id") 
)
WITHOUT OIDS;
COMMENT ON TABLE "repos_meta" IS 'Project Languages';

CREATE TABLE "repos_stats" (
"repo_id" int4 NOT NULL,
"rstat_id" int4 NOT NULL,
"rstat_name" varchar(255),
"rstat_value" int8,
PRIMARY KEY ("rstat_id", "repo_id") 
)
WITHOUT OIDS;
COMMENT ON TABLE "repos_stats" IS 'Project Watchers';

CREATE TABLE "platform" (
"pltfrm_id" int4 NOT NULL,
"pltfrm_name" varchar(255),
"pltfrm_version" varchar(255),
"pltfrm_release_date" date,
PRIMARY KEY ("pltfrm_id") 
)
WITHOUT OIDS;
CREATE TABLE "message" (
"msg_id" int4 NOT NULL,
"msg_text" text,
"msg_timestamp" timestamp(0),
"msg_sender_email" varchar(255),
"msg_header" varchar(4000),
"rgls_id" int4,
"pltfrm_id" int4,
PRIMARY KEY ("msg_id") 
)
WITHOUT OIDS;
CREATE TABLE "repo_groups_list_serve" (
"rgls_id" int4 NOT NULL,
"repos_group_id" int4,
"rgls_name" varchar(255),
"rgls_description" varchar(3000),
"rgls_sponsor" varchar(255),
"rgls_email" varchar(255),
PRIMARY KEY ("rgls_id") 
)
WITHOUT OIDS;

ALTER TABLE "repos" ADD CONSTRAINT "fk_repos_repo_groups_1" FOREIGN KEY ("repo_group_id") REFERENCES "repo_groups" ("repos_group_id");
COMMENT ON CONSTRAINT "fk_repos_repo_groups_1" ON "repos" IS 'Repo_groups cardinality set to one and only one because, although in theory there could be more than one repo group for a repo, this might create dependecies in hosted situation that we do not want to live with. ';
ALTER TABLE "contributors_aliases" ADD CONSTRAINT "fk_contributors_aliases_contributors_1" FOREIGN KEY ("ght_cntrb_id") REFERENCES "contributors" ("ght_cntrb_id");
ALTER TABLE "contributor_affiliations" ADD CONSTRAINT "fk_contributor_affiliations_contributors_1" FOREIGN KEY ("ght_cntrb_id") REFERENCES "contributors" ("ght_cntrb_id");
ALTER TABLE "project_commits" ADD CONSTRAINT "fk_project_commits_commits_1" FOREIGN KEY ("cmt_id") REFERENCES "commits" ("cmt_id");
ALTER TABLE "project_commits" ADD CONSTRAINT "fk_project_commits_repos_1" FOREIGN KEY ("repos_id") REFERENCES "repos" ("repos_id");
ALTER TABLE "repos_meta" ADD CONSTRAINT "fk_repos_meta_repos_1" FOREIGN KEY ("repo_id") REFERENCES "repos" ("repos_id");
ALTER TABLE "repos_stats" ADD CONSTRAINT "fk_repos_stats_repos_1" FOREIGN KEY ("repo_id") REFERENCES "repos" ("repos_id");
ALTER TABLE "commit_parents" ADD CONSTRAINT "fk_commit_parents_commits_1" FOREIGN KEY ("cmt_id") REFERENCES "commits" ("cmt_id");
ALTER TABLE "commit_parents" ADD CONSTRAINT "fk_commit_parents_commits_2" FOREIGN KEY ("parent_id") REFERENCES "commits" ("cmt_id");
ALTER TABLE "commits" ADD CONSTRAINT "fk_commits_contributors_1" FOREIGN KEY ("cmt_ght_author_id") REFERENCES "contributors" ("ght_cntrb_id");
ALTER TABLE "commits" ADD CONSTRAINT "fk_commits_contributors_2" FOREIGN KEY ("cmt_ght_committer_id") REFERENCES "contributors" ("ght_cntrb_id");
ALTER TABLE "commits" ADD CONSTRAINT "fk_commits_commit_comment_ref_1" FOREIGN KEY ("cmt_id") REFERENCES "commit_comment_ref" ("cmt_id");
ALTER TABLE "commit_comment_ref" ADD CONSTRAINT "fk_commit_comment_ref_message_1" FOREIGN KEY ("msg_id") REFERENCES "message" ("msg_id");
ALTER TABLE "repo_groups" ADD CONSTRAINT "fk_repo_groups_repo_groups_list_serve_1" FOREIGN KEY ("repos_group_id") REFERENCES "repo_groups_list_serve" ("repos_group_id");
ALTER TABLE "repo_groups_list_serve" ADD CONSTRAINT "fk_repo_groups_list_serve_message_1" FOREIGN KEY ("rgls_id") REFERENCES "message" ("rgls_id");
ALTER TABLE "platform" ADD CONSTRAINT "fk_platform_message_1" FOREIGN KEY ("pltfrm_id") REFERENCES "message" ("pltfrm_id");

