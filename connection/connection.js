import pkg from 'pg'
import dotenv from 'dotenv'
dotenv.config()
const {Client}=pkg
const client=new Client({
    host:"localhost",
    database:'postgres',
    user:process.env.USER,
    password:process.env.PASSWORD,
    port:5432,
})


client.connect().then((err,res)=>{
    if(err){
        console.log(err)
    }
    console.log('hi')
}).catch((e)=>console.log(e))


const query=`CREATE TABLE Result(
    Exam_id serial primary key ,
    Total_marks float not null,
    Grade varchar not null
)`
try{
    await client.query(query)
    console.log("Table created for result")
}catch(err){
    console.log(err.message)
}
try{
const query1=`CREATE TABLE Student
( Student_id int primary key,
    Exam_id int,
Student_name varchar not null,
Student_email varchar not null,
Student_phone_number int not null,
Student_birthday date not null,
Student_sex varchar not null,
Student_address varchar not null,
Student_reg_year date not null,
Student_password varchar not null ,
CONSTRAINT FOREIGN_ST FOREIGN KEY (Exam_id)  REFERENCES Result(Exam_id))`;
await client.query(query1)
console.log("Table created for student")
}
catch(err){
    console.error(err.message)

}
const query2=`CREATE TABLE Question(
    Question_id  serial primary key not null,
    Question_number int,
    ans_A varchar,
    ans_B varchar,
    ans_C varchar,
    ans_D varchar,
    ans_correct varchar

)`
try{
    await client.query(query2)
    console.log("Table created for Question")
}catch(err){
    console.log(err.message)
}
const query3=`CREATE TABLE Teacher(
    Teacher_id serial primary key not null,
    Question_id int,
    Teacher_reg_year date not null,
    Teacher_address varchar,
    Teacher_password varchar not null,
    Teacher_email varchar not null,
    Teacher_sex varchar not null,
    Teacher_phone_number int not null,
    Teacher_name varchar not null,
    FOREIGN KEY (Question_id) REFERENCES Question(Question_id)
)`
try{await client.query(query3)
    console.log("Table created for Teacher")}catch(err){
        console.log(err.message)
        
    }
const query4=`CREATE TABLE Administor(Admin_id int primary  key , A_name varchar not null, A_address varchar,Student_id int,Exam_id int,Question_id int,Teacher_id int,  A_email varchar not null,  A_phone_number int ,  A_password   varchar   not  null,  FOREIGN KEY   (Student_id)   REFERENCES   Student(Student_id), FOREIGN KEY  (Exam_id)   REFERENCES   Result(Exam_id), FOREIGN KEY  (Teacher_id)  REFERENCES Teacher(Teacher_id), FOREIGN KEY (Question_id) REFERENCES Question(Question_id))`
try{
await client.query(query4)
console.log("Table created for administor")
}
catch(err){
    console.error(err.message)
}
const query5=`INSERT INTO Result(Total_marks,Grade) VALUES(23.2,'A')`
try{
await client.query(query5)
console.log("data inserted successfully")
}
catch(e){
    console.log(e.message)
}
const query6=`select * from  Result`;
try{
 await client.query(query6, (err, res) => {
        if (err) {
            console.log(err.message)
            return
        }
        for(let row of res.rows){
              console.log(row)
        }
        
    })   
}catch(e){
    console.log(e)
}
finally{
    client.end()
}

export default client