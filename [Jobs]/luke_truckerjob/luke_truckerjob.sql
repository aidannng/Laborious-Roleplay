CREATE TABLE IF NOT EXISTS luke_truckerjob (
    identifier varchar(50) NOT NULL,
    progress int(11) DEFAULT 0,
    level int(11) DEFAULT 1,

    PRIMARY KEY (identifier)
);

INSERT INTO jobs (`name`, `label`) VALUES ('trucker', 'Trucker');

INSERT INTO job_grades (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES 
    ('trucker', '0', 'employee', 'Trucker', '0', '{}', '{}');