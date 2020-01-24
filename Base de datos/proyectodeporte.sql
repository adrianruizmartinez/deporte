-- MySQL Script generated by MySQL Workbench
-- Wed Jan 22 09:48:57 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto` DEFAULT CHARACTER SET utf8 ;
USE `proyecto` ;

-- -----------------------------------------------------
-- Table `proyecto`.`Jugador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Jugador` (
  `idjugador` INT NOT NULL AUTO_INCREMENT,
  `nombre_jug` VARCHAR(45) NULL,
  `apellido_jug` VARCHAR(45) NULL,
  `alias_jug` VARCHAR(22) NULL,
  `fechanac_jug` DATE NULL,
  `dni_jug` VARCHAR(10) NULL,
  `nacionalidad_jug` VARCHAR(30) NULL,
  PRIMARY KEY (`idjugador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Deporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Deporte` (
  `iddeporte` INT NOT NULL AUTO_INCREMENT,
  `nombre_deporte` VARCHAR(45) NULL,
  PRIMARY KEY (`iddeporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`pais` (
  `idpais` INT NOT NULL AUTO_INCREMENT,
  `nombre_pais` VARCHAR(45) NULL,
  PRIMARY KEY (`idpais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Equipo` (
  `idequipo` INT NOT NULL AUTO_INCREMENT,
  `deporte_iddeporte` INT NOT NULL,
  `nombre_eq` VARCHAR(45) NULL,
  `ciudad_eq` VARCHAR(45) NULL,
  `provincia_eq` VARCHAR(45) NULL,
  `idpais_eq` INT NOT NULL,
  PRIMARY KEY (`idequipo`),
  INDEX `fk_Equipos_Deporte1_idx` (`deporte_iddeporte` ASC),
  INDEX `fk_Equipo_país1_idx` (`idpais_eq` ASC),
  CONSTRAINT `fk_Equipos_Deporte1`
    FOREIGN KEY (`deporte_iddeporte`)
    REFERENCES `proyecto`.`Deporte` (`iddeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipo_país1`
    FOREIGN KEY (`idpais_eq`)
    REFERENCES `proyecto`.`pais` (`idpais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Estadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Estadio` (
  `idestadio` INT NOT NULL AUTO_INCREMENT,
  `nombre_estadio` VARCHAR(45) NULL,
  PRIMARY KEY (`idestadio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Temporada` (
  `idtemporada` INT NOT NULL AUTO_INCREMENT,
  `ano_principio` YEAR NULL,
  `ano_fin` YEAR NULL,
  PRIMARY KEY (`idtemporada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Calendario` (
  `idpartido` INT NOT NULL AUTO_INCREMENT,
  `fecha_cal` DATE NOT NULL,
  `local_cal` INT NOT NULL,
  `visitante_cal` INT NOT NULL,
  `jornada_cal` VARCHAR(4) NULL,
  `idestadio_cal` INT NOT NULL,
  `idtemporada_cal` INT NOT NULL,
  `goleslocal_cal` INT NULL DEFAULT NULL,
  `golesvisitante_cal` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idpartido`, `fecha_cal`),
  INDEX `fk_Partidos_Equipos1_idx` (`local_cal` ASC),
  INDEX `fk_Partidos_Equipos2_idx` (`visitante_cal` ASC),
  INDEX `fk_Partidos_Estadios1_idx` (`idestadio_cal` ASC),
  INDEX `fk_Calendario_Temporada1_idx` (`idtemporada_cal` ASC),
  CONSTRAINT `fk_Partidos_Equipos1`
    FOREIGN KEY (`local_cal`)
    REFERENCES `proyecto`.`Equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partidos_Equipos2`
    FOREIGN KEY (`visitante_cal`)
    REFERENCES `proyecto`.`Equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partidos_Estadios1`
    FOREIGN KEY (`idestadio_cal`)
    REFERENCES `proyecto`.`Estadio` (`idestadio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calendario_Temporada1`
    FOREIGN KEY (`idtemporada_cal`)
    REFERENCES `proyecto`.`Temporada` (`idtemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Tipo_arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Tipo_arbitro` (
  `idtarbitro` INT NOT NULL AUTO_INCREMENT,
  `iddeporte_tarb` INT NOT NULL,
  `nombre_tarb` VARCHAR(45) NULL,
  PRIMARY KEY (`idtarbitro`, `iddeporte_tarb`),
  INDEX `fk_Tipo_arbitro_Deporte1_idx` (`iddeporte_tarb` ASC),
  CONSTRAINT `fk_Tipo_arbitro_Deporte1`
    FOREIGN KEY (`iddeporte_tarb`)
    REFERENCES `proyecto`.`Deporte` (`iddeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Arbitro` (
  `idarbitro` INT NOT NULL AUTO_INCREMENT,
  `idtemporada_arb` INT NOT NULL,
  `idtipoarbitro_arb` INT NOT NULL,
  `nombre_arb` VARCHAR(45) NULL,
  `apellidos_arb` VARCHAR(45) NULL,
  `fechanac_arb` DATE NULL,
  PRIMARY KEY (`idarbitro`, `idtemporada_arb`),
  INDEX `fk_Arbitros_Tipo_arbitro1_idx` (`idtipoarbitro_arb` ASC),
  INDEX `fk_Arbitros_Temporada1_idx` (`idtemporada_arb` ASC),
  CONSTRAINT `fk_Arbitros_Tipo_arbitro1`
    FOREIGN KEY (`idtipoarbitro_arb`)
    REFERENCES `proyecto`.`Tipo_arbitro` (`idtarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arbitros_Temporada1`
    FOREIGN KEY (`idtemporada_arb`)
    REFERENCES `proyecto`.`Temporada` (`idtemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Tipo_incidencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Tipo_incidencias` (
  `idtincidencias` INT NOT NULL AUTO_INCREMENT,
  `iddeporte_tinc` INT NOT NULL,
  `nombre_tinc` VARCHAR(45) NULL,
  PRIMARY KEY (`idtincidencias`, `iddeporte_tinc`),
  INDEX `fk_Tipo_incidencias_Deporte1_idx` (`iddeporte_tinc` ASC),
  CONSTRAINT `fk_Tipo_incidencias_Deporte1`
    FOREIGN KEY (`iddeporte_tinc`)
    REFERENCES `proyecto`.`Deporte` (`iddeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Incidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Incidencia` (
  `idincidencia` INT NOT NULL AUTO_INCREMENT,
  `idtincidencia_inc` INT NOT NULL,
  `idpartido_inc` INT NOT NULL,
  `idjugador1_inc` INT NOT NULL,
  `idjugador2_inc` INT NOT NULL,
  `tiempo_inc` VARCHAR(45) NULL,
  PRIMARY KEY (`idincidencia`),
  INDEX `fk_Incidencias_Tipo_incidencias1_idx` (`idtincidencia_inc` ASC),
  INDEX `fk_Incidencias_Partidos1_idx` (`idpartido_inc` ASC),
  INDEX `fk_Incidencias_Jugadores1_idx` (`idjugador1_inc` ASC),
  INDEX `fk_Incidencia_Jugador1_idx` (`idjugador2_inc` ASC),
  CONSTRAINT `fk_Incidencias_Tipo_incidencias1`
    FOREIGN KEY (`idtincidencia_inc`)
    REFERENCES `proyecto`.`Tipo_incidencias` (`idtincidencias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incidencias_Partidos1`
    FOREIGN KEY (`idpartido_inc`)
    REFERENCES `proyecto`.`Calendario` (`idpartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incidencias_Jugadores1`
    FOREIGN KEY (`idjugador1_inc`)
    REFERENCES `proyecto`.`Jugador` (`idjugador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incidencia_Jugador1`
    FOREIGN KEY (`idjugador2_inc`)
    REFERENCES `proyecto`.`Jugador` (`idjugador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`posicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`posicion` (
  `idposicion` INT NOT NULL AUTO_INCREMENT,
  `iddeporte_pos` INT NOT NULL,
  `nombre_pos` VARCHAR(45) NULL,
  PRIMARY KEY (`idposicion`, `iddeporte_pos`),
  INDEX `fk_posiciones_Deporte1_idx` (`iddeporte_pos` ASC),
  CONSTRAINT `fk_posiciones_Deporte1`
    FOREIGN KEY (`iddeporte_pos`)
    REFERENCES `proyecto`.`Deporte` (`iddeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Tipo_Entrenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Tipo_Entrenador` (
  `idtipoentrenador` INT NOT NULL AUTO_INCREMENT,
  `deporte_tent` INT NOT NULL,
  `nombre_tent` VARCHAR(45) NULL,
  `apellidos_tent` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipoentrenador`, `deporte_tent`),
  INDEX `fk_Tipo_Entrenador_Deporte1_idx` (`deporte_tent` ASC),
  CONSTRAINT `fk_Tipo_Entrenador_Deporte1`
    FOREIGN KEY (`deporte_tent`)
    REFERENCES `proyecto`.`Deporte` (`iddeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Entrenadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Entrenadores` (
  `identrenador` INT NOT NULL AUTO_INCREMENT,
  `idtentrenador_ent` INT NOT NULL,
  `nombre_ent` VARCHAR(45) NULL,
  `apellidos_ent` VARCHAR(45) NULL,
  `nacionalidad_ent` VARCHAR(30) NULL,
  PRIMARY KEY (`identrenador`),
  INDEX `fk_Entrenadores_Tipo_Entrenador_idx` (`idtentrenador_ent` ASC),
  CONSTRAINT `fk_Entrenadores_Tipo_Entrenador`
    FOREIGN KEY (`idtentrenador_ent`)
    REFERENCES `proyecto`.`Tipo_Entrenador` (`idtipoentrenador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Arbitra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Arbitra` (
  `idpartido_arbitra` INT NOT NULL,
  `idarbitro_arbitra` INT NOT NULL,
  PRIMARY KEY (`idpartido_arbitra`, `idarbitro_arbitra`),
  INDEX `fk_Partidos_has_Arbitros_Arbitros1_idx` (`idarbitro_arbitra` ASC),
  INDEX `fk_Partidos_has_Arbitros_Partidos1_idx` (`idpartido_arbitra` ASC),
  CONSTRAINT `fk_Partidos_has_Arbitros_Partidos1`
    FOREIGN KEY (`idpartido_arbitra`)
    REFERENCES `proyecto`.`Calendario` (`idpartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partidos_has_Arbitros_Arbitros1`
    FOREIGN KEY (`idarbitro_arbitra`)
    REFERENCES `proyecto`.`Arbitro` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`jugador_equipo_temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`jugador_equipo_temporada` (
  `jugador_idjugador` INT NOT NULL,
  `temporada_idtemporada` INT NOT NULL,
  `idequipo_jet` INT NOT NULL,
  `idposicion_jet` INT NOT NULL,
  `numero_jug_jet` INT NOT NULL,
  INDEX `fk_jugador_equipo_temporada_Jugador1_idx` (`jugador_idjugador` ASC),
  INDEX `fk_jugador_equipo_temporada_Temporada1_idx` (`temporada_idtemporada` ASC),
  INDEX `fk_jugador_equipo_temporada_Equipo1_idx` (`idequipo_jet` ASC),
  PRIMARY KEY (`jugador_idjugador`, `temporada_idtemporada`, `idequipo_jet`),
  INDEX `fk_jugador_equipo_temporada_posicion1_idx` (`idposicion_jet` ASC),
  CONSTRAINT `fk_jugador_equipo_temporada_Jugador1`
    FOREIGN KEY (`jugador_idjugador`)
    REFERENCES `proyecto`.`Jugador` (`idjugador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_equipo_temporada_Temporada1`
    FOREIGN KEY (`temporada_idtemporada`)
    REFERENCES `proyecto`.`Temporada` (`idtemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_equipo_temporada_Equipo1`
    FOREIGN KEY (`idequipo_jet`)
    REFERENCES `proyecto`.`Equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_equipo_temporada_posicion1`
    FOREIGN KEY (`idposicion_jet`)
    REFERENCES `proyecto`.`posicion` (`idposicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`division`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`division` (
  `iddivision` INT NOT NULL AUTO_INCREMENT,
  `nombre_div` VARCHAR(45) NULL,
  `descripcion_div` VARCHAR(255) NULL,
  `idpais_div` INT NOT NULL,
  PRIMARY KEY (`iddivision`),
  INDEX `fk_division_país1_idx` (`idpais_div` ASC),
  CONSTRAINT `fk_division_país1`
    FOREIGN KEY (`idpais_div`)
    REFERENCES `proyecto`.`pais` (`idpais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Temporada_equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Temporada_equipo` (
  `idtemporada_temeq` INT NOT NULL,
  `idequipo_temeq` INT NOT NULL,
  `presidente_temeq` VARCHAR(45) NULL,
  `idestadio_temeq` INT NOT NULL,
  `identrenador_temeq` INT NOT NULL,
  `iddivision_temeq` INT NOT NULL,
  PRIMARY KEY (`idtemporada_temeq`, `idequipo_temeq`),
  INDEX `fk_Temporada_has_Equipo_Equipo1_idx` (`idequipo_temeq` ASC),
  INDEX `fk_Temporada_has_Equipo_Temporada1_idx` (`idtemporada_temeq` ASC),
  INDEX `fk_Temporada_has_Equipo_Estadio1_idx` (`idestadio_temeq` ASC),
  INDEX `fk_Temporada_has_Equipo_Entrenadores1_idx` (`identrenador_temeq` ASC),
  INDEX `fk_Temporada_equipo_division1_idx` (`iddivision_temeq` ASC),
  CONSTRAINT `fk_Temporada_has_Equipo_Temporada1`
    FOREIGN KEY (`idtemporada_temeq`)
    REFERENCES `proyecto`.`Temporada` (`idtemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Temporada_has_Equipo_Equipo1`
    FOREIGN KEY (`idequipo_temeq`)
    REFERENCES `proyecto`.`Equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Temporada_has_Equipo_Estadio1`
    FOREIGN KEY (`idestadio_temeq`)
    REFERENCES `proyecto`.`Estadio` (`idestadio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Temporada_has_Equipo_Entrenadores1`
    FOREIGN KEY (`identrenador_temeq`)
    REFERENCES `proyecto`.`Entrenadores` (`identrenador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Temporada_equipo_division1`
    FOREIGN KEY (`iddivision_temeq`)
    REFERENCES `proyecto`.`division` (`iddivision`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto`.`Clasificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`Clasificacion` (
  `idtemporada_cla` INT NOT NULL,
  `idequipo_cla` INT NOT NULL,
  `puntos_cla` INT NULL,
  `goles_favor_cla` INT NULL,
  `goles_contra_cla` INT NULL,
  `numero_partidos_cla` INT NULL,
  `partidos_ganados_cla` INT NULL,
  `partidos_empatados_cla` INT NULL,
  `partidos_perdidos_cla` INT NULL,
  INDEX `fk_Clasificacion_Temporada_equipo1_idx` (`idtemporada_cla` ASC, `idequipo_cla` ASC),
  PRIMARY KEY (`idtemporada_cla`, `idequipo_cla`),
  CONSTRAINT `fk_Clasificacion_Temporada_equipo1`
    FOREIGN KEY (`idtemporada_cla` , `idequipo_cla`)
    REFERENCES `proyecto`.`Temporada_equipo` (`idtemporada_temeq` , `idequipo_temeq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `proyecto`;

DELIMITER $$
USE `proyecto`$$
CREATE DEFINER = CURRENT_USER TRIGGER `proyecto`.`Calendario_AFTER_INSERT` AFTER INSERT ON `Calendario` FOR EACH ROW
BEGIN

#if clasificacion.idequipo_cla = new.local_cal then
if new.goleslocal_cal >= new.golesvisitante_cal then 
update clasificacion set goles_favor_cla = goles_favor_cla + new.goleslocal_cal, goles_contra_cla = goles_contra_cla + new.golesvisitante_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_ganados_cla =  partidos_ganados_cla + 1 where idequipo_cla = new.local_cal; 
elseif new.goleslocal_cal <= new.golesvisitante_cal then 
update clasificacion set goles_favor_cla = goles_favor_cla + new.goleslocal_cal, goles_contra_cla = goles_contra_cla + new.golesvisitante_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_perdidos_cla =  partidos_perdidos_cla + 1 where idequipo_cla = new.local_cal; 
else update clasificacion set goles_favor_cla = new.goleslocal_cal, goles_contra_cla = goles_contra_cla + new.golesvisitante_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_empatados_cla =  partidos_empatados_cla + 1 where idequipo_cla = new.local_cal;   
 end if;
 #elseif clasificacion.idequipo_cla = new.visitante_cal then
 if new.goleslocal_cal <= new.golesvisitante_cal then 
update clasificacion set goles_favor_cla = goles_favor_cla + new.golesvisitante_cal, goles_contra_cla = goles_contra_cla + new.goleslocal_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_ganados_cla =  partidos_ganados_cla + 1 where idequipo_cla = new.visitante_cal; 
elseif new.goleslocal_cal >= new.golesvisitante_cal then 
update clasificacion set goles_favor_cla = goles_favor_cla + new.golesvisitante_cal, goles_contra_cla = goles_contra_cla + new.goleslocal_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_perdidos_cla =  partidos_perdidos_cla + 1 where idequipo_cla = new.visitante_cal; 
else update clasificacion set goles_favor_cla = goles_favor_cla + new.golesvisitante_cal, goles_contra_cla = goles_contra_cla + new.goleslocal_cal, numero_partidos_cla = numero_partidos_cla + 1,partidos_empatados_cla =  partidos_empatados_cla + 1 where idequipo_cla = new.visitante_cal;   
 end if;
 #end if;
END$$

USE `proyecto`$$
CREATE DEFINER = CURRENT_USER TRIGGER `proyecto`.`Temporada_equipo_BEFORE_INSERT` after INSERT ON `Temporada_equipo` FOR EACH ROW
BEGIN
insert into clasificacion values (new.idtemporada_temeq, new.idequipo_temeq, 0,0,0,0,0,0,0);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;