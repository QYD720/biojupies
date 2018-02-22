DROP DATABASE IF EXISTS notebook_generator;
CREATE DATABASE notebook_generator;
USE notebook_generator;

CREATE TABLE series (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`gse` VARCHAR(35) UNIQUE
);

CREATE TABLE platform (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`gpl` VARCHAR(15) UNIQUE
);

CREATE TABLE sample (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`gsm` VARCHAR(15),
	`sample_title` VARCHAR(255),
	`series_fk` INT,
	`platform_fk` INT,
	FOREIGN KEY (series_fk) REFERENCES series(id),
	FOREIGN KEY (platform_fk) REFERENCES platform(id)
);

CREATE TABLE section (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`section_name` VARCHAR(255)
);

CREATE TABLE tool (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`tool_string` VARCHAR(255),
	`tool_name` VARCHAR(255),
	`tool_description` TEXT,
	`introduction` TEXT,
	`methods` TEXT,
	`reference` TEXT,
	`reference_link` TEXT,
	`default_selected` BOOL,
	`requires_signature` BOOL,
	`section_fk` INT,
	FOREIGN KEY (section_fk) REFERENCES section(id)
);

CREATE TABLE parameter (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`parameter_name` VARCHAR(255),
	`parameter_description` TEXT,
	`parameter_string` VARCHAR(255),
	`tool_fk` INT,
	FOREIGN KEY (tool_fk) REFERENCES tool(id)
);

CREATE TABLE parameter_value (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`parameter_fk` INT,
	`value` VARCHAR(255),
	`type` ENUM('str', 'int', 'float'),
	`default` BOOL,
	FOREIGN KEY (parameter_fk) REFERENCES parameter(id)
);

CREATE TABLE core_scripts (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`option_string` VARCHAR(255),
	`option_name` VARCHAR(255),
	`option_description` TEXT,
	`introduction` TEXT,
	`methods` TEXT,
	`reference` TEXT,
	`reference_link` TEXT
);

CREATE TABLE error_log (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`gse` VARCHAR(20),
	`version` VARCHAR(10),
	`notebook_configuration` TEXT,
	`error_type` VARCHAR(20),
	`error` TEXT,
	`date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notebooks (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`notebook_uid` VARCHAR(30),
	`notebook_url` TEXT,
	`gse` VARCHAR(20),
	`version` VARCHAR(10)
);