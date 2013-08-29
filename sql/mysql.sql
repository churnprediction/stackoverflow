-- NOTE: jagat is replaced by the site name, e.g. 'so' or 'meta'
-- DROP SCHEMA IF EXISTS jagat ;
-- CREATE SCHEMA IF NOT EXISTS jagat DEFAULT CHARACTER SET latin1 ;
-- USE jagat;

--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`votetypes`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`votetypes` ;

CREATE  TABLE IF NOT EXISTS jagat.`votetypes` (
  `Id` INT(11) NOT NULL ,
  `Name` VARCHAR(40) CHARACTER SET 'utf8' NOT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`posttags`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`posttags` ;

CREATE  TABLE IF NOT EXISTS jagat.`posttags` (
  `PostId` INT(11) NOT NULL ,
  `Tag` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL 
    ,  PRIMARY KEY (`PostId`, `Tag`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`posttypes`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`posttypes` ;

CREATE  TABLE IF NOT EXISTS jagat.`posttypes` (
  `Id` INT(11) NOT NULL ,
  `Type` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;



INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(1, 'AcceptedByOriginator');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(2, 'UpMod');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(3, 'DownMod');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(4, 'Offensive');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(5, 'Favorite');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(6, 'Close');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(7, 'Reopen');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(8, 'BountyStart');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(9, 'BountyClose');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(10,'Deletion');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(11,'Undeletion');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(12,'Spam');
INSERT jagat.`votetypes` (`Id`, `Name`) VALUES(13,'InformModerator');
INSERT jagat.`posttypes` (`Id`, `Type`) VALUES(1, 'Question') ;
INSERT jagat.`posttypes` (`Id`, `Type`) VALUES(2, 'Answer') ;

--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`badges`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`badges` ;

CREATE  TABLE IF NOT EXISTS jagat.`badges` (
  `Id` INT(11) NOT NULL ,
  `Name` VARCHAR(40) CHARACTER SET 'utf8' NOT NULL ,
  `UserId` INT(11) NOT NULL ,
  `Date` DATETIME NOT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

--  INDICES CREATE INDEX `IX_Badges_Id_UserId` ON jagat.`badges` (`Id` ASC, `UserId` ASC) ;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`comments`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`comments` ;

CREATE  TABLE IF NOT EXISTS jagat.`comments` (
  `Id` INT(11) NOT NULL ,
  `CreationDate` DATETIME NOT NULL ,
  `PostId` INT(11) NOT NULL ,
  `Score` INT(11) NULL DEFAULT NULL ,
  `Text` TEXT CHARACTER SET 'utf8' NOT NULL ,
  `UserId` INT(11) NULL DEFAULT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

-- INDICES CREATE INDEX `IX_Comments_Id_PostId` ON jagat.`comments` (`Id` ASC, `PostId` ASC) ;
-- INDICES CREATE INDEX `IX_Comments_Id_UserId` ON jagat.`comments` (`Id` ASC, `UserId` ASC) ;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`posts`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`posts` ;

CREATE  TABLE IF NOT EXISTS jagat.`posts` (
  `Id` INT(11) NOT NULL ,
  `AcceptedAnswerId` INT(11) NULL DEFAULT NULL ,
  `AnswerCount` INT(11) NULL DEFAULT NULL ,
  `Body` LONGTEXT CHARACTER SET 'utf8' NOT NULL ,
  `ClosedDate` DATETIME NULL DEFAULT NULL ,
  `CommentCount` INT(11) NULL DEFAULT NULL ,
  `CommunityOwnedDate` DATETIME NULL DEFAULT NULL ,
  `CreationDate` DATETIME NOT NULL ,
  `FavoriteCount` INT(11) NULL DEFAULT NULL ,
  `LastActivityDate` DATETIME NOT NULL ,
  `LastEditDate` DATETIME NULL DEFAULT NULL ,
  `LastEditorDisplayName` VARCHAR(40) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `LastEditorUserId` INT(11) NULL DEFAULT NULL ,
  `OwnerUserId` INT(11) NULL DEFAULT NULL ,
  `ParentId` INT(11) NULL DEFAULT NULL ,
  `PostTypeId` INT(11) NOT NULL ,
  `Score` INT(11) NOT NULL ,
  `Tags` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `Title` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `ViewCount` INT(11) NOT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

update posts set answercount = 0 where posttypeid = 1 and answercount is null;

INDICES CREATE UNIQUE INDEX `IX_Posts_Id_AcceptedAnswerId` ON jagat.`posts` (`Id` ASC, `AcceptedAnswerId` ASC) ;
INDICES CREATE UNIQUE INDEX `IX_Posts_Id_OwnerUserId` ON jagat.`posts` (`Id` ASC, `OwnerUserId` ASC) ;
 INDICES CREATE UNIQUE INDEX `IX_Posts_Id_ParentId` ON jagat.`posts` (`Id` ASC, `ParentId` ASC) ;
INDICES CREATE INDEX `IX_Posts_Id_PostTypeId` ON jagat.`posts` (`Id` ASC, `PostTypeId` ASC) ;
INDICES CREATE INDEX `IX_Posts_PostType` ON jagat.`posts` (`PostTypeId` ASC) ;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`users`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`users` ;

CREATE  TABLE IF NOT EXISTS jagat.`users` (
  `Id` INT(11) NOT NULL ,
  `AboutMe` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `Age` INT(11) NULL DEFAULT NULL ,
  `CreationDate` DATETIME NOT NULL ,
  `DisplayName` VARCHAR(40) CHARACTER SET 'utf8' NOT NULL ,
  `DownVotes` INT(11) NOT NULL ,
  `EmailHash` VARCHAR(40) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `LastAccessDate` DATETIME NOT NULL ,
  `Location` VARCHAR(100) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
  `Reputation` INT(11) NOT NULL ,
  `UpVotes` INT(11) NOT NULL ,
  `Views` INT(11) NOT NULL ,
  `WebsiteUrl` VARCHAR(200) CHARACTER SET 'utf8' NULL DEFAULT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

-- INDICES CREATE INDEX `IX_Users_DisplayName` ON jagat.`users` (`DisplayName` ASC) ;


--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
--  Table jagat.`votes`
--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
DROP TABLE IF EXISTS jagat.`votes` ;

CREATE  TABLE IF NOT EXISTS jagat.`votes` (
  `Id` INT(11) NOT NULL ,
  `PostId` INT(11) NOT NULL ,
  `UserId` INT(11) NULL DEFAULT NULL ,
  `BountyAmount` INT(11) NULL DEFAULT NULL ,
  `VoteTypeId` INT(11) NOT NULL ,
  `CreationDate` DATETIME NOT NULL 
    ,  PRIMARY KEY (`Id`) 
  )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

 INDICES CREATE INDEX `IX_Votes_Id_PostId` ON jagat.`votes` (`Id` ASC, `PostId` ASC) ;
 INDICES CREATE INDEX `IX_Votes_VoteTypeId` ON jagat.`votes` (`VoteTypeId` ASC) ;



