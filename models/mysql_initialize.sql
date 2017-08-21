CREATE SCHEMA `activities` ;

CREATE TABLE `activities`.`users` (
  `id_user` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(140) NOT NULL,
  `displayName` VARCHAR(140) NULL,
  `passwordHash` VARCHAR(250) NOT NULL,
  `timestampe` DATETIME NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC));

CREATE TABLE `activities`.`tokens` (
  `id_token` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT UNSIGNED NOT NULL,
  `token` VARCHAR(250) NOT NULL,
  `timestampe` DATETIME NOT NULL DEFAULT current_timestamp(),
  `active` VARCHAR(140) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_token`),
  UNIQUE INDEX `id_token_UNIQUE` (`id_token` ASC),
  INDEX `id_user_token_FK_idx` (`id_user` ASC),
  CONSTRAINT `id_user_token_FK`
    FOREIGN KEY (`id_user`)
    REFERENCES `activities`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `activities`.`activities` (
  `id_act` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(140) NOT NULL,
  `type` VARCHAR(140) NULL,
  `id_user` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_act`),
  UNIQUE INDEX `id_act_UNIQUE` (`id_act` ASC),
  INDEX `user_act_FK_idx` (`id_user` ASC),
  CONSTRAINT `user_act_FK`
    FOREIGN KEY (`id_user`)
    REFERENCES `activities`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `activities`.`stats` (
  `id_stats` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT UNSIGNED NOT NULL,
  `id_act` INT UNSIGNED NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_stats`),
  UNIQUE INDEX `id_stats_UNIQUE` (`id_stats` ASC),
  INDEX `user_stat_FK_idx` (`id_user` ASC),
  INDEX `act_stat_FK_idx` (`id_user` ASC, `id_act` ASC),
  CONSTRAINT `user_stat_FK`
    FOREIGN KEY (`id_user`)
    REFERENCES `activities`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `act_stat_FK`
    FOREIGN KEY (`id_user` , `id_act`)
    REFERENCES `activities`.`activities` (`id_user` , `id_act`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
ALTER TABLE `activities`.`stats` 
ADD COLUMN `active` TINYINT NOT NULL DEFAULT 1 AFTER `timestamp`;