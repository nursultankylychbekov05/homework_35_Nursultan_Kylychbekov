CREATE DATABASE IF NOT EXISTS hr_db;
USE hr_db;

CREATE TABLE `Отделы` (
    `id_отдела` INT NOT NULL AUTO_INCREMENT,
    `Название_отдела` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_отдела`)
);

CREATE TABLE `Должности` (
    `id_должности` INT NOT NULL AUTO_INCREMENT,
    `Название_должности` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_должности`)
);

CREATE TABLE `Сотрудники` (
    `id_сотрудника` INT NOT NULL AUTO_INCREMENT,
    `ФИО` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_сотрудника`)
);

CREATE TABLE `Кадровые_Перемещения` (
    `id_записи` INT NOT NULL AUTO_INCREMENT,
    `Код_сотрудника` INT NOT NULL,
    `Код_отдела` INT NOT NULL,
    `Код_должности` INT NOT NULL,
    `Код_начальника` INT NULL,
    `Дата_начала` DATE NOT NULL,
    `Дата_конца` DATE NULL,
    PRIMARY KEY (`id_записи`),
    CONSTRAINT `fk_history_employee` FOREIGN KEY (`Код_сотрудника`) REFERENCES `Сотрудники` (`id_сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_history_department` FOREIGN KEY (`Код_отдела`) REFERENCES `Отделы` (`id_отдела`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_history_position` FOREIGN KEY (`Код_должности`) REFERENCES `Должности` (`id_должности`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_history_manager` FOREIGN KEY (`Код_начальника`) REFERENCES `Сотрудники` (`id_сотрудника`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `История_Окладов` (
    `id_оклада` INT NOT NULL AUTO_INCREMENT,
    `Код_сотрудника` INT NOT NULL,
    `Оклад` DOUBLE NOT NULL,
    `Дата_начала` DATE NOT NULL,
    `Дата_конца` DATE NULL,
    PRIMARY KEY (`id_оклада`),
    CONSTRAINT `fk_salary_employee` FOREIGN KEY (`Код_сотрудника`) REFERENCES `Сотрудники` (`id_сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO `Отделы` (`id_отдела`, `Название_отдела`) VALUES 
(1, 'Администрация'), (2, 'Отдел продаж'), (3, 'Маркетинг');

INSERT INTO `Должности` (`id_должности`, `Название_должности`) VALUES 
(1, 'Директор'), (2, 'Руководитель отдела'), (3, 'Менеджер');

INSERT INTO `Сотрудники` (`id_сотрудника`, `ФИО`) VALUES 
(1, 'Иванов И.И.'), 
(2, 'Петров П.П.'),
(3, 'Сидоров С.С.'); 

INSERT INTO `Кадровые_Перемещения` VALUES (1, 1, 1, 1, NULL, '2026-01-01', NULL);
INSERT INTO `Кадровые_Перемещения` VALUES (2, 2, 2, 2, 1, '2026-01-01', NULL);

INSERT INTO `Кадровые_Перемещения` VALUES (3, 3, 2, 3, 2, '2026-01-01', '2026-03-01');
INSERT INTO `Кадровые_Перемещения` VALUES (4, 3, 3, 2, 1, '2026-03-02', NULL);

INSERT INTO `История_Окладов` VALUES (1, 3, 50000, '2026-01-01', '2026-03-01');
INSERT INTO `История_Окладов` VALUES (2, 3, 80000, '2026-03-02', NULL);

