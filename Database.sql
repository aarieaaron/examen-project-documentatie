-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `userID` INT NOT NULL,
  `name` VARCHAR(450) NOT NULL,
  `email` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserSecurity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UserSecurity` (
  `userID` INT NOT NULL,
  `passwordHash` VARCHAR(120) NULL,
  `verificationHash` VARCHAR(120) NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `user`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `role` VARCHAR(100) NOT NULL,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UserRoles` (
  `role` VARCHAR(100) NOT NULL,
  `userID` INT NULL,
  PRIMARY KEY (`role`),
  INDEX `user_idx` (`userID` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `role`
    FOREIGN KEY (`role`)
    REFERENCES `mydb`.`Roles` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `orderID` INT NOT NULL,
  `userID` INT NULL,
  `deliveryDate` VARCHAR(45) NULL,
  `deliveryTime` VARCHAR(45) NULL,
  PRIMARY KEY (`orderID`),
  INDEX `userID_idx` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ShippingAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ShippingAddress` (
  `orderID` INT NOT NULL,
  `street` VARCHAR(90) NULL,
  `zipcode` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  PRIMARY KEY (`orderID`),
  CONSTRAINT `orderID`
    FOREIGN KEY (`orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InvoiceAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InvoiceAddress` (
  `orderID` INT NOT NULL,
  `street` VARCHAR(90) NULL,
  `zipcode` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  PRIMARY KEY (`orderID`),
  CONSTRAINT `Order`
    FOREIGN KEY (`orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `productID` INT NOT NULL,
  `productName` VARCHAR(450) NULL,
  `productPrice` FLOAT NULL,
  `productWheelDiameter` VARCHAR(45) NULL,
  `productFrameSize` VARCHAR(45) NULL,
  `productAgeRange` VARCHAR(45) NULL,
  `productDescription` VARCHAR(450) NULL,
  `productBrand` VARCHAR(100) NULL,
  PRIMARY KEY (`productID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `itemID` INT NOT NULL,
  `productID` INT NULL,
  PRIMARY KEY (`itemID`),
  INDEX `Product_idx` (`productID` ASC),
  CONSTRAINT `Product`
    FOREIGN KEY (`productID`)
    REFERENCES `mydb`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderDetails` (
  `orderID` INT NOT NULL,
  `itemID` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`orderID`, `itemID`),
  INDEX `Item_idx` (`itemID` ASC),
  CONSTRAINT `Order`
    FOREIGN KEY (`orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Item`
    FOREIGN KEY (`itemID`)
    REFERENCES `mydb`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductAttributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductAttributes` (
  `productID` INT NOT NULL,
  `attribute` VARCHAR(450) NULL,
  PRIMARY KEY (`productID`),
  CONSTRAINT `Product`
    FOREIGN KEY (`productID`)
    REFERENCES `mydb`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `category` VARCHAR(45) NOT NULL,
  `description` VARCHAR(450) NULL,
  PRIMARY KEY (`category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductInCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductInCategory` (
  `productID` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`productID`, `category`),
  INDEX `category_idx` (`category` ASC),
  CONSTRAINT `product`
    FOREIGN KEY (`productID`)
    REFERENCES `mydb`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category`
    FOREIGN KEY (`category`)
    REFERENCES `mydb`.`Category` (`category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Requests` (
  `userID` INT NOT NULL,
  `productID` INT NOT NULL,
  `reason` VARCHAR(450) NULL,
  PRIMARY KEY (`userID`, `productID`),
  INDEX `product_idx` (`productID` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product`
    FOREIGN KEY (`productID`)
    REFERENCES `mydb`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
