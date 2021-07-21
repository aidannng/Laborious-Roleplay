INSERT INTO `jobs` (`name`, `label`) VALUES
('welding', 'Welding');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('welding', 0, 'interim', 'Employee', 150, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('pay_welding', 'Pay Slip', 15, 0, 1);
