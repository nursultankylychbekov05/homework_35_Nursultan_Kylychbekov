CREATE DATABASE IF NOT EXISTS courses_db;
USE courses_db;

CREATE TABLE `Группы` (
    `id_группы` INT NOT NULL AUTO_INCREMENT,
    `Название_группы` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id_группы`)
);

CREATE TABLE `Студенты` (
    `id_студента` INT NOT NULL AUTO_INCREMENT,
    `ФИО` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_студента`)
);

CREATE TABLE `История_Переходов` (
    `id_записи` INT NOT NULL AUTO_INCREMENT,
    `Код_студента` INT NOT NULL,
    `Код_группы` INT NOT NULL,
    `Дата_зачисления` DATE NOT NULL,
    `Дата_отчисления` DATE NULL,
    PRIMARY KEY (`id_записи`),
    CONSTRAINT `fk_history_student` FOREIGN KEY (`Код_студента`) REFERENCES `Студенты` (`id_студента`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_history_group` FOREIGN KEY (`Код_группы`) REFERENCES `Группы` (`id_группы`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Темы` (
    `id_темы` INT NOT NULL AUTO_INCREMENT,
    `Название_темы` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`id_темы`)
);

CREATE TABLE `Занятия` (
    `id_занятия` INT NOT NULL AUTO_INCREMENT,
    `Код_группы` INT NOT NULL,
    `Дата_проведения` DATE NOT NULL,
    PRIMARY KEY (`id_занятия`),
    CONSTRAINT `fk_lessons_group` FOREIGN KEY (`Код_группы`) REFERENCES `Группы` (`id_группы`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Темы_Занятий` (
    `Код_занятия` INT NOT NULL,
    `Код_темы` INT NOT NULL,
    PRIMARY KEY (`Код_занятия`, `Код_темы`),
    CONSTRAINT `fk_lt_lesson` FOREIGN KEY (`Код_занятия`) REFERENCES `Занятия` (`id_занятия`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_lt_topic` FOREIGN KEY (`Код_темы`) REFERENCES `Темы` (`id_темы`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Посещаемость` (
    `Код_занятия` INT NOT NULL,
    `Код_студента` INT NOT NULL,
    `Присутствие` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`Код_занятия`, `Код_студента`),
    CONSTRAINT `fk_att_lesson` FOREIGN KEY (`Код_занятия`) REFERENCES `Занятия` (`id_занятия`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_att_student` FOREIGN KEY (`Код_студента`) REFERENCES `Студенты` (`id_студента`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `Группы` (`id_группы`, `Название_группы`) VALUES (1, 'C#-Разработчики'), (2, 'SQL-Эксперты');

INSERT INTO `Студенты` (`id_студента`, `ФИО`) VALUES (1, 'Иванов А.С.'), (2, 'Петров К.М.');

INSERT INTO `История_Переходов` VALUES (1, 1, 1, '2026-01-01', NULL);

INSERT INTO `История_Переходов` VALUES (2, 2, 1, '2026-01-01', '2026-01-15');
INSERT INTO `История_Переходов` VALUES (3, 2, 2, '2026-01-16', NULL);

INSERT INTO `Темы` (`id_темы`, `Название_темы`) VALUES 
(1, 'Введение в ООП'), (2, 'Классы и объекты'), (3, 'Реляционные базы данных');

INSERT INTO `Занятия` (`id_занятия`, `Код_группы`, `Дата_проведения`) VALUES 
(101, 1, '2026-01-10'), 
(102, 1, '2026-01-12');

INSERT INTO `Темы_Занятий` VALUES (101, 1), (102, 1), (102, 2);
INSERT INTO `Посещаемость` VALUES (101, 1, 1), (101, 2, 1);
INSERT INTO `Посещаемость` VALUES (102, 1, 1), (102, 2, 0);


