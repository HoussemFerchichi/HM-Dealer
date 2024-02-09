CREATE TABLE IF NOT EXISTS `deal` (
    `place` int(11) NOT NULL AUTO_INCREMENT,
    `started` varchar(32) NOT NULL,
    `gun` varchar(32) NOT NULL,
    PRIMARY KEY (`place`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;