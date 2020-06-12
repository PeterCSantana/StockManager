-- MySQL Script generated by MySQL Workbench
-- Thu Dec 12 01:56:42 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema StockPortfolioManager
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `StockPortfolioManager` ;

-- -----------------------------------------------------
-- Schema StockPortfolioManager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `StockPortfolioManager` DEFAULT CHARACTER SET utf8 ;
USE `StockPortfolioManager` ;

-- -----------------------------------------------------
-- Table `StockPortfolioManager`.`NotaCorretagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StockPortfolioManager`.`NotaCorretagem` ;

CREATE TABLE IF NOT EXISTS `StockPortfolioManager`.`NotaCorretagem` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NOT NULL,
  `Dt_Pregrao` DATETIME NOT NULL,
  `Codigo` INT NOT NULL,
  `Cliente` INT NOT NULL,
  `Valor` DECIMAL(15,2) NOT NULL,
  `Documento` VARCHAR(45) NOT NULL,
  `TipoNota` CHAR(3) NOT NULL COMMENT 'BMF and Bov',
  PRIMARY KEY (`Id`),
  INDEX `Date` (`TipoNota` ASC, `Dt_Pregrao` ASC))
ENGINE = InnoDB
COMMENT = '					';


-- -----------------------------------------------------
-- Table `StockPortfolioManager`.`TaxaBMF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StockPortfolioManager`.`TaxaBMF` ;

CREATE TABLE IF NOT EXISTS `StockPortfolioManager`.`TaxaBMF` (
  `NotaCorretagem_Id` INT NOT NULL,
  `Vlr_Liquido` DECIMAL(15,2) NOT NULL,
  `IRRF_Day_Trade` DECIMAL(3,2) NOT NULL,
  `Tx_Operacional` DECIMAL(3,2) NOT NULL,
  `Tx_Registro_BMF` DECIMAL(5,2) NOT NULL,
  `Tx_BMF` DECIMAL(5,2) NOT NULL,
  `Vlr_Bruto` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (`NotaCorretagem_Id`),
  CONSTRAINT `fk_TaxaBMF_NotaCorretagem`
    FOREIGN KEY (`NotaCorretagem_Id`)
    REFERENCES `StockPortfolioManager`.`NotaCorretagem` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StockPortfolioManager`.`FinanceiroBovespa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StockPortfolioManager`.`FinanceiroBovespa` ;

CREATE TABLE IF NOT EXISTS `StockPortfolioManager`.`FinanceiroBovespa` (
  `NotaCorretagem_Id` INT NOT NULL,
  `Vlr_Liquido_Operacao` DECIMAL(15,2) NOT NULL,
  `Tx_Liquidacao` DECIMAL(5,2) NOT NULL,
  `Tx_Registro` DECIMAL(5,2) NOT NULL,
  `Tx_TermoOpcao` DECIMAL(5,2) NOT NULL,
  `Tx_ANA` DECIMAL(5,2) NOT NULL,
  `Emolumentos` DECIMAL(3,2) NOT NULL,
  `Corretagem` DECIMAL(5,2) NOT NULL,
  `ISS_RJ` DECIMAL(5,2) NOT NULL,
  `IRRF` DECIMAL(5,2) NOT NULL,
  `Outros` DECIMAL(5,2) NOT NULL,
  `Vlr_Bruto` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (`NotaCorretagem_Id`),
  CONSTRAINT `fk_FinanceiroBovespa_NotaCorretagem1`
    FOREIGN KEY (`NotaCorretagem_Id`)
    REFERENCES `StockPortfolioManager`.`NotaCorretagem` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StockPortfolioManager`.`Ordem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StockPortfolioManager`.`Ordem` ;

CREATE TABLE IF NOT EXISTS `StockPortfolioManager`.`Ordem` (
  `NotaCorretagem_Id` INT NOT NULL,
  `Mercadoria_Titulo` VARCHAR(10) NOT NULL,
  `TipoOrdem` CHAR(1) NOT NULL COMMENT 'C = Compra\nV = Venda',
  `TipoNegocio` CHAR(1) NOT NULL COMMENT 'D = Day Trade\nS = Swing Trade',
  `Quantidade` INT NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `Vencimento` DATE NULL,
  INDEX `fk_table1_NotaCorretagem1_idx` (`NotaCorretagem_Id` ASC),
  PRIMARY KEY (`NotaCorretagem_Id`),
  CONSTRAINT `fk_table1_NotaCorretagem1`
    FOREIGN KEY (`NotaCorretagem_Id`)
    REFERENCES `StockPortfolioManager`.`NotaCorretagem` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StockPortfolioManager`.`NegocioBovespa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `StockPortfolioManager`.`NegocioBovespa` ;

CREATE TABLE IF NOT EXISTS `StockPortfolioManager`.`NegocioBovespa` (
  `NotaCorretagem_Id` INT NOT NULL,
  `Debentures` DECIMAL(5,2) NOT NULL,
  `MV_TotCompra` DECIMAL(15,2) NOT NULL,
  `MV_TotVenda` DECIMAL(15,2) NOT NULL,
  `MO_TotCompra` DECIMAL(15,2) NOT NULL,
  `MO_TotVenda` DECIMAL(15,2) NOT NULL,
  `Oper_Termo` DECIMAL(15,2) NOT NULL,
  `Oper_TituloPublico` DECIMAL(15,2) NOT NULL,
  `Vlr_TotNegocio` DECIMAL(15,2) NOT NULL,
  INDEX `fk_NegocioBovespa_NotaCorretagem1_idx` (`NotaCorretagem_Id` ASC),
  PRIMARY KEY (`NotaCorretagem_Id`),
  CONSTRAINT `fk_NegocioBovespa_NotaCorretagem1`
    FOREIGN KEY (`NotaCorretagem_Id`)
    REFERENCES `StockPortfolioManager`.`NotaCorretagem` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
