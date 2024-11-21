CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    username VARCHAR(50),
    bio TEXT,
    mobile VARCHAR(20),
    has_picture BOOLEAN
);
INSERT INTO students (student_name, username, bio, mobile, has_picture) VALUES
('Бойзода Хаким', 'username1', 'Описание 1', '1234567890', TRUE),
('Абдулло Шовалиев', 'username2', 'Описание 2', '1234567891', FALSE),
('Aziz Abdullaev', 'username3', 'Описание 3', '1234567892', TRUE),
('Jamshed Boboev', 'username4', 'Описание 4', '1234567893', TRUE),
('Farhod Ismailov', 'username5', 'Описание 5', '1234567894', FALSE),
('Farhod JKH', 'username6', 'Описание 6', '1234567895', TRUE),
('Behzod Jumaev', 'username7', 'Описание 7', '1234567896', FALSE),
('Sadriddin Khojazoda', 'username8', 'Описание 8', '1234567897', TRUE),
('Ibodullo Kudratov', 'username9', 'Описание 9', '1234567898', FALSE),
('Munira Kurbanova', 'username10', 'Описание 10', '1234567899', TRUE),
('Alexandra L', 'username11', 'Описание 11', '1234567800', FALSE),
('Alijon Murtazoev', 'username12', 'Описание 12', '1234567801', TRUE),
('Alisher Narzulloev', 'username13', 'Описание 13', '1234567802', FALSE);

CREATE TABLE lessons (
    lesson_id SERIAL PRIMARY KEY,
    lesson_name VARCHAR(100),
    lesson_date DATE,
    attendance BOOLEAN
);

INSERT INTO lessons (lesson_name, lesson_date, attendance)
VALUES 
('Основы SQL', '2023-10-01', TRUE),
('Работа с текстом в SQL', '2023-10-15', TRUE),
('Работа с датами в SQL', '2023-10-22', TRUE),
('Продвинутые запросы в SQL', '2023-11-01', TRUE);

CREATE TABLE scores (
    score_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES students(student_id),
    lesson_id INT REFERENCES lessons(lesson_id),
    score INT
);
INSERT INTO scores (user_id, lesson_id, score)
VALUES 
(1, 1, 85), 
(2, 2, NULL), 
(3, 4, 95);

CREATE VIEW my_results AS
SELECT 
    s.student_id,
    s.student_name,
    s.username,
    s.mobile,
    COUNT(l.attendance) AS lessons_attended,
    AVG(sc.score) AS avg_score
FROM 
    students s
LEFT JOIN scores sc ON s.student_id = sc.user_id
LEFT JOIN lessons l ON sc.lesson_id = l.lesson_id AND l.attendance = TRUE
GROUP BY s.student_id, s.student_name, s.username, s.mobile;
