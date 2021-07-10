CREATE TABLE IF NOT EXISTS `loaf_motel` (
    `identifier` VARCHAR(255),
    `id` INT(4),
    `motel` INT(5),
    `room` INT(5),
    `interior` INT(5) NOT NULL DEFAULT 1,
    `rentmoney` INT(9) NOT NULL DEFAULT 0,
    `next_rent` INT(9) NOT NULL DEFAULT 0,
    PRIMARY KEY (`identifier`)
);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES ("loaf_motel", "Motel", 0);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES ("loaf_motel", "Motel", 0);