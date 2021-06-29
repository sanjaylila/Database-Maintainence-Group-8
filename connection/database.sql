
CRAETE Table Administor(
    Admin_id serial primary key not null,
    A_name varchar(30) not null,
    Exam_id INT (),
    Teacher_id INT(),
    Question_id INT(),
    Student_id INT()
    A_address varchar(30),
    A_email varchar(30) not null,
    A_phone_number int(10),
    A_password varchar(30) not null,
    FOREIGN KEY (Student_id) REFERENCE Student(Student_id),
    FOREIGN KEY (Exam_id) REFERENCE Result(Exam_id),
    FOREIGN KEY (Teacher_id) REFERENCE Teacher(Teacher_id),
    FOREIGN KEY (Question_id) REFERENCE Question(Question_id),
)
CRAETE Table Student(
    Student_id serial primary key not null,
    Student_name varchar(30),
     Exam_id INT (),
    Student_email varchar(30) not null,
    Student_phone_number int(30) not null,
    Student_birthday date not null,
    Student_sex varchar(10) not null,
    Student_address varchar(30) not null,
    Student_reg_year date not null,
    Student_password varchar(30) not null ,
    FOREIGN KEY (Exam_id) REFERENCE Result(Exam_id),
)
CRAETE Table Result(
    Exam_id serial primary key ,
    
    
    Total_marks float(10) not null,
    Grade varchar(2) not null,
)
CRAETE Table Teacher(
    Teacher_id serial primary key not null,
    Question_id INT(),
    Teacher_reg_year date not null,
    Teacher_address varchar(30),
    Teacher_password varchar(30) not null,
    Teacher_email varchar(30) not null,
    Teacher_sex varchar(10) not null,
    Teacher_phone_number int(10) not null,
    Teacher_name varchar(30) not null,
    FOREIGN KEY (Question_id) REFERENCE Question(Question_id),
)
CRAETE Table Question(
    Question_id serial primary key not null,
    Question_number int(10),
    ans_A varchar(10),
    ans_B varchar(10),
    ans_C varchar(10),
    ans_D varchar(10),
    ans_correct varchar(10)

)
export default maintain;