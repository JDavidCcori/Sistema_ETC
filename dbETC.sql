CREATE SCHEMA IF NOT EXISTS `bd_etc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bd_etc` ;

-- -----------------------------------------------------
-- Table `bd_etc`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`empresa` (
  `idEmpresa` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`pasaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`pasaje` (
  `idPasaje` INT NOT NULL,
  `precioRuta1` VARCHAR(45) NOT NULL,
  `precioRuta2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPasaje`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`administrador` (
  `dni` CHAR(8) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `código` VARCHAR(45) NOT NULL,
  `númerocelular` VARCHAR(9) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Edad` INT NOT NULL,
  `Sexo` VARCHAR(45) NOT NULL,
  `empresa_idEmpresa` INT NOT NULL,
  `pasaje_idPasaje` INT NOT NULL,
  PRIMARY KEY (`dni`),
  INDEX `fk_administrador_empresa1_idx` (`empresa_idEmpresa` ASC) VISIBLE,
  INDEX `fk_administrador_pasaje1_idx` (`pasaje_idPasaje` ASC) VISIBLE,
  CONSTRAINT `fk_administrador_empresa1`
    FOREIGN KEY (`empresa_idEmpresa`)
    REFERENCES `bd_etc`.`empresa` (`idEmpresa`),
  CONSTRAINT `fk_administrador_pasaje1`
    FOREIGN KEY (`pasaje_idPasaje`)
    REFERENCES `bd_etc`.`pasaje` (`idPasaje`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`vehículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`vehículo` (
  `Placa` VARCHAR(12) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `tipovehículo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Placa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`socio` (
  `dni` CHAR(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `númerocelular` VARCHAR(9) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Edad` VARCHAR(45) NOT NULL,
  `Sexo` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Rol` VARCHAR(45) NOT NULL,
  `Vehículo_Placa` VARCHAR(12) NOT NULL,
  `empresa_idEmpresa` INT NOT NULL,
  PRIMARY KEY (`dni`),
  INDEX `fk_Socio_Vehículo1_idx` (`Vehículo_Placa` ASC) VISIBLE,
  INDEX `fk_socio_empresa1_idx` (`empresa_idEmpresa` ASC) VISIBLE,
  CONSTRAINT `fk_socio_empresa1`
    FOREIGN KEY (`empresa_idEmpresa`)
    REFERENCES `bd_etc`.`empresa` (`idEmpresa`),
  CONSTRAINT `fk_Socio_Vehículo1`
    FOREIGN KEY (`Vehículo_Placa`)
    REFERENCES `bd_etc`.`vehículo` (`Placa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`chofer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`chofer` (
  `dni` CHAR(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `númerocelular` CHAR(9) NOT NULL,
  `dirección` VARCHAR(45) NULL DEFAULT NULL,
  `edad` INT NULL DEFAULT NULL,
  `sexo` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `socio_dni` CHAR(8) NULL,
  PRIMARY KEY (`dni`),
  INDEX `fk_chofer_socio1_idx` (`socio_dni` ASC) VISIBLE,
  CONSTRAINT `fk_chofer_socio1`
    FOREIGN KEY (`socio_dni`)
    REFERENCES `bd_etc`.`socio` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`cronograma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`cronograma` (
  `idCronograma` INT NOT NULL,
  `orden_Salida` VARCHAR(45) NOT NULL,
  `ruta` VARCHAR(45) NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `socio_dni` CHAR(8) NULL,
  `chofer_dni` CHAR(8) NULL,
  PRIMARY KEY (`idCronograma`),
  INDEX `fk_cronograma_socio1_idx` (`socio_dni` ASC) VISIBLE,
  INDEX `fk_cronograma_chofer1_idx` (`chofer_dni` ASC) VISIBLE,
  CONSTRAINT `fk_cronograma_socio1`
    FOREIGN KEY (`socio_dni`)
    REFERENCES `bd_etc`.`socio` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cronograma_chofer1`
    FOREIGN KEY (`chofer_dni`)
    REFERENCES `bd_etc`.`chofer` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`objetosperdidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`objetosperdidos` (
  `idObjetosPerdidos` INT NOT NULL,
  `Denominación` VARCHAR(45) NOT NULL,
  `Descripción` TEXT NOT NULL,
  `chofer_dni` CHAR(8) NULL DEFAULT NULL,
  `socio-dni` CHAR(8) NULL DEFAULT NULL,
  PRIMARY KEY (`idObjetosPerdidos`),
  INDEX `chofer_dni_idx` (`chofer_dni` ASC) VISIBLE,
  INDEX `socio-dni_idx` (`socio-dni` ASC) VISIBLE,
  CONSTRAINT `chofer_dni`
    FOREIGN KEY (`chofer_dni`)
    REFERENCES `bd_etc`.`chofer` (`dni`),
  CONSTRAINT `socio-dni`
    FOREIGN KEY (`socio-dni`)
    REFERENCES `bd_etc`.`socio` (`dni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bd_etc`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_etc`.`pagos` (
  `idPagos` INT NOT NULL,
  `monto` VARCHAR(45) NOT NULL,
  `fechaPago` DATE NOT NULL,
  `Socio_dni` CHAR(8) NOT NULL,
  PRIMARY KEY (`idPagos`),
  INDEX `fk_Pagos_Socio1_idx` (`Socio_dni` ASC) VISIBLE,
  CONSTRAINT `fk_Pagos_Socio1`
    FOREIGN KEY (`Socio_dni`)
    REFERENCES `bd_etc`.`socio` (`dni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;