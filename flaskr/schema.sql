DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS instructor;
DROP TABLE IF EXISTS lecture;

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    hashed_password TEXT NOT NULL,
    created_date DATETIME NOT NULL
);

CREATE TABLE course (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    detail TEXT NOT NULL,
    created_date DATETIME NOT NULL
);

CREATE TABLE student (
    user_id INTEGER REFERENCES user(id),
    course_id INTEGER REFERENCES course(id)
);

CREATE TABLE instructor (
    user_id INTEGER REFERENCES user(id),
    course_id INTEGER REFERENCES course(id)
);

CREATE TABLE lecture (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER REFERENCES course(id),
    path_url TEXT
);