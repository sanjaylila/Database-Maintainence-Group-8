--Creating Database and schemas 

-- first run this code separately in query tool:- create database online_test;

-- then open query tool for online_test database and run this following sql code


CREATE SCHEMA online_test_schema;

-- Administrator table

CREATE TABLE online_test_schema.administrator
(
    admin_id serial NOT NULL ,
    a_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    a_address character varying(150) COLLATE pg_catalog."default",
    a_email character varying(320) COLLATE pg_catalog."default",
    a_password character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT administrator_pkey PRIMARY KEY (admin_id)
);

-- Multivalue Table of Administrator Phone_no

CREATE TABLE online_test_schema.administrator_phno
(
    admin_id integer NOT NULL,
    a_phoneno integer NOT NULL,
    CONSTRAINT administrator_phno_pkey PRIMARY KEY (a_phoneno, admin_id),
    CONSTRAINT administrator_phno_admin_id_fkey FOREIGN KEY (admin_id)
        REFERENCES online_test_schema.administrator (admin_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Students table

CREATE TABLE online_test_schema.student
(
    student_id serial NOT NULL,
    s_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    s_address character varying(150) COLLATE pg_catalog."default",
    s_email character varying(320) COLLATE pg_catalog."default" NOT NULL,
    s_password character varying(30) COLLATE pg_catalog."default" NOT NULL,
    s_dept character varying(40) COLLATE pg_catalog."default",
    s_reg_year integer NOT NULL,
    s_sex character varying(9) COLLATE pg_catalog."default",
    s_birthdate date,
    admin_id integer NOT NULL,
    CONSTRAINT student_pkey PRIMARY KEY (student_id),
    CONSTRAINT student_admin_id_fkey FOREIGN KEY (admin_id)
        REFERENCES online_test_schema.administrator (admin_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Multivalue Table of Students Phone no

CREATE TABLE online_test_schema.student_phno
(
    student_id integer NOT NULL,
    s_phoneno integer NOT NULL,
    CONSTRAINT student_phno_pkey PRIMARY KEY (student_id, s_phoneno),
    CONSTRAINT student_phno_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES online_test_schema.student (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Teachers table

CREATE TABLE online_test_schema.teacher
(
    teacher_id serial NOT NULL ,
    t_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    t_address character varying(150) COLLATE pg_catalog."default",
    t_email character varying(320) COLLATE pg_catalog."default" NOT NULL,
    t_password character varying(30) COLLATE pg_catalog."default" NOT NULL,
    t_dept character varying(40) COLLATE pg_catalog."default",
    t_reg_year integer NOT NULL,
    t_sex character varying(9) COLLATE pg_catalog."default",
    t_birthdate date,
    admin_id integer NOT NULL,
    CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id),
    CONSTRAINT teacher_admin_id_fkey FOREIGN KEY (admin_id)
        REFERENCES online_test_schema.administrator (admin_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Multivalue Table of Teachers Phone no

CREATE TABLE online_test_schema.teacher_phno
(
    teacher_id integer NOT NULL,
    t_phoneno integer NOT NULL,
    CONSTRAINT teacher_phno_pkey PRIMARY KEY (teacher_id, t_phoneno),
    CONSTRAINT teacher_phno_teacher_id_fkey FOREIGN KEY (teacher_id)
        REFERENCES online_test_schema.teacher (teacher_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Module Table

CREATE TABLE online_test_schema.module
(
    module_no serial NOT NULL,
    mod_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    mod_type character varying(50) COLLATE pg_catalog."default",
    mod_credit integer NOT NULL,
    mod_dept character varying(50) COLLATE pg_catalog."default",
    admin_id integer NOT NULL,
    CONSTRAINT module_pkey PRIMARY KEY (module_no),
    CONSTRAINT module_admin_id_fkey FOREIGN KEY (admin_id)
        REFERENCES online_test_schema.administrator (admin_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

--Multivalue Table of Modules Pre requisite

CREATE TABLE online_test_schema.module_pre_requisite
(
    module_no integer NOT NULL,
    pre_requisite character varying(100) NOT NULL COLLATE pg_catalog."default",
    CONSTRAINT module_pre_requisite_pkey PRIMARY KEY (module_no,pre_requisite),
    CONSTRAINT module_pre_requisite_module_no_fkey FOREIGN KEY (module_no)
        REFERENCES online_test_schema.module (module_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Exam Table

CREATE TABLE online_test_schema.exam
(
    exam_id serial NOT NULL,
    time_ time without time zone NOT NULL,
    exam_type character varying(50) COLLATE pg_catalog."default",
    no_of_question integer NOT NULL,
    CONSTRAINT exam_pkey PRIMARY KEY (exam_id)
);

-- Question Table

CREATE TABLE online_test_schema.question
(
    question_id serial NOT NULL ,
    question character varying(200) COLLATE pg_catalog."default",
    ans_a character varying(200) COLLATE pg_catalog."default",
    ans_b character varying(200) COLLATE pg_catalog."default",
    ans_c character varying(200) COLLATE pg_catalog."default",
    ans_d character varying(200) COLLATE pg_catalog."default",
    ans_correct character varying(200) COLLATE pg_catalog."default",
    exam_id integer NOT NULL,
    CONSTRAINT question_pkey PRIMARY KEY (question_id),
    CONSTRAINT question_exam_id_fkey FOREIGN KEY (exam_id)
        REFERENCES online_test_schema.exam (exam_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Weak entity Tables
-- Result Table

CREATE TABLE online_test_schema.result
(
    student_id integer NOT NULL,
    grade character varying(3) COLLATE pg_catalog."default",
    exam_id integer NOT NULL,
    total_marks numeric DEFAULT 0.0,
    CONSTRAINT result_pkey PRIMARY KEY (student_id, exam_id),
    CONSTRAINT result_exam_id_fkey FOREIGN KEY (exam_id)
        REFERENCES online_test_schema.exam (exam_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT result_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES online_test_schema.student (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Answersheet Table

CREATE TABLE online_test_schema.ans_sheet
(
    exam_id integer NOT NULL,
    student_id integer NOT NULL,
    ques_id integer NOT NULL,
    student_ans character varying COLLATE pg_catalog."default" NOT NULL,
    ans_cw character varying COLLATE pg_catalog."default" NOT NULL,
    mark_q integer NOT NULL,
    CONSTRAINT ans_sheet_pkey PRIMARY KEY (exam_id, student_id, ques_id),
    CONSTRAINT ans_sheet_exam_id_fkey FOREIGN KEY (exam_id)
        REFERENCES online_test_schema.exam (exam_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT ans_sheet_ques_id_fkey FOREIGN KEY (ques_id)
        REFERENCES online_test_schema.question (question_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT ans_sheet_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES online_test_schema.student (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Many to Mant Relation Table
-- Student-Module table

CREATE TABLE online_test_schema.r_student_module
(
    module_no integer NOT NULL,
    student_id integer NOT NULL,
    CONSTRAINT r_student_module_pkey PRIMARY KEY (module_no, student_id),
    CONSTRAINT r_student_module_module_no_fkey FOREIGN KEY (module_no)
        REFERENCES online_test_schema.module (module_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT r_student_module_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES online_test_schema.student (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Teachers-Module table

CREATE TABLE online_test_schema.r_teacher_module
(
    module_no integer NOT NULL,
    teacher_id integer NOT NULL,
    PRIMARY KEY (module_no, teacher_id),
    FOREIGN KEY (module_no)
        REFERENCES online_test_schema.module (module_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (teacher_id)
        REFERENCES online_test_schema.teacher (teacher_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Exam-Module table

CREATE TABLE online_test_schema.r_exam_module
(
    module_no integer NOT NULL,
    exam_id integer NOT NULL,
    PRIMARY KEY (module_no, exam_id),
    FOREIGN KEY (module_no)
        REFERENCES online_test_schema.module (module_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (exam_id)
        REFERENCES online_test_schema.exam (exam_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);





