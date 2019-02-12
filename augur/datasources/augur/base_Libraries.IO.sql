DROP INDEX `REPO_DEP` ON `repository_dependencies`;
DROP INDEX `REPO_MAN` ON `repository_dependencies`;

DROP TABLE `dependencies`;
DROP TABLE `GH_Matcher`;
DROP TABLE `projects`;
DROP TABLE `projects_with_repository_fields`;
DROP TABLE `repositories`;
DROP TABLE `repository_dependencies`;
DROP TABLE `tags`;
DROP TABLE `versions`;

CREATE TABLE `dependencies` (
`ID` int(11) NOT NULL DEFAULT 0,
`Platform` varchar(255) NULL DEFAULT NULL,
`Project Name` varchar(255) NULL DEFAULT NULL,
`Project ID` int(11) NULL DEFAULT NULL,
`Version Number` varchar(255) NULL DEFAULT NULL,
`Version ID` int(11) NULL DEFAULT NULL,
`Dependency Name` varchar(1000) NULL DEFAULT NULL,
`Dependency Platform` varchar(255) NULL DEFAULT NULL,
`Dependency Kind` varchar(1000) NULL DEFAULT NULL,
`Optional Dependency` varchar(255) NULL DEFAULT NULL,
`Dependency Requirements` varchar(255) NULL DEFAULT NULL,
`Dependency Project ID` varchar(255) NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
CREATE TABLE `GH_Matcher` (
`Repository URL` varchar(1000) CHARACTER SET latin1 NULL DEFAULT NULL,
`ownerrepo` text CHARACTER SET latin1 NULL
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
CREATE TABLE `projects` (
`ID` int(11) NOT NULL DEFAULT 0,
`Platform` varchar(255) NULL DEFAULT NULL,
`Name` varchar(255) NULL DEFAULT NULL,
`Created Timestamp` datetime NULL DEFAULT NULL,
`Updated Timestamp` datetime NULL DEFAULT NULL,
`Description` varchar(2000) NULL DEFAULT NULL,
`Keywords` varchar(255) NULL DEFAULT NULL,
`Homepage URL` varchar(1000) NULL DEFAULT NULL,
`Licenses` varchar(255) NULL DEFAULT NULL,
`Repository URL` varchar(1000) NULL DEFAULT NULL,
`Versions Count` int(11) NULL DEFAULT NULL,
`SourceRank` int(11) NULL DEFAULT NULL,
`Latest Release Publish Timestamp` varchar(255) NULL DEFAULT NULL,
`Latest Release Number` varchar(255) NULL DEFAULT NULL,
`Package Manager ID` varchar(255) NULL DEFAULT NULL,
`Dependent Projects Count` int(11) NULL DEFAULT NULL,
`Language` varchar(255) NULL DEFAULT NULL,
`Status` varchar(255) NULL DEFAULT NULL,
`Last synced Timestamp` varchar(255) NULL DEFAULT NULL,
`Dependent Repositories Count` int(11) NULL DEFAULT NULL,
`Repository ID` varchar(255) NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
ROW_FORMAT = compact;
CREATE TABLE `projects_with_repository_fields` (
`ID` int(11) NOT NULL DEFAULT 0,
`Platform` varchar(255) NULL DEFAULT NULL,
`Name` varchar(255) NULL DEFAULT NULL,
`Created Timestamp` datetime NULL DEFAULT NULL,
`Updated Timestamp` datetime NULL DEFAULT NULL,
`Description` varchar(2000) NULL DEFAULT NULL,
`Keywords` varchar(255) NULL DEFAULT NULL,
`Homepage URL` varchar(1000) NULL DEFAULT NULL,
`Licenses` varchar(1000) NULL DEFAULT NULL,
`Repository URL` varchar(1000) NULL DEFAULT NULL,
`Versions Count` int(11) NULL DEFAULT NULL,
`SourceRank` int(11) NULL DEFAULT NULL,
`Latest Release Publish Timestamp` datetime NULL DEFAULT NULL,
`Latest Release Number` varchar(255) NULL DEFAULT NULL,
`Package Manager ID` varchar(255) NULL DEFAULT NULL,
`Dependent Projects Count` int(11) NULL DEFAULT NULL,
`Language` varchar(255) NULL DEFAULT NULL,
`Status` varchar(255) NULL DEFAULT NULL,
`Last synced Timestamp` datetime NULL DEFAULT NULL,
`Dependent Repositories Count` int(11) NULL DEFAULT NULL,
`Repository ID` varchar(255) NULL DEFAULT NULL,
`Repository Host Type` varchar(255) NULL DEFAULT NULL,
`Repository Name with Owner` varchar(255) NULL DEFAULT NULL,
`Repository Description` varchar(2000) NULL DEFAULT NULL,
`Repository Fork?` varchar(255) NULL DEFAULT NULL,
`Repository Created Timestamp` datetime NULL DEFAULT NULL,
`Repository Updated Timestamp` datetime NULL DEFAULT NULL,
`Repository Last pushed Timestamp` datetime NULL DEFAULT NULL,
`Repository Homepage URL` varchar(1000) NULL DEFAULT NULL,
`Repository Size` varchar(255) NULL DEFAULT NULL,
`Repository Stars Count` int(11) NULL DEFAULT NULL,
`Repository Language` varchar(255) NULL DEFAULT NULL,
`Repository Issues enabled?` varchar(255) NULL DEFAULT NULL,
`Repository Wiki enabled?` varchar(255) NULL DEFAULT NULL,
`Repository Pages enabled?` varchar(255) NULL DEFAULT NULL,
`Repository Forks Count` varchar(255) NULL DEFAULT NULL,
`Repository Mirror URL` varchar(255) NULL DEFAULT NULL,
`Repository Open Issues Count` int(11) NULL DEFAULT NULL,
`Repository Default branch` varchar(255) NULL DEFAULT NULL,
`Repository Watchers Count` int(11) NULL DEFAULT NULL,
`Repository UUID` varchar(255) NULL DEFAULT NULL,
`Repository Fork Source Name with Owner` varchar(1000) NULL DEFAULT NULL,
`Repository License` varchar(255) NULL DEFAULT NULL,
`Repository Contributors Count` int(11) NULL DEFAULT NULL,
`Repository Readme filename` varchar(255) NULL DEFAULT NULL,
`Repository Changelog filename` varchar(1000) NULL DEFAULT NULL,
`Repository Contributing guidelines filename` varchar(255) NULL DEFAULT NULL,
`Repository License filename` varchar(255) NULL DEFAULT NULL,
`Repository Code of Conduct filename` varchar(255) NULL DEFAULT NULL,
`Repository Security Threat Model filename` varchar(255) NULL DEFAULT NULL,
`Repository Security Audit filename` varchar(255) NULL DEFAULT NULL,
`Repository Status` varchar(255) NULL DEFAULT NULL,
`Repository Last Synced Timestamp` datetime NULL DEFAULT NULL,
`Repository SourceRank` varchar(255) NULL DEFAULT NULL,
`Repository Display Name` varchar(255) NULL DEFAULT NULL,
`Repository SCM type` varchar(255) NULL DEFAULT NULL,
`Repository Pull requests enabled?` varchar(255) NULL DEFAULT NULL,
`Repository Logo URL` varchar(1000) NULL DEFAULT NULL,
`Repository Keywords` varchar(255) NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
ROW_FORMAT = compact;
CREATE TABLE `repositories` (
`ID` int(11) NOT NULL DEFAULT 0,
`Host Type` varchar(255) NULL DEFAULT NULL,
`Name with Owner` varchar(1000) NULL DEFAULT NULL,
`Description` varchar(2000) NULL DEFAULT NULL,
`Fork` varchar(1000) NULL DEFAULT NULL,
`Created Timestamp` datetime NULL DEFAULT NULL,
`Updated Timestamp` datetime NULL DEFAULT NULL,
`Last pushed Timestamp` datetime NULL DEFAULT NULL,
`Homepage URL` varchar(1000) NULL DEFAULT NULL,
`Size` int(11) NULL DEFAULT NULL,
`Stars Count` int(11) NULL DEFAULT NULL,
`Language` varchar(255) NULL DEFAULT NULL,
`Issues enabled` varchar(255) NULL DEFAULT NULL,
`Wiki enabled` varchar(255) NULL DEFAULT NULL,
`Pages enabled` varchar(255) NULL DEFAULT NULL,
`Forks Count` int(11) NULL DEFAULT NULL,
`Mirror URL` varchar(255) NULL DEFAULT NULL,
`Open Issues Count` int(11) NULL DEFAULT NULL,
`Default branch` varchar(255) NULL DEFAULT NULL,
`Watchers Count` int(11) NULL DEFAULT NULL,
`UUID` int(11) NULL DEFAULT NULL,
`Fork Source Name with Owner` varchar(255) NULL DEFAULT NULL,
`License` varchar(255) NULL DEFAULT NULL,
`Contributors Count` int(11) NULL DEFAULT NULL,
`Readme filename` varchar(255) NULL DEFAULT NULL,
`Changelog filename` varchar(255) NULL DEFAULT NULL,
`Contributing guidelines filename` varchar(255) NULL DEFAULT NULL,
`License filename` varchar(255) NULL DEFAULT NULL,
`Code of Conduct filename` varchar(255) NULL DEFAULT NULL,
`Security Threat Model filename` varchar(255) NULL DEFAULT NULL,
`Security Audit filename` varchar(255) NULL DEFAULT NULL,
`Status` varchar(255) NULL DEFAULT NULL,
`Last Synced Timestamp` datetime NULL DEFAULT NULL,
`SourceRank` int(11) NULL DEFAULT NULL,
`Display Name` varchar(255) NULL DEFAULT NULL,
`SCM type` varchar(255) NULL DEFAULT NULL,
`Pull requests enabled` varchar(255) NULL DEFAULT NULL,
`Logo URL` varchar(255) NULL DEFAULT NULL,
`Keywords` varchar(255) NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
CREATE TABLE `repository_dependencies` (
`ID` int(11) NOT NULL DEFAULT 0,
`Host Type` varchar(255) NULL DEFAULT NULL,
`Repository Name with Owner` varchar(255) NULL DEFAULT NULL,
`Repository ID` int(11) NULL DEFAULT NULL,
`Manifest Platform` varchar(255) NULL DEFAULT NULL,
`Manifest Filepath` varchar(1000) NULL DEFAULT NULL,
`Git branch` varchar(255) NULL DEFAULT NULL,
`Manifest kind` varchar(255) NULL DEFAULT NULL,
`Optional` varchar(255) NULL DEFAULT NULL,
`Dependency Project Name` varchar(255) NULL DEFAULT NULL,
`Dependency Requirements` varchar(255) NULL DEFAULT NULL,
`Dependency Kind` varchar(255) NULL DEFAULT NULL,
`Dependency Project ID` int(11) NULL DEFAULT NULL,
PRIMARY KEY (`ID`) ,
INDEX `REPO_DEP` (`Repository Name with Owner` ASC) USING BTREE,
INDEX `REPO_MAN` (`Repository ID` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
CREATE TABLE `tags` (
`ID` int(11) NOT NULL DEFAULT 0,
`Host Type` varchar(255) NULL DEFAULT NULL,
`Repository Name with Owner` varchar(1000) NULL DEFAULT NULL,
`Repository ID` int(11) NULL DEFAULT NULL,
`Tag Name` varchar(255) NULL DEFAULT NULL,
`Tag git sha` varchar(1000) NULL DEFAULT NULL,
`Tag Published Timestamp` datetime NULL DEFAULT NULL,
`Tag Created Timestamp` datetime NULL DEFAULT NULL,
`Tag Updated Timestamp` datetime NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
CREATE TABLE `versions` (
`ID` int(11) NOT NULL DEFAULT 0,
`Platform` varchar(255) NULL DEFAULT NULL,
`Project Name` varchar(255) NULL DEFAULT NULL,
`Project ID` int(11) NULL DEFAULT NULL,
`Number` varchar(255) NULL DEFAULT NULL,
`Published Timestamp` datetime NULL DEFAULT NULL,
`Created Timestamp` datetime NULL DEFAULT NULL,
`Updated Timestamp` datetime NULL DEFAULT NULL,
PRIMARY KEY (`ID`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ROW_FORMAT = compact;
