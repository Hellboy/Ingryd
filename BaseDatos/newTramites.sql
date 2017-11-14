-- MySQL Script generated by MySQL Workbench
-- 10/20/17 03:03:11
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
-- -----------------------------------------------------
-- Schema tramites
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tramites` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `tramites`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`categoria` (
  `categoriaID` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `estado` TINYINT(4) NOT NULL,
  PRIMARY KEY (`categoriaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tramites`.`entidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`entidad` (
  `entidadID` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreInstitucion` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `encargado` INT(11) NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(25) NOT NULL,
  `departamento` VARCHAR(15) NOT NULL,
  `latitud` FLOAT NULL DEFAULT NULL,
  `longitud` FLOAT NULL DEFAULT NULL,
  `horario` VARCHAR(200) NULL DEFAULT NULL,
  `estado` TINYINT(4) NOT NULL,
  PRIMARY KEY (`entidadID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tramites`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`institucion` (
  `institucionID` INT(11) NOT NULL,
  `tipoInstitucion` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`institucionID`),
  INDEX `fk_Institucion_Entidad1_idx` (`institucionID` ASC),
  CONSTRAINT `fk_Institucion_Entidad1`
    FOREIGN KEY (`institucionID`)
    REFERENCES `tramites`.`entidad` (`entidadID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tramites`.`tramite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`tramite` (
  `tramiteID` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreTramite` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `estado` TINYINT(4) NOT NULL,
  `categoriaID` INT(11) NOT NULL,
  `institucionID` INT(11) NOT NULL,
  PRIMARY KEY (`tramiteID`),
  INDEX `fk_Tramite_Categoria1_idx` (`categoriaID` ASC),
  INDEX `fk_tramite_institucion1_idx` (`institucionID` ASC),
  CONSTRAINT `fk_Tramite_Categoria1`
    FOREIGN KEY (`categoriaID`)
    REFERENCES `tramites`.`categoria` (`categoriaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tramite_institucion1`
    FOREIGN KEY (`institucionID`)
    REFERENCES `tramites`.`institucion` (`institucionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`documento` (
  `documentoID` INT NOT NULL AUTO_INCREMENT,
  `nombreDocumento` VARCHAR(150) NOT NULL,
  `pathDocumento` VARCHAR(150) NOT NULL,
  `tramite_tramiteID` INT(11) NOT NULL,
  PRIMARY KEY (`documentoID`),
  INDEX `fk_Documento_tramite_idx` (`tramite_tramiteID` ASC),
  CONSTRAINT `fk_Documento_tramite`
    FOREIGN KEY (`tramite_tramiteID`)
    REFERENCES `tramites`.`tramite` (`tramiteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `tramites` ;

-- -----------------------------------------------------
-- Table `tramites`.`requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`requisito` (
  `requisitoID` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreRequisito` VARCHAR(150) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `estado` TINYINT NOT NULL,
  `tramiteID` INT(11) NOT NULL,
  PRIMARY KEY (`requisitoID`),
  INDEX `fk_requisito_tramite1_idx` (`tramiteID` ASC),
  CONSTRAINT `fk_requisito_tramite1`
    FOREIGN KEY (`tramiteID`)
    REFERENCES `tramites`.`tramite` (`tramiteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tramites`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`sucursal` (
  `sucursalID` INT(11) NOT NULL,
  `entidadID` INT(11) NOT NULL,
  PRIMARY KEY (`sucursalID`),
  INDEX `fk_Sucursal_Entidad1_idx` (`sucursalID` ASC),
  INDEX `fk_Sucursal_Institucion1_idx` (`entidadID` ASC),
  CONSTRAINT `fk_Sucursal_Entidad1`
    FOREIGN KEY (`sucursalID`)
    REFERENCES `tramites`.`entidad` (`entidadID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Institucion1`
    FOREIGN KEY (`entidadID`)
    REFERENCES `tramites`.`institucion` (`institucionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tramites`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tramites`.`usuario` (
  `usuarioID` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoUsuario` TINYINT(4) NOT NULL,
  `cargo` VARCHAR(45) NULL DEFAULT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `primerAp` VARCHAR(100) NOT NULL,
  `segundoAp` VARCHAR(100) NULL DEFAULT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `correo` VARCHAR(80) NULL DEFAULT NULL,
  `nombreUsuario` VARCHAR(15) NOT NULL,
  `password` VARCHAR(15) NOT NULL,
  `estado` TINYINT(4) NOT NULL,
  `institucionID` INT(11) NOT NULL,
  PRIMARY KEY (`usuarioID`),
  INDEX `fk_Usuario_Institucion1_idx` (`institucionID` ASC),
  CONSTRAINT `fk_Usuario_Institucion1`
    FOREIGN KEY (`institucionID`)
    REFERENCES `tramites`.`institucion` (`institucionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;