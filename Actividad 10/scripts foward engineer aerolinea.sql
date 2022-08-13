-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aerolinea04
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aerolinea04
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aerolinea04` DEFAULT CHARACTER SET utf8 ;
USE `aerolinea04` ;

-- -----------------------------------------------------
-- Table `aerolinea04`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`pais` (
  `id_pais` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_marca_pais1_idx` (`pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_marca_pais1`
    FOREIGN KEY (`pais_id_pais`)
    REFERENCES `aerolinea04`.`pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`provincia` (
  `id_provincia` INT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`calle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`calle` (
  `id_calle` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_calle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`localidad` (
  `id_localidad` INT NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_localidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`domicilio` (
  `id_domicilio` INT NOT NULL,
  `numero_calle` INT NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  `calle_id_calle` INT NOT NULL,
  `localidad_id_localidad` INT NOT NULL,
  PRIMARY KEY (`id_domicilio`),
  INDEX `fk_C.P.I._provincia1_idx` (`provincia_id_provincia` ASC) VISIBLE,
  INDEX `fk_C.P.I._calle1_idx` (`calle_id_calle` ASC) VISIBLE,
  INDEX `fk_C.P.I._localidad1_idx` (`localidad_id_localidad` ASC) VISIBLE,
  CONSTRAINT `fk_C.P.I._provincia1`
    FOREIGN KEY (`provincia_id_provincia`)
    REFERENCES `aerolinea04`.`provincia` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_C.P.I._calle1`
    FOREIGN KEY (`calle_id_calle`)
    REFERENCES `aerolinea04`.`calle` (`id_calle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_C.P.I._localidad1`
    FOREIGN KEY (`localidad_id_localidad`)
    REFERENCES `aerolinea04`.`localidad` (`id_localidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`persona` (
  `id_persona` INT NOT NULL AUTO_INCREMENT,
  `dni` CHAR(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `domicilio_id_domicilio` INT NOT NULL,
  INDEX `fk_persona_domicilio1_idx` (`domicilio_id_domicilio` ASC) VISIBLE,
  PRIMARY KEY (`id_persona`),
  CONSTRAINT `fk_persona_domicilio1`
    FOREIGN KEY (`domicilio_id_domicilio`)
    REFERENCES `aerolinea04`.`domicilio` (`id_domicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`piloto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`piloto` (
  `persona_id_persona` INT NOT NULL,
  `cuil` CHAR(13) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  PRIMARY KEY (`persona_id_persona`),
  CONSTRAINT `fk_piloto_persona2`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `aerolinea04`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`avion` (
  `matricula` CHAR(6) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `fecha_servicio` DATE NOT NULL,
  `marca_id_marca` INT NOT NULL,
  `piloto_cuil` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_avion_marca1_idx` (`marca_id_marca` ASC) VISIBLE,
  INDEX `fk_avion_piloto1_idx` (`piloto_cuil` ASC) VISIBLE,
  CONSTRAINT `fk_avion_marca1`
    FOREIGN KEY (`marca_id_marca`)
    REFERENCES `aerolinea04`.`marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avion_piloto1`
    FOREIGN KEY (`piloto_cuil`)
    REFERENCES `aerolinea04`.`piloto` (`cuil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`pasajero` (
  `persona_id_persona` INT NOT NULL,
  `viajero_frecuente` CHAR(1) NOT NULL,
  PRIMARY KEY (`persona_id_persona`),
  CONSTRAINT `fk_pasajero_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `aerolinea04`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`aeropuerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`aeropuerto` (
  `codigo` CHAR(3) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`vuelo` (
  `codigo` CHAR(6) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `aer_origen` CHAR(3) NOT NULL,
  `aer_destino` CHAR(3) NOT NULL,
  `compania_id_compania` INT NOT NULL,
  `itinerario_id_itinerario` INT NOT NULL,
  `avion_matricula` INT NOT NULL,
  `piloto_cuil` INT NOT NULL,
  `aeropuerto_origen` CHAR(3) NOT NULL,
  `aeropuerto_destino` CHAR(3) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_vuelo_avion1_idx` (`avion_matricula` ASC) VISIBLE,
  INDEX `fk_vuelo_piloto1_idx` (`piloto_cuil` ASC) VISIBLE,
  INDEX `fk_vuelo_aeropuerto1_idx` (`aeropuerto_origen` ASC) VISIBLE,
  INDEX `fk_vuelo_aeropuerto2_idx` (`aeropuerto_destino` ASC) VISIBLE,
  CONSTRAINT `fk_vuelo_avion1`
    FOREIGN KEY (`avion_matricula`)
    REFERENCES `aerolinea04`.`avion` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_piloto1`
    FOREIGN KEY (`piloto_cuil`)
    REFERENCES `aerolinea04`.`piloto` (`cuil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_aeropuerto1`
    FOREIGN KEY (`aeropuerto_origen`)
    REFERENCES `aerolinea04`.`aeropuerto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_aeropuerto2`
    FOREIGN KEY (`aeropuerto_destino`)
    REFERENCES `aerolinea04`.`aeropuerto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aerolinea04`.`vuelo_has_pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aerolinea04`.`vuelo_has_pasajero` (
  `vuelo_codigo` CHAR(6) NOT NULL,
  `pasajero_persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`vuelo_codigo`, `pasajero_persona_id_persona`),
  INDEX `fk_vuelo_has_pasajero_pasajero1_idx` (`pasajero_persona_id_persona` ASC) VISIBLE,
  INDEX `fk_vuelo_has_pasajero_vuelo1_idx` (`vuelo_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_vuelo_has_pasajero_vuelo1`
    FOREIGN KEY (`vuelo_codigo`)
    REFERENCES `aerolinea04`.`vuelo` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_has_pasajero_pasajero1`
    FOREIGN KEY (`pasajero_persona_id_persona`)
    REFERENCES `aerolinea04`.`pasajero` (`persona_id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
