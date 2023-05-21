-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema ssaccer
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS `ssaccer`;
CREATE SCHEMA IF NOT EXISTS `ssaccer` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ;
USE `ssaccer` ;

-- -----------------------------------------------------
-- Table `ssaccer`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`Users` (
  `userSeq` INT NOT NULL AUTO_INCREMENT,
  `userId` VARCHAR(20) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `role` VARCHAR(10) NOT NULL DEFAULT 'UNRANKED',
  `position` VARCHAR(10) NOT NULL,
  `phoneNumber` VARCHAR(50) NOT NULL,
  `img` VARCHAR(500) NULL DEFAULT NULL,
  `orgimg` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`userSeq`),
  UNIQUE INDEX `userSeq_UNIQUE` (`userSeq` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`userId` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Articles`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`Articles` (
  `articleSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(5000) NOT NULL,
  `viewCnt` INT NOT NULL DEFAULT '0',
  `weather` VARCHAR(50) NOT NULL,
  `recruiteMax` INT NOT NULL,
  `place` VARCHAR(300) NOT NULL,
  `cost` INT NOT NULL DEFAULT '0',
  `ability` VARCHAR(50) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `gender` VARCHAR(50) NOT NULL,
  `shower` VARCHAR(50) NOT NULL,
  `parking` VARCHAR(50) NOT NULL,
  `beverage` VARCHAR(50) NOT NULL,
  `rental` VARCHAR(50) NOT NULL,
  `createdDate` TIMESTAMP NOT NULL,
  `matchstartdate` TIMESTAMP NOT NULL,
  `matchenddate` TIMESTAMP NOT NULL,
  PRIMARY KEY (`articleSeq`),
  UNIQUE INDEX `articleSeq_UNIQUE` (`articleSeq` ASC) VISIBLE,
  INDEX `fk_Articles_userSeq_idx` (`userSeq` ASC) VISIBLE,
  CONSTRAINT `fk_Articles_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`Users` (`userSeq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`SoccerFields`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `SoccerFields`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`SoccerFields` (
  `fieldSeq` INT NOT NULL AUTO_INCREMENT,
  `second` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `owner` VARCHAR(45) NULL DEFAULT NULL,
  `year` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`fieldSeq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`XYPoints`
-- -----------------------------------------------------
--  DROP TABLE IF EXISTS `XYPoints`; 
CREATE TABLE IF NOT EXISTS `ssaccer`.`XYPoints` (
  `pointSeq` INT NOT NULL AUTO_INCREMENT,
  `first` VARCHAR(45)  NULL,
  `second` VARCHAR(45) NULL DEFAULT NULL,
  `third` VARCHAR(45) NULL DEFAULT NULL,
  `x` INT NOT NULL,
  `y` INT NOT NULL,
  PRIMARY KEY (`pointSeq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Teams`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`Teams` (
  `teamSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `articleSeq` INT NOT NULL,
  PRIMARY KEY (`teamSeq`),
  UNIQUE INDEX `teamSeq_UNIQUE` (`teamSeq` ASC) VISIBLE,
  INDEX `fk_Teams_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_Teams_articleSeq_idx` (`articleSeq` ASC) VISIBLE,
  CONSTRAINT `fk_Teams_articleSeq`
    FOREIGN KEY (`articleSeq`)
    REFERENCES `ssaccer`.`articles` (`articleSeq`),
  CONSTRAINT `fk_Teams_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`Users` (`userSeq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`Videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Videos`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`Videos` (
  `videoSeq` INT NOT NULL AUTO_INCREMENT,
  `youtubeId` VARCHAR(100) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `url` VARCHAR(500) NOT NULL,
  `channelName` VARCHAR(100) NOT NULL,
  `thumbnail` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`videoSeq`),
  UNIQUE INDEX `videoSeq_UNIQUE` (`videoSeq` ASC) VISIBLE,
  UNIQUE INDEX `youtubeId_UNIQUE` (`youtubeId` ASC) VISIBLE,
  UNIQUE INDEX `url_UNIQUE` (`url` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`Reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Reviews`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`Reviews` (
  `reviewSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `videoSeq` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `writer` VARCHAR(30) NOT NULL,
  `viewCnt` INT NOT NULL DEFAULT '0',
  `createdDate` TIMESTAMP NOT NULL,
  PRIMARY KEY (`reviewSeq`),
  UNIQUE INDEX `reviewSeq_UNIQUE` (`reviewSeq` ASC) VISIBLE,
  INDEX `fk_videoreviews_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_videoreviews_videoSeq_idx` (`videoSeq` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`Users` (`userSeq`),
  CONSTRAINT `fk_Reviews_videoSeq`
    FOREIGN KEY (`videoSeq`)
    REFERENCES `ssaccer`.`Videos` (`videoSeq`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `ssaccer`.`RLikes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RLikes`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`RLikes` (
  `likeSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `reviewSeq` INT NOT NULL,
  UNIQUE INDEX `reviewlikeSeq_UNIQUE` (`likeSeq` ASC) VISIBLE,
  INDEX `fk_reviewlikes_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_reviewlikes_videoreviewSeq_idx` (`reviewSeq` ASC) VISIBLE,
  CONSTRAINT `fk_RLikes_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`Users` (`userSeq`),
  CONSTRAINT `fk_RLikes_reviewSeq`
    FOREIGN KEY (`reviewSeq`)
    REFERENCES `ssaccer`.`Reviews` (`reviewSeq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE utf8mb4_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- insert --
insert into users (userId, password, name, nickname, role, position, phoneNumber, img, orgimg)
VALUES("ssafy", "1234", "박세윤", "Yun", "ADMIN", "올라운더", "010-5183-2208", "img", "orimg");

create table `soccerxy` 
select p.second as ps, s.second as ss, p.x as x, p.y as y, s.name as name, s.year as year
from xypoints as p, soccerfields as s
where p.second = s.second
group by ps;
-- where p.second like s.second || '%';

-- drop table `soccerxy`; 

select * from videos;
select * from users;
select * from reviews;
select * from rlikes;	
select * from articles;
select * from teams;
select * from soccerfields;
select * from xypoints;
select * from soccerxy;

