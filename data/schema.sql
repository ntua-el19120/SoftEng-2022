SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Questionnaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questionnaire` (
  `questionnaire_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`questionnaire_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Question` (
  `question_id` INT(3) NOT NULL AUTO_INCREMENT,
  `question_text` VARCHAR(255) NOT NULL,
  `required` ENUM('True', 'False')  NULL DEFAULT 'True',
  `type` ENUM('question', 'profile') NULL DEFAULT 'question',
  `Questionnaire_questionnaire_id` INT NOT NULL,
  PRIMARY KEY (`question_id`, `Questionnaire_questionnaire_id`),
  -- INDEX `fk_Question_Questionnaire1_idx` (`Questionnaire_questionnaire_id` ASC) VISIBLE,
  CONSTRAINT `fk_Question_Questionnaire1`
    FOREIGN KEY (`Questionnaire_questionnaire_id`)
    REFERENCES `mydb`.`Questionnaire` (`questionnaire_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Option` (
  `option_id` INT(3) NOT NULL AUTO_INCREMENT,
  `option_text` VARCHAR(255) NULL,
  `Question_nextquestion_id` INT(3) NULL,
  `Question_Questionnaire_questionnaire_id1` INT NOT NULL,
  `Question_question_id` INT(3) NOT NULL,
  `Question_Questionnaire_questionnaire_id` INT NOT NULL,
  PRIMARY KEY (`option_id`, `Question_question_id`, `Question_Questionnaire_questionnaire_id`),
 -- INDEX `fk_Option_Question2_idx` (`Question_nextquestion_id` ASC, `Question_Questionnaire_questionnaire_id1` ASC) VISIBLE,
  -- INDEX `fk_Option_Question1_idx` (`Question_question_id` ASC, `Question_Questionnaire_questionnaire_id` ASC) VISIBLE,
  CONSTRAINT `fk_Option_Question2`
    FOREIGN KEY (`Question_nextquestion_id` , `Question_Questionnaire_questionnaire_id1`)
    REFERENCES `mydb`.`Question` (`question_id` , `Questionnaire_questionnaire_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Option_Question1`
    FOREIGN KEY (`Question_question_id` , `Question_Questionnaire_questionnaire_id`)
    REFERENCES `mydb`.`Question` (`question_id` , `Questionnaire_questionnaire_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Session` (
  `session_id` VARCHAR(4) NOT NULL,
  `Questionnaire_questionnaire_id` INT NOT NULL,
  PRIMARY KEY (`session_id`),
 -- INDEX `fk_Session_Questionnaire1_idx` (`Questionnaire_questionnaire_id` ASC) VISIBLE,
  CONSTRAINT `fk_Session_Questionnaire1`
    FOREIGN KEY (`Questionnaire_questionnaire_id`)
    REFERENCES `mydb`.`Questionnaire` (`questionnaire_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Answer` (
  `answer_id` INT(3) NOT NULL AUTO_INCREMENT,
  -- `answer_text` VARCHAR(255) NULL,
  `Option_option_id` INT(3) NOT NULL,
  `Option_questionnaire_id` INT(3) NOT NULL,
  `Option_question_id` INT(3) NOT NULL,
  `Session_session_id` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`answer_id`),
 -- INDEX `fk_Answer_Option1_idx` (`Option_option_id` ASC) VISIBLE,
 -- INDEX `fk_Answer_Session1_idx` (`Session_session_id` ASC) VISIBLE,
  CONSTRAINT `fk_Answer_Option1`
    FOREIGN KEY (`Option_option_id` )
    REFERENCES `mydb`.`Option` (`option_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Question1`
    FOREIGN KEY ( `Option_question_id` )
    REFERENCES `mydb`.`Question` ( `question_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Questionnaire1`
    FOREIGN KEY ( `Option_questionnaire_id` )
    REFERENCES `mydb`.`Questionnaire` (`questionnaire_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_Answer_Session1`
    FOREIGN KEY (`Session_session_id`)
    REFERENCES `mydb`.`Session` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- push comment
-- -----------------------------------------------------
-- Table `mydb`.`Keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Keyword` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `keyword_text` VARCHAR(45) NULL,
  `Questionnaire_questionnaire_id` INT NOT NULL,
  PRIMARY KEY (`keyword_id`),
--  INDEX `fk_Keyword_Questionnaire_idx` (`Questionnaire_questionnaire_id` ASC) VISIBLE,
  CONSTRAINT `fk_Keyword_Questionnaire`
    FOREIGN KEY (`Questionnaire_questionnaire_id`)
    REFERENCES `mydb`.`Questionnaire` (`questionnaire_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User` - FOR USER AUTHENTICATION
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `mydb`.`User` (
--   `username` VARCHAR(30) NOT NULL,
--   `password` VARCHAR(45) NOT NULL,
--   `admin` BIT NULL DEFAULT 0,
--   PRIMARY KEY (`username`))
-- ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
