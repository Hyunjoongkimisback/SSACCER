-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ssaccer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssaccer
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ssaccer`;
CREATE SCHEMA IF NOT EXISTS `ssaccer` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema ssaccer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssaccer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssaccer` DEFAULT CHARACTER SET utf8 ;
USE `ssaccer` ;

-- -----------------------------------------------------
-- Table `ssaccer`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`users` (
  `userSeq` INT NOT NULL AUTO_INCREMENT,
  `userId` VARCHAR(20) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `role` VARCHAR(10) NOT NULL,
  `position` VARCHAR(10) NOT NULL,
  `phoneNumber` VARCHAR(50) NOT NULL,
  `img` VARCHAR(500) NULL,
  `orgimg` VARCHAR(500) NULL,
  PRIMARY KEY (`userSeq`),
  UNIQUE INDEX `user_seq_UNIQUE` (`userSeq` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`userId` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssaccer`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`articles` (
  `articleSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(5000) NOT NULL,
  `viewCnt` INT NOT NULL DEFAULT 0,
  `createdDate` TIMESTAMP NOT NULL,
  `modifiedDate` TIMESTAMP NOT NULL,
  `weather` VARCHAR(50) NOT NULL,
  `recruiteMax` INT NOT NULL,
  `place` VARCHAR(300) NOT NULL,
  `cost` INT NOT NULL DEFAULT 0,
  `matchstartdate` TIMESTAMP NOT NULL,
  `matchenddate` TIMESTAMP NOT NULL,
  `ability` VARCHAR(50) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `gender` VARCHAR(50) NOT NULL,
  `shower` VARCHAR(50) NOT NULL,
  `parking` VARCHAR(50) NOT NULL,
  `beverage` VARCHAR(50) NOT NULL,
  `rental` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`articleSeq`),
  UNIQUE INDEX `articleSeq_UNIQUE` (`articleSeq` ASC) VISIBLE,
  INDEX `fk_articles_userSeq_idx` (`userSeq` ASC) VISIBLE,
  CONSTRAINT `fk_articles_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`users` (`userSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssaccer`.`teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`teams` (
  `teamSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `articleSeq` INT NOT NULL,
  PRIMARY KEY (`teamSeq`),
  UNIQUE INDEX `teamSeq_UNIQUE` (`teamSeq` ASC) VISIBLE,
  INDEX `fk_teams_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_teams_articleSeq_idx` (`articleSeq` ASC) VISIBLE,
  CONSTRAINT `fk_teams_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`users` (`userSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teams_articleSeq`
    FOREIGN KEY (`articleSeq`)
    REFERENCES `ssaccer`.`articles` (`articleSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssaccer`.`koreasoccerfield`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `koreasoccerfield`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`koreasoccerfield` (
  `koreasoccerfieldSeq` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `grass` VARCHAR(45) NULL,
  PRIMARY KEY (`koreasoccerfieldSeq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssaccer`.`koreaxypoint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `koreaxypoint`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`koreaxypoint` (
  `koreaxypointSeq` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `town` VARCHAR(45) NULL,
  `x` INT NOT NULL,
  `y` INT NOT NULL,
  PRIMARY KEY (`koreaxypointSeq`))
ENGINE = InnoDB;

USE `ssaccer` ;

-- -----------------------------------------------------
-- Table `ssaccer`.`videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`videos` (
  `videoSeq` INT NOT NULL AUTO_INCREMENT,
  `youtubeId` VARCHAR(50) NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `url` VARCHAR(500) NOT NULL,
  `channelName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`videoSeq`),
  UNIQUE INDEX `videoSeq_UNIQUE` (`videoSeq` ASC) VISIBLE,
  UNIQUE INDEX `youtubeId_UNIQUE` (`youtubeId` ASC) VISIBLE,
  UNIQUE INDEX `url_UNIQUE` (`url` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssaccer`.`videoreviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `videoreviews`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`videoreviews` (
  `videoreviewSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `videoSeq` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `viewCnt` INT NOT NULL DEFAULT '0',
  `createdDate` TIMESTAMP NOT NULL,
  `modifiedDate` TIMESTAMP NOT NULL,
  PRIMARY KEY (`videoreviewSeq`),
  UNIQUE INDEX `reviewSeq_UNIQUE` (`videoreviewSeq` ASC) VISIBLE,
  INDEX `fk_videoreviews_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_videoreviews_videoSeq_idx` (`videoSeq` ASC) VISIBLE,
  CONSTRAINT `fk_videoreviews_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`users` (`userSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videoreviews_videoSeq`
    FOREIGN KEY (`videoSeq`)
    REFERENCES `ssaccer`.`videos` (`videoSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssaccer`.`reviewlikes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reviewlikes`;
CREATE TABLE IF NOT EXISTS `ssaccer`.`reviewlikes` (
  `reviewlikeSeq` INT NOT NULL AUTO_INCREMENT,
  `userSeq` INT NOT NULL,
  `videoreviewSeq` INT NOT NULL,
  UNIQUE INDEX `reviewlikeSeq_UNIQUE` (`reviewlikeSeq` ASC) VISIBLE,
  INDEX `fk_reviewlikes_userSeq_idx` (`userSeq` ASC) VISIBLE,
  INDEX `fk_reviewlikes_videoreviewSeq_idx` (`videoreviewSeq` ASC) VISIBLE,
  CONSTRAINT `fk_reviewlikes_userSeq`
    FOREIGN KEY (`userSeq`)
    REFERENCES `ssaccer`.`users` (`userSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reviewlikes_videoreviewSeq`
    FOREIGN KEY (`videoreviewSeq`)
    REFERENCES `ssaccer`.`videoreviews` (`videoreviewSeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
