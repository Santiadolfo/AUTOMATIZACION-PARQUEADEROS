-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PARQUEADERO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PARQUEADERO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PARQUEADERO` DEFAULT CHARACTER SET utf8 ;
USE `PARQUEADERO` ;

-- -----------------------------------------------------
-- Table `PARQUEADERO`.`Vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PARQUEADERO`.`Vehiculos` (
  `Placa` VARCHAR(6) NOT NULL,
  `Tipo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Placa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PARQUEADERO`.`Ingresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PARQUEADERO`.`Ingresos` (
  `ID` INT UNSIGNED NOT NULL,
  `Fecha_Ingreso` DATETIME NOT NULL,
  `Estado` TINYINT NOT NULL,
  `Placa` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_ingreso_vehiculo_idx` (`Placa` ASC) VISIBLE,
  CONSTRAINT `fk_ingreso_vehiculo`
    FOREIGN KEY (`Placa`)
    REFERENCES `PARQUEADERO`.`Vehiculos` (`Placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PARQUEADERO`.`Egresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PARQUEADERO`.`Egresos` (
  `ID` INT UNSIGNED NOT NULL,
  `Fecha_Egreso` DATETIME NOT NULL,
  `ID_Ingreso` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_egreso_ingreso_idx` (`ID_Ingreso` ASC) VISIBLE,
  CONSTRAINT `fk_egreso_ingreso`
    FOREIGN KEY (`ID_Ingreso`)
    REFERENCES `PARQUEADERO`.`Ingresos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PARQUEADERO`.`Recaudo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PARQUEADERO`.`Recaudo` (
  `Num_Factura` INT UNSIGNED NOT NULL,
  `ID_Egreso` INT UNSIGNED NOT NULL,
  `Monto` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Num_Factura`),
  INDEX `fk_recaudo_egreso_idx` (`ID_Egreso` ASC) VISIBLE,
  CONSTRAINT `fk_recaudo_egreso`
    FOREIGN KEY (`ID_Egreso`)
    REFERENCES `PARQUEADERO`.`Egresos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
