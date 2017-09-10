-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema u121456690_exam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema u121456690_exam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `u121456690_exam` DEFAULT CHARACTER SET utf8 ;
USE `u121456690_exam` ;

-- -----------------------------------------------------
-- Table `u121456690_exam`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `paymentMethod` VARCHAR(150) NOT NULL,
  `bank` VARCHAR(45) NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`UserSecurity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`UserSecurity` (
  `userID` INT NOT NULL,
  `passwordHash` VARCHAR(120) NULL,
  `verificationHash` VARCHAR(120) NULL,
  `accountStatus` VARCHAR(100) NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `userSecurity`
    FOREIGN KEY (`userID`)
    REFERENCES `u121456690_exam`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Roles` (
  `role` VARCHAR(100) NOT NULL,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`UserRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`UserRoles` (
  `role` VARCHAR(100) NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`role`, `userID`),
  INDEX `user_idx` (`userID` ASC),
  CONSTRAINT `userRole`
    FOREIGN KEY (`userID`)
    REFERENCES `u121456690_exam`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `roleUser`
    FOREIGN KEY (`role`)
    REFERENCES `u121456690_exam`.`Roles` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NULL,
  `orderPlaced` DATETIME NULL,
  `status` VARCHAR(150) NULL,
  PRIMARY KEY (`orderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`ShippingAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`ShippingAddress` (
  `orderID` INT NOT NULL,
  `street` VARCHAR(90) NULL,
  `zipcode` VARCHAR(45) NULL,
  `city` VARCHAR(150) NULL,
  `name` VARCHAR(150) NULL,
  `email` VARCHAR(150) NULL,
  `saveForLater` TINYINT(1) NULL,
  PRIMARY KEY (`orderID`),
  CONSTRAINT `orderIDShipping`
    FOREIGN KEY (`orderID`)
    REFERENCES `u121456690_exam`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`InvoiceAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`InvoiceAddress` (
  `orderID` INT NOT NULL,
  `street` VARCHAR(90) NULL,
  `zipcode` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `name` VARCHAR(150) NULL,
  `email` VARCHAR(150) NULL,
  `saveForLater` TINYINT(1) NULL,
  PRIMARY KEY (`orderID`),
  CONSTRAINT `OrderInvoice`
    FOREIGN KEY (`orderID`)
    REFERENCES `u121456690_exam`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Brands` (
  `brandName` VARCHAR(100) NOT NULL,
  `brandDescription` VARCHAR(250) NULL,
  PRIMARY KEY (`brandName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Product` (
  `productID` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(150) NULL,
  `productPrice` FLOAT NULL,
  `productDescription` VARCHAR(250) NULL,
  `productBrand` VARCHAR(100) NULL,
  PRIMARY KEY (`productID`),
  INDEX `brand_idx` (`productBrand` ASC),
  CONSTRAINT `brand`
    FOREIGN KEY (`productBrand`)
    REFERENCES `u121456690_exam`.`Brands` (`brandName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Item` (
  `itemID` INT NOT NULL AUTO_INCREMENT,
  `productID` INT NULL,
  `status` VARCHAR(100) NULL DEFAULT 'usable',
  PRIMARY KEY (`itemID`),
  INDEX `Product_idx` (`productID` ASC),
  CONSTRAINT `ProductItem`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`OrderDetails` (
  `orderID` INT NOT NULL,
  `itemID` INT NOT NULL,
  PRIMARY KEY (`orderID`, `itemID`),
  INDEX `Item_idx` (`itemID` ASC),
  CONSTRAINT `OrderDetails`
    FOREIGN KEY (`orderID`)
    REFERENCES `u121456690_exam`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ItemDetails`
    FOREIGN KEY (`itemID`)
    REFERENCES `u121456690_exam`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`ProductAttributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`ProductAttributes` (
  `productID` INT NOT NULL,
  `attribute` VARCHAR(250) NOT NULL,
  `attributeValue` VARCHAR(250) NULL,
  PRIMARY KEY (`attribute`, `productID`),
  CONSTRAINT `ProductAttributes`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Category` (
  `category` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NULL,
  PRIMARY KEY (`category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`ProductInCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`ProductInCategory` (
  `productID` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`productID`, `category`),
  INDEX `category_idx` (`category` ASC),
  CONSTRAINT `productInCategory`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `categoryPerProduct`
    FOREIGN KEY (`category`)
    REFERENCES `u121456690_exam`.`Category` (`category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Requests` (
  `userID` INT NOT NULL,
  `productID` INT NOT NULL,
  `reason` VARCHAR(250) NULL,
  PRIMARY KEY (`userID`, `productID`),
  INDEX `product_idx` (`productID` ASC),
  CONSTRAINT `userRequest`
    FOREIGN KEY (`userID`)
    REFERENCES `u121456690_exam`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productRequest`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`ProductImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`ProductImages` (
  `productID` INT NOT NULL,
  `image` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`productID`, `image`),
  CONSTRAINT `productImages`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Cart` (
  `cartID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NULL,
  `lastModified` DATETIME NULL,
  PRIMARY KEY (`cartID`),
  INDEX `user_idx` (`userID` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`userID`)
    REFERENCES `u121456690_exam`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`CartItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`CartItems` (
  `cartItem` INT NOT NULL AUTO_INCREMENT,
  `cartID` INT NULL,
  `itemID` INT NULL,
  PRIMARY KEY (`cartItem`),
  INDEX `cart_idx` (`cartID` ASC),
  INDEX `item_idx` (`itemID` ASC),
  CONSTRAINT `cart`
    FOREIGN KEY (`cartID`)
    REFERENCES `u121456690_exam`.`Cart` (`cartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item`
    FOREIGN KEY (`itemID`)
    REFERENCES `u121456690_exam`.`Item` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u121456690_exam`.`Favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u121456690_exam`.`Favorites` (
  `userID` INT NOT NULL,
  `productID` INT NOT NULL,
  PRIMARY KEY (`userID`, `productID`),
  INDEX `product_idx` (`productID` ASC),
  CONSTRAINT `useridfavorites`
    FOREIGN KEY (`userID`)
    REFERENCES `u121456690_exam`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productfavorites`
    FOREIGN KEY (`productID`)
    REFERENCES `u121456690_exam`.`Product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
