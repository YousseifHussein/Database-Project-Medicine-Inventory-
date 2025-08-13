CREATE DATABASE IF NOT EXISTS medicine_inventory;
USE medicine_inventory;

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    qualification VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Disease (
    disease_id INT PRIMARY KEY,
    disease_name VARCHAR(100),
    disease_type ENUM('infectious', 'deficiency', 'genetic hereditary', 'non-genetic hereditary')
);

CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100),
    manufacture_date DATE,
    expiry_date DATE,
    price DECIMAL(10, 2),
    dosage VARCHAR(50)
);

CREATE TABLE Medicine_Disease (
    medicine_id INT,
    disease_id INT,
    PRIMARY KEY (medicine_id, disease_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id),
    FOREIGN KEY (disease_id) REFERENCES Disease(disease_id)
);

CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    doctor_id INT,
    issuing_date DATE,
    patient_name VARCHAR(100),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Prescription_Medicine (
    prescription_id INT,
    medicine_id INT,
    quantity INT,
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Bill (
    bill_id INT PRIMARY KEY,
    prescription_id INT,
    tax DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    total DECIMAL(10, 2),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id)
);

DELIMITER //
CREATE TRIGGER update_bill_after_prescription
AFTER INSERT ON Prescription_Medicine
FOR EACH ROW
BEGIN
    DECLARE total_price DECIMAL(10,2);

    SELECT SUM(m.price * NEW.quantity)
    INTO total_price
    FROM Medicine m
    WHERE m.medicine_id = NEW.medicine_id;

    INSERT INTO Bill (bill_id, prescription_id, tax, discount, total)
    VALUES (NEW.prescription_id, NEW.prescription_id, 0.00, 0.00, total_price);
END;
//
DELIMITER ;

SELECT doctor_name
FROM Doctor
WHERE specialization LIKE '%heart disease%';

SELECT disease_name
FROM Disease
WHERE disease_type = 'deficiency';

SELECT m.medicine_name, SUM(pm.quantity) AS total_sold
FROM Medicine m
JOIN Prescription_Medicine pm ON m.medicine_id = pm.medicine_id
JOIN Prescription p ON p.prescription_id = pm.prescription_id
WHERE YEAR(p.issuing_date) = 2023
GROUP BY m.medicine_name
ORDER BY total_sold DESC
LIMIT 1;

INSERT INTO Doctor (doctor_id, doctor_name, qualification, specialization) VALUES
(1, 'Dr. Ahmed Saeed', 'MBBS', 'Heart Disease'),
(2, 'Dr. Mona Hossam', 'MD', 'Diabetes'),
(3, 'Dr. Karim Nabil', 'PhD', 'Genetics'),
(4, 'Dr. Heba Adel', 'MBBS', 'Infectious Diseases'),
(5, 'Dr. Tamer Khaled', 'MD', 'Nutrition'),
(6, 'Dr. Rania Mostafa', 'PhD', 'Liver Disease'),
(7, 'Dr. Youssef Hani', 'MBBS', 'Eye Disorders'),
(8, 'Dr. Salma Farid', 'MD', 'Genetic Disorders'),
(9, 'Dr. Mahmoud Fathi', 'MBBS', 'Skin Diseases'),
(10, 'Dr. Eman Kamal', 'MD', 'Blood Pressure');

INSERT INTO Disease (disease_id, disease_name, disease_type) VALUES
(1, 'Hypertension', 'non-genetic hereditary'),
(2, 'Diabetes', 'non-genetic hereditary'),
(3, 'Thalassemia', 'genetic hereditary'),
(4, 'COVID-19', 'infectious'),
(5, 'Scurvy', 'deficiency'),
(6, 'Night Blindness', 'deficiency'),
(7, 'Cystic Fibrosis', 'genetic hereditary'),
(8, 'Flu', 'infectious'),
(9, 'Rickets', 'deficiency'),
(10, 'Hepatitis B', 'infectious');

INSERT INTO Medicine (medicine_id, medicine_name, manufacture_date, expiry_date, price, dosage) VALUES
(1, 'Atenolol', '2023-01-10', '2025-01-10', 25.50, '50mg'),
(2, 'Insulin', '2022-05-15', '2024-11-15', 80.00, '10ml'),
(3, 'Vitamin C', '2023-03-20', '2025-03-20', 10.75, '500mg'),
(4, 'Tamiflu', '2023-02-11', '2024-02-11', 45.00, '75mg'),
(5, 'Genotropin', '2023-07-01', '2026-07-01', 150.00, '4IU'),
(6, 'Zincovit', '2023-08-05', '2025-08-05', 12.30, '1 tablet'),
(7, 'Paracetamol', '2023-06-10', '2025-06-10', 8.90, '500mg'),
(8, 'Penicillin', '2022-11-01', '2024-11-01', 35.00, '250mg'),
(9, 'Albendazole', '2023-10-15', '2025-10-15', 18.00, '400mg'),
(10, 'Hydroxyurea', '2023-12-25', '2026-12-25', 60.00, '500mg');

INSERT INTO Medicine_Disease (medicine_id, disease_id) VALUES
(1, 1),
(2, 2),
(3, 5),
(4, 8),
(5, 7),
(6, 9),
(7, 8),
(8, 4),
(9, 10),
(10, 3);

INSERT INTO Prescription (prescription_id, doctor_id, issuing_date, patient_name) VALUES
(1, 1, '2023-06-01', 'Ali Mohamed'),
(2, 2, '2023-06-03', 'Sara Yasser'),
(3, 3, '2023-06-05', 'Nour Khaled'),
(4, 4, '2023-06-06', 'Hassan Samir'),
(5, 5, '2023-06-07', 'Mona Hesham'),
(6, 6, '2023-06-08', 'Karim Adel'),
(7, 7, '2023-06-09', 'Laila Ibrahim'),
(8, 8, '2023-06-10', 'Fady Emad'),
(9, 9, '2023-06-11', 'Doaa Mahmoud'),
(10, 10, '2023-06-12', 'Nader Hany');

INSERT INTO Prescription_Medicine (prescription_id, medicine_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 7, 3),
(8, 8, 2),
(9, 9, 1),
(10, 10, 2);

SELECT * FROM Doctor;
SELECT * FROM Disease;
SELECT * FROM Medicine;
SELECT * FROM Prescription;
SELECT * FROM Prescription_Medicine;
SELECT * FROM Bill

-- CREATED BY: Youseif Hussein Farghaly , 221000443