SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema invviteme
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `invviteme` ;

-- -----------------------------------------------------
-- Schema invviteme
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `invviteme` DEFAULT CHARACTER SET utf8 ;
USE `invviteme` ;

-- -----------------------------------------------------
-- Table `invviteme`.`statustype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`statustype` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`statustype` (
  `id` INT NOT NULL,
  `description` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`users` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `lastName` VARCHAR(60) NOT NULL,
  `phoneNumber` VARCHAR(11) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `id_statustype` INT NOT NULL,
  `date_birthday` DATETIME NOT NULL,
  `date_updated` DATETIME NOT NULL,
  `admin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_status_type_idx` (`id_statustype` ASC),
  CONSTRAINT `fk_status_type`
    FOREIGN KEY (`id_statustype`)
    REFERENCES `invviteme`.`statustype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`socialtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`socialtype` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`socialtype` (
  `id` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`user_socialtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`user_socialtype` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`user_socialtype` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_socialtype` INT NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `date_updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_social_type_idx` (`id_user` ASC),
  INDEX `fk_socialtype_idx` (`id_socialtype` ASC),
  CONSTRAINT `fk_user_social_type`
    FOREIGN KEY (`id_user`)
    REFERENCES `invviteme`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_socialtype`
    FOREIGN KEY (`id_socialtype`)
    REFERENCES `invviteme`.`socialtype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`eventtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`eventtype` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`eventtype` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(60) NOT NULL,
  `id_statustype` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`eventtype_access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`eventtype_access` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`eventtype_access` (
  `id` INT NOT NULL,
  `type_access` VARCHAR(20) NOT NULL,  
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`state` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`state` (
  `id` INT NOT NULL,
  `statename` VARCHAR(45) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`address_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`address_event` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`address_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `placename` VARCHAR(80) NOT NULL,
  `streetname` VARCHAR(80) NOT NULL,
  `number` INT NOT NULL,
  `complement` VARCHAR(30) NULL,
  `zipcode` INT NOT NULL,
  `cityname` VARCHAR(60) NOT NULL,
  `longitude` VARCHAR(30) NOT NULL,
  `latitude` VARCHAR(30) NOT NULL,
  `id_state` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_state_address_idx` (`id_state` ASC),
  CONSTRAINT `fk_state_address`
    FOREIGN KEY (`id_state`)
    REFERENCES `invviteme`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`event` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `id_eventtype_access` INT NOT NULL,
  `id_eventtype` INT NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `observation` VARCHAR(500) NOT NULL,
  `event_for_free` TINYINT(1) NOT NULL,
  `can_sendInvite_external` TINYINT(1) NOT NULL,
  `hidden_event` TINYINT(1) NOT NULL,
  `eventdate` DATETIME NOT NULL,
  `event_init_hour` TIMESTAMP NOT NULL,
  `event_end_hour` TIMESTAMP NOT NULL,
  `minimum_age` INT NOT NULL,
  `limit_guests` INT NOT NULL,
  `id_address_event` INT NOT NULL,
  `id_statustype` INT NOT NULL,
  `date_updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_event_idx` (`id_owner` ASC),
  INDEX `fk_type_access_event_idx` (`id_eventtype_access` ASC),
  INDEX `fk_type_event_idx` (`id_eventtype` ASC),
  INDEX `fk_address_event_idx` (`id_address_event` ASC),
  INDEX `fk_status_type_idx` (`id_statustype` ASC),
  CONSTRAINT `fk_user_events`
    FOREIGN KEY (`id_owner`)
    REFERENCES `invviteme`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_access_events`
    FOREIGN KEY (`id_eventtype_access`)
    REFERENCES `invviteme`.`eventtype_access` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_events`
    FOREIGN KEY (`id_eventtype`)
    REFERENCES `invviteme`.`eventtype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_events`
    FOREIGN KEY (`id_address_event`)
    REFERENCES `invviteme`.`address_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_status_type`
    FOREIGN KEY (`id_statustype`)
    REFERENCES `invviteme`.`statustype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`guest_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`guest_event` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`guest_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_event` INT NOT NULL,
  `id_user` INT NOT NULL,
  `attendance_confirmed` TINYINT(1) NOT NULL,
  `time_sent_token` DATETIME NULL,
  `date_attendance_confirmed` TIMESTAMP NULL,
  `token` VARCHAR(80) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_guest_idx` (`id_event` ASC),
  INDEX `fk_user_guet_idx` (`id_user` ASC),
  CONSTRAINT `fk_event_guest`
    FOREIGN KEY (`id_event`)
    REFERENCES `invviteme`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_guest`
    FOREIGN KEY (`id_user`)
    REFERENCES `invviteme`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invviteme`.`user_guest_unified`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invviteme`.`user_guest_unified` ;

CREATE TABLE IF NOT EXISTS `invviteme`.`user_guest_unified` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_event` INT NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_guest_unified_idx` (`id_user` ASC),
  INDEX `fk_event_guest_unified_idx` (`id_event` ASC),
  CONSTRAINT `fk_user_guest_unified`
    FOREIGN KEY (`id_user`)
    REFERENCES `invviteme`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_guest_unified`
    FOREIGN KEY (`id_event`)
    REFERENCES `invviteme`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(1,'Ativo');
INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(2,'Cancelado');
INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(3,'Bloqueado');
INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(4,'Finalizado');
INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(5,'Pendente');
INSERT INTO `invviteme`.`statustype`(`id`,`description`) VALUES(6,'Desativado');

INSERT INTO `invviteme`.`socialtype`(`id`,`name`) VALUES(1,'Facebook');
INSERT INTO `invviteme`.`socialtype`(`id`,`name`) VALUES(2,'Twitter');
INSERT INTO `invviteme`.`socialtype`(`id`,`name`) VALUES(3,'Google+');

INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Congresso, seminário', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Curso, workshop', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Encontro, networking', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Esportivo', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Feira, exposição', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Filme, cinema, teatro', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Gastronômico', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Religioso, espiritual', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Show, música, festa', 1);
INSERT INTO `invviteme`.`eventtype`(`category`,`id_statustype`) VALUES('Outros eventos', 1);

INSERT INTO `invviteme`.`eventtype_access`(`id`,`type_access`) VALUES(1,'Público');
INSERT INTO `invviteme`.`eventtype_access`(`id`,`type_access`) VALUES(2,'Privado');

INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(1,'Acre','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(2,'Alagoas','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(3,'Amapá','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(4,'Amazonas','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(5,'Bahia','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(6,'Ceará','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(7,'Distrito Federal','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(8,'Espírito Santo','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(9,'Goiás','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(10,'Maranhão','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(11,'Mato Grosso','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(12,'Mato Grosso do Sul','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(13,'Minas Gerais','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(14,'Pará','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(15,'Paraíba','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(16,'Paraná','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(17,'Pernambuco','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(18,'Piauí','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(19,'Rio de Janeiro','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(20,'Rio Grande do Norte','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(21,'Rio Grande do Sul','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(22,'Rondônia','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(23,'Roraima','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(24,'Santa Catarina','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(25,'São Paulo','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(26,'Sergipe','Brasil');
INSERT INTO `invviteme`.`state`(`id`,`statename`,`country`) VALUES(27,'Tocantins','Brasil');