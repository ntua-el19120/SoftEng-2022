-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT ;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS ;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION ;
SET NAMES utf8mb4 ;
SET @OLD_TIME_ZONE=@@TIME_ZONE ;
SET TIME_ZONE='+00:00' ;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 ;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 ;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' ;
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 ;

--
-- Current Database: `mydb`
--

CREATE DATABASE IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

USE `mydb`;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `answer` (
  `answer_id` int(3) NOT NULL AUTO_INCREMENT,
  `answer_text` varchar(255) DEFAULT NULL,
  `Option_option_id` int(3) NOT NULL,
  `Option_questionnaire_id` int(3) NOT NULL,
  `Option_question_id` int(3) NOT NULL,
  `Session_session_id` varchar(4) NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `fk_Answer_Option1` (`Option_option_id`),
  KEY `fk_Answer_Question1` (`Option_question_id`),
  KEY `fk_Answer_Questionnaire1` (`Option_questionnaire_id`),
  KEY `fk_Answer_Session1` (`Session_session_id`),
  CONSTRAINT `fk_Answer_Option1` FOREIGN KEY (`Option_option_id`) REFERENCES `option` (`option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Question1` FOREIGN KEY (`Option_question_id`) REFERENCES `question` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Questionnaire1` FOREIGN KEY (`Option_questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Session1` FOREIGN KEY (`Session_session_id`) REFERENCES `session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
ALTER TABLE `answer` DISABLE KEYS ;
INSERT INTO `answer` VALUES (1,NULL,1,1,1,'aaaa'),(2,NULL,5,1,2,'aaaa'),(3,NULL,9,1,3,'aaaa'),(4,NULL,11,1,4,'aaaa'),(5,NULL,13,1,5,'aaaa'),(6,NULL,15,1,6,'aaaa'),(7,NULL,1,1,1,'aaab'),(8,NULL,5,1,2,'aaab'),(9,NULL,9,1,3,'aaab'),(10,NULL,11,1,4,'aaab'),(11,NULL,13,1,5,'aaab'),(12,NULL,17,1,6,'aaab'),(13,NULL,2,1,1,'aaac'),(14,NULL,6,1,2,'aaac'),(15,NULL,10,1,3,'aaac'),(16,NULL,22,1,8,'aaac'),(17,NULL,25,1,9,'aaac'),(18,NULL,28,1,10,'aaac'),(19,NULL,3,1,1,'aaad'),(20,NULL,7,1,2,'aaad'),(21,NULL,9,1,3,'aaad'),(22,NULL,11,1,4,'aaad'),(23,NULL,13,1,5,'aaad'),(24,NULL,16,1,6,'aaad'),(25,NULL,4,1,1,'aaae'),(26,NULL,8,1,2,'aaae'),(27,NULL,10,1,3,'aaae'),(28,NULL,23,1,8,'aaae'),(29,NULL,27,1,9,'aaae'),(30,NULL,30,1,10,'aaae'),(31,NULL,1,1,1,'aaaf'),(32,NULL,8,1,2,'aaaf'),(33,NULL,10,1,3,'aaaf'),(34,NULL,23,1,8,'aaaf'),(35,NULL,27,1,9,'aaaf'),(36,NULL,30,1,10,'aaaf'),(37,NULL,2,1,1,'aaag'),(38,NULL,6,1,2,'aaag'),(39,NULL,9,1,3,'aaag'),(40,NULL,11,1,4,'aaag'),(41,NULL,14,1,5,'aaag'),(42,NULL,19,1,7,'aaag'),(43,NULL,31,2,1,'aaah'),(44,NULL,37,2,2,'aaah'),(45,NULL,41,2,3,'aaah'),(46,NULL,48,2,6,'aaah'),(47,NULL,54,2,7,'aaah'),(48,NULL,57,2,8,'aaah'),(49,NULL,31,2,1,'aaai'),(50,NULL,35,2,2,'aaai'),(51,NULL,41,2,3,'aaai'),(52,NULL,48,2,6,'aaai'),(53,NULL,52,2,7,'aaai'),(54,NULL,57,2,8,'aaai'),(55,NULL,31,2,1,'aaaj'),(56,NULL,35,2,2,'aaaj'),(57,NULL,39,2,3,'aaaj'),(58,NULL,42,2,4,'aaaj'),(59,NULL,55,2,7,'aaaj'),(60,NULL,57,2,8,'aaaj'),(61,NULL,32,2,1,'aaak'),(62,NULL,37,2,2,'aaak'),(63,NULL,40,2,3,'aaak'),(64,NULL,45,2,5,'aaak'),(65,NULL,53,2,7,'aaak'),(66,NULL,56,2,8,'aaak'),(67,NULL,33,2,1,'aaal'),(68,NULL,36,2,2,'aaal'),(69,NULL,41,2,3,'aaal'),(70,NULL,51,2,6,'aaal'),(71,NULL,54,2,7,'aaal'),(72,NULL,57,2,8,'aaal'),(73,NULL,58,3,1,'aaam'),(74,NULL,52,3,2,'aaam'),(75,NULL,67,3,3,'aaam'),(76,NULL,73,3,5,'aaam'),(77,NULL,79,3,7,'aaam'),(78,NULL,83,3,8,'aaam'),(79,NULL,58,3,1,'aaan'),(80,NULL,62,3,2,'aaan'),(81,NULL,68,3,3,'aaan'),(82,NULL,75,3,6,'aaan'),(83,NULL,80,3,7,'aaan'),(84,NULL,83,3,8,'aaan'),(85,NULL,59,3,1,'aaao'),(86,NULL,63,3,2,'aaao'),(87,NULL,68,3,3,'aaao'),(88,NULL,78,3,6,'aaao'),(89,NULL,82,3,7,'aaao'),(90,NULL,83,3,8,'aaao'),(91,NULL,60,3,1,'aaap'),(92,NULL,62,3,2,'aaap'),(93,NULL,66,3,3,'aaap'),(94,NULL,70,3,4,'aaap'),(95,NULL,80,3,7,'aaap'),(96,NULL,84,3,8,'aaap'),(97,NULL,60,3,1,'aaaq'),(98,NULL,65,3,2,'aaaq'),(99,NULL,67,3,3,'aaaq'),(100,NULL,17,3,5,'aaaq'),(101,NULL,74,3,7,'aaaq'),(102,NULL,84,3,8,'aaaq'),(103,NULL,85,4,1,'aaba'),(104,NULL,89,4,2,'aaba'),(105,NULL,91,4,3,'aaba'),(106,NULL,96,4,4,'aaba'),(107,NULL,106,4,6,'aaba'),(108,NULL,108,4,7,'aaba'),(109,NULL,87,4,1,'aaca'),(110,NULL,88,4,2,'aaca'),(111,NULL,91,4,3,'aaca'),(112,NULL,96,4,4,'aaca'),(113,NULL,106,4,6,'aaca'),(114,NULL,107,4,7,'aaca'),(115,NULL,87,4,1,'aada'),(116,NULL,88,4,2,'aada'),(117,NULL,94,4,3,'aada'),(118,NULL,102,4,5,'aada'),(119,NULL,103,4,6,'aada'),(120,NULL,112,4,8,'aada'),(121,NULL,115,4,9,'aada'),(122,NULL,116,4,10,'aada'),(123,NULL,86,4,1,'aaea'),(124,NULL,89,4,2,'aaea'),(125,NULL,93,4,3,'aaea'),(126,NULL,100,4,5,'aaea'),(127,NULL,104,4,6,'aaea'),(128,NULL,110,4,8,'aaea'),(129,NULL,114,4,9,'aaea'),(130,NULL,85,4,1,'aafa'),(131,NULL,90,4,2,'aafa'),(132,NULL,93,4,3,'aafa'),(133,NULL,100,4,5,'aafa'),(134,NULL,104,4,6,'aafa'),(135,NULL,100,4,8,'aafa'),(136,NULL,115,4,9,'aafa'),(137,NULL,117,4,10,'aafa'),(138,NULL,112,5,1,'abaa'),(139,NULL,117,5,2,'abaa'),(140,NULL,118,5,3,'abaa'),(141,NULL,122,5,4,'abaa'),(142,NULL,137,5,7,'abaa'),(143,NULL,113,5,1,'acaa'),(144,NULL,117,5,2,'acaa'),(145,NULL,118,5,3,'acaa'),(146,NULL,122,5,4,'acaa'),(147,NULL,134,5,7,'acaa'),(148,NULL,113,5,1,'adaa'),(149,NULL,116,5,2,'adaa'),(150,NULL,119,5,3,'adaa'),(151,NULL,123,5,4,'adaa'),(152,NULL,129,5,5,'adaa'),(153,NULL,133,5,6,'adaa'),(154,NULL,135,5,7,'adaa'),(155,NULL,112,5,1,'aeaa'),(156,NULL,115,5,2,'aeaa'),(157,NULL,121,5,3,'aeaa'),(158,NULL,123,5,4,'aeaa'),(159,NULL,128,5,5,'aeaa'),(160,NULL,130,5,6,'aeaa'),(161,NULL,134,5,7,'acaa'),(162,NULL,114,5,1,'afaa'),(163,NULL,116,5,2,'afaa'),(164,NULL,120,5,3,'afaa'),(165,NULL,124,5,4,'afaa'),(166,NULL,128,5,5,'afaa'),(167,NULL,131,5,6,'afaa'),(168,NULL,136,5,7,'afaa');
ALTER TABLE `answer` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `keyword`
--

DROP TABLE IF EXISTS `keyword`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_text` varchar(45) DEFAULT NULL,
  `Questionnaire_questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  KEY `fk_Keyword_Questionnaire` (`Questionnaire_questionnaire_id`),
  CONSTRAINT `fk_Keyword_Questionnaire` FOREIGN KEY (`Questionnaire_questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `keyword`
--

LOCK TABLES `keyword` WRITE;
ALTER TABLE `keyword` DISABLE KEYS ;
INSERT INTO `keyword` VALUES (1,'seasons',1),(2,'islands',1),(3,'mountains',1),(4,'sports',1),(5,'gaming',2),(6,'Faker',2),(7,'Esports',2),(8,'player',2),(9,'electrical engineering',3),(10,'coding',3),(11,'EMP',3),(12,'depression',3),(13,'Breakfast',4),(14,'School',4),(15,'School',5),(16,'Friendship',5),(17,'Friends',5);
ALTER TABLE `keyword` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `option`
--

DROP TABLE IF EXISTS `option`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `option` (
  `option_id` int(3) NOT NULL AUTO_INCREMENT,
  `option_text` varchar(255) DEFAULT NULL,
  `Question_nextquestion_id` int(3) DEFAULT NULL,
  `Question_Questionnaire_questionnaire_id1` int(11) NOT NULL,
  `Question_question_id` int(3) NOT NULL,
  `Question_Questionnaire_questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`option_id`,`Question_question_id`,`Question_Questionnaire_questionnaire_id`),
  KEY `fk_Option_Question2` (`Question_nextquestion_id`,`Question_Questionnaire_questionnaire_id1`),
  KEY `fk_Option_Question1` (`Question_question_id`,`Question_Questionnaire_questionnaire_id`),
  CONSTRAINT `fk_Option_Question1` FOREIGN KEY (`Question_question_id`, `Question_Questionnaire_questionnaire_id`) REFERENCES `question` (`question_id`, `Questionnaire_questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Option_Question2` FOREIGN KEY (`Question_nextquestion_id`, `Question_Questionnaire_questionnaire_id1`) REFERENCES `question` (`question_id`, `Questionnaire_questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `option`
--

LOCK TABLES `option` WRITE;
ALTER TABLE `option` DISABLE KEYS ;
INSERT INTO `option` VALUES (1,'<30',2,1,1,1),(2,'30-50',2,1,1,1),(3,'50-70',2,1,1,1),(4,'>70',2,1,1,1),(5,'Autumn',3,1,2,1),(6,'Winter',3,1,2,1),(7,'Spring',3,1,2,1),(8,'Summer',3,1,2,1),(9,'Yes',4,1,3,1),(10,'No',8,1,3,1),(11,'Yes',5,1,4,1),(12,'No',8,1,4,1),(13,'Water Sports',6,1,5,1),(14,'Mountain Sports',7,1,5,1),(15,'Water Ski',NULL,1,6,1),(16,'Surfing',NULL,1,6,1),(17,'Diving',NULL,1,6,1),(18,'None really I just like water',NULL,1,6,1),(19,'Ski / Snowboard',NULL,1,7,1),(20,'Ice skating',NULL,1,7,1),(21,'None really I just like the cold',NULL,1,7,1),(22,'Gone to an island in the winter for vacations',9,1,8,1),(23,'Gone to mountain in the summer for vacations',9,1,8,1),(24,'None of the above',9,1,8,1),(25,'Corfu',10,1,9,1),(26,'Santorini',10,1,9,1),(27,'Rhodes',10,1,9,1),(28,'Parnassos',NULL,1,10,1),(29,'Alpes',NULL,1,10,1),(30,'Pindos',NULL,1,10,1),(31,'<30',2,2,1,2),(32,'30-50',2,2,1,2),(33,'50-70',2,2,1,2),(34,'>70',2,2,1,2),(35,'Once a week',3,2,2,2),(36,'3 times a week',3,2,2,2),(37,'Every day at least 30 minutes',3,2,2,2),(38,'Rarely, when i have nothing else to do',3,2,2,2),(39,'Rpg',4,2,3,2),(40,'First person shooter',5,2,3,2),(41,'PvP',6,2,3,2),(42,'Guild wars 2',7,2,4,2),(43,'World of Warcraft',7,2,4,2),(44,'Baldurs Gate',7,2,4,2),(45,'Call of duty',7,2,5,2),(46,'Titan Fall 2',7,2,5,2),(47,'Hitman',7,2,5,2),(48,'League of Legends',7,2,6,2),(49,'Valorant',7,2,6,2),(50,'Overwatch',7,2,6,2),(51,'Dota 2',7,2,6,2),(52,'Yes, I watch frequently my fave Team/Player.',8,2,7,2),(53,'Yes,but not so often.',8,2,7,2),(54,'No',8,2,7,2),(55,'My fave game doesnt host Esport matches',8,2,7,2),(56,'Solo',NULL,2,8,2),(57,'team ftw',NULL,2,8,2),(58,'<30',2,3,1,3),(59,'30-50',2,3,1,3),(60,'50-70',2,3,1,3),(61,'>70',2,3,1,3),(62,'1-2',3,3,2,3),(63,'3-4',3,3,2,3),(64,'5-6',3,3,2,3),(65,'< 6',3,3,2,3),(66,'Electrical Engineering',4,3,3,3),(67,'Computer Science',5,3,3,3),(68,'Computer Engineering',6,3,3,3),(69,'Electrical Engines',7,3,4,3),(70,'High Voltage',7,3,4,3),(71,'Electric Energy Systems',7,3,4,3),(72,'Algorithms',7,3,5,3),(73,'Discrete Math',7,3,5,3),(74,'Computability and Complexity',7,3,5,3),(75,'Software Engineering',7,3,6,3),(76,'Operating Systems',7,3,6,3),(77,'Databases',7,3,6,3),(78,'Microporcessors',7,3,6,3),(79,'Yes, a few.',8,3,7,3),(80,'Yes, but one.',8,3,7,3),(81,'No, Im not interested in anything else',8,3,7,3),(82,'No, I dont have much free time :(',8,3,7,3),(83,'Yes',NULL,3,8,3),(84,'No',NULL,3,8,3),(85,'7-8',2,4,1,4),(86,'9-10',2,4,1,4),(87,'11-12',2,4,1,4),(88,'Boy',3,4,2,4),(89,'Girl',3,4,2,4),(90,'Non binary',3,4,2,4),(91,'Every day',4,4,3,4),(92,'Often',4,4,3,4),(93,'Rarely',5,4,3,4),(94,'Never',5,4,3,4),(95,'Cereal',6,4,4,4),(96,'Fruit',6,4,4,4),(97,'Eggs',6,4,4,4),(98,'Bread with honey/jam',6,4,4,4),(99,'I dont like eating breakfast ',6,4,5,4),(100,'I dont have time in the morning to eat',6,4,5,4),(101,'I eat at school',6,4,5,4),(102,'Other reason',6,4,5,4),(103,'Every day',8,4,6,4),(104,'Often',8,4,6,4),(105,'Rarely',7,4,6,4),(106,'Never',7,4,6,4),(107,'I already eat at home',NULL,4,7,4),(108,'I dont like eating breakfast/ i dont like schools breakfast',NULL,4,7,4),(109,'My school doesnt provide breakfast',NULL,4,7,4),(110,'Every day',9,4,8,4),(111,'Often',9,4,8,4),(112,'Rarely',9,4,8,4),(113,'Never',9,4,8,4),(114,'homemade',NULL,4,9,4),(115,'prepared',10,4,9,4),(116,'Every day',NULL,4,10,4),(117,'1-2 times a week',NULL,4,10,4),(118,'3-4 times a week',NULL,4,10,4),(119,'Boy',2,5,1,5),(120,'Girl',2,5,1,5),(121,'Non binary',2,5,1,5),(122,'I have no friends',3,5,2,5),(123,'I have one good friend',3,5,2,5),(124,'I have many good friends',3,5,2,5),(125,'I have never stayed alone',4,5,3,5),(126,'only a few times',4,5,3,5),(127,'Once a week',4,5,3,5),(128,'at least 3 times a week',4,5,3,5),(129,'I have never had any bad experience at school',7,5,4,5),(130,'i only have a few bad experience at school',5,5,4,5),(131,'At least once a week',5,5,4,5),(132,'They have been racist to me',6,5,5,5),(133,'I have been physically abused',6,5,5,5),(134,'They have threaten me',6,5,5,5),(135,'They avoid me',6,5,5,5),(136,'They spread rumors about me',6,5,5,5),(137,'Anger',7,5,6,5),(138,'Sadness',7,5,6,5),(139,'Loneliness',7,5,6,5),(140,'Wanting revenge',7,5,6,5),(141,"I'm trying to help him.",NULL,5,7,5),(142,'Nothing, it is not my business.',NULL,5,7,5),(143,'Nothing, but i feel the guilt that I should help him',NULL,5,7,5),(144,'I laugh',NULL,5,7,5);
ALTER TABLE `option` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `question` (
  `question_id` int(3) NOT NULL AUTO_INCREMENT,
  `question_text` varchar(255) NOT NULL,
  `required` enum('True','False') DEFAULT 'True',
  `type` enum('question','profile') DEFAULT 'question',
  `Questionnaire_questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`question_id`,`Questionnaire_questionnaire_id`),
  KEY `fk_Question_Questionnaire1` (`Questionnaire_questionnaire_id`),
  CONSTRAINT `fk_Question_Questionnaire1` FOREIGN KEY (`Questionnaire_questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
ALTER TABLE `question` DISABLE KEYS ;
INSERT INTO `question` VALUES (1,'What is your age?','False','profile',1),(1,'What is your age?','True','profile',2),(1,'What is your age?','True','profile',3),(1,'What is your age?','True','profile',4),(1,'What is your sex?','True','profile',5),(2,'When do you prefer to go on vacation?','True','question',1),(2,'How often do you play your favorite pc game?','True','question',2),(2,'What is your current year at university?','True','question',3),(2,'What\'s your sex?;','True','profile',4),(2,'How many good friends do you have in class?','True','question',5),(3,'Do you change your destinations depending on the season?','True','question',1),(3,'What is your favorite type of game?','True','question',2),(3,'What is your favorite scientific area of this degree?','True','question',3),(3,'Do you eat breakfast at your home?','True','question',4),(3,'How often do you stay alone in school breaks?','True','question',5),(4,'Do you prefer to visit islands in the summer and mountains in the winter periods?','True','question',1),(4,'What is your favorite Rpg game?','True','question',2),(4,'What is your favorite course?','True','question',3),(4,'What do you prefer eating at home?','True','question',4),(4,'How often does someone in school behave bad to you?','True','question',5),(5,'Do you prefer water sports or mountain sports','True','question',1),(5,'What is your favorite FPS game?','True','question',2),(5,'What is your favorite course?','True','question',3),(5,'Why dont you eat often breakfast at your home?','True','question',4),(5,'In which way have your classmate bully you?','True','question',5),(6,'What is your favorite water sport?','True','question',1),(6,'What is your favorite PvP game?','True','question',2),(6,'What is your favorite course?','True','question',3),(6,'Do toy eat breakfast at your school?','True','question',4),(6,'What emotions did you felt at that moment?','True','question',5),(7,'What is your favorite Winter sport?','True','question',1),(7,'Do you enjoy watching Esports of your favorite game?','True','question',2),(7,'Do you have any other hobbies, that aren\'t related with your degree?','True','question',3),(7,'Why don\'t you eat breakfast at your school?','True','question',4),(7,'How do you act when a classmate of your is being bullied?','True','question',5),(8,'According to your previous answer have you:','True','question',1),(8,'Do you prefer solo or team gameplay?','True','question',2),(8,'Will you participate in an internship program?','True','question',3),(8,'Is your school\'s breakfast different every day?','True','question',4),(9,'Which of these islands would you prefer to visit in the winter?','True','question',1),(9,'Schools breakfast is usually:','True','question',4),(10,'Which of these mountains would you prefer to visit in the summer?','True','question',1),(10,'How many times a week does your school provide prepared food?','True','question',4);
ALTER TABLE `question` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `questionnaire` (
  `questionnaire_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`questionnaire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
ALTER TABLE `questionnaire` DISABLE KEYS ;
INSERT INTO `questionnaire` VALUES (1,'Vacations & Sports'),(2,'PC games and Esports'),(3,'SHMMY'),(4,'Breakfast'),(5,'Friendship at school');
 LTER TABLE `questionnaire` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `session` (
  `session_id` varchar(4) NOT NULL,
  `Questionnaire_questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `fk_Session_Questionnaire1` (`Questionnaire_questionnaire_id`),
  CONSTRAINT `fk_Session_Questionnaire1` FOREIGN KEY (`Questionnaire_questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
ALTER TABLE `session` DISABLE KEYS;
INSERT INTO `session` VALUES ('aaaa',1),('aaab',1),('aaac',1),('aaad',1),('aaae',1),('aaaf',1),('aaag',1),('aaah',2),('aaai',2),('aaaj',2),('aaak',2),('aaal',2),('aaam',3),('aaan',3),('aaao',3),('aaap',3),('aaaq',3),('aaba',4),('aaca',4),('aada',4),('aaea',4),('aafa',4),('abaa',5),('acaa',5),('adaa',5),('aeaa',5),('afaa',5);
ALTER TABLE `session` ENABLE KEYS;
UNLOCK TABLES;
SET TIME_ZONE=@OLD_TIME_ZONE;

SET SQL_MODE=@OLD_SQL_MODE ;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS ;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS ;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION ;
SET SQL_NOTES=@OLD_SQL_NOTES ;

-- Dump completed on 2023-02-12 23:43:57
