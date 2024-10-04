CREATE TABLE IF NOT EXISTS customer
(
	customer_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '고객ID',
    name VARCHAR(20) NOT NULL COMMENT '이름',
    phone VARCHAR(15) NOT NULL COMMENT '번호',
    age INT NOT NULL COMMENT '나이',
    email VARCHAR(35) COMMENT '이메일'
  
)
 COMMENT = '고객';
 
 INSERT INTO customer(customer_id, name, phone, age, email) VALUES
 (1, '선동일', '010-6681-7535', 35, 'sun_di@gmail.com'),
 (2, '송종기', '010-4568-6616', 30, 'song_jk@gmail.com'),
 (3, '하이유', '010-4687-1812', 21, null),
 (4, '차태연', '010-6464-3212', 51, 'cha_ty@gmail.com'),
 (5, '임시환', '010-1214-7751', 36, null),
 (6, '이중석', '010-1517-9816', 25, null);
 
 CREATE TABLE IF NOT EXISTS tbl_restaurant
 (
	table_id INT COMMENT '테이블번호',
    capacity INT NOT NULL COMMENT '수용인원',
    location VARCHAR(50) NOT NULL COMMENT '테이블위치'
 )
 COMMENT = '테이블';
 
 INSERT INTO tbl_restaurant(table_id, capacity, location) VALUES
 (1,4, '입구근처'),
 (2,3, '창가자리'),
 (3,6, '홀중앙'),
 (4,2, '주방근처'),
 (5,8, '프라이빗룸');
 
 CREATE TABLE IF NOT EXISTS employee 
 (
	employee_id INT AUTO_INCREMENT COMMENT '직원번호',
    name VARCHAR(20) NOT NULL COMMENT '직원이름',
    phone VARCHAR(20) NOT NULL COMMENT '직원연락처',

  PRIMARY KEY (employee_id)    
 )
 COMMENT = '직원';
 
 INSERT INTO employee(employee_id, name,phone) VALUES
 (1, '홍길동', '010-4468-7874'),
 (2, '유관순', '010-4817-4438'),
 (3, '이순신', '010-3512-6873'),
 (4, '세종대왕', '010-1873-4787'),
 (5, '신사임당', '010-4545-7878');

CREATE TABLE IF NOT EXISTS reservation
(
	reservation_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '예약번호',
    reservation_date VARCHAR(50) NOT NULL COMMENT '예약날짜',
    reservation_time TIME NOT NULL COMMENT '예약시간',
    guest_count INT NOT NULL COMMENT '예약인원',
    guest_name VARCHAR(50) NOT NULL COMMENT '예약자이름',
    note VARCHAR(50) COMMENT '메모사항',
    table_id INT COMMENT '테이블번호',
    employee_id INT COMMENT '직원번호',
    FOREIGN KEY(table_id) REFERENCES tbl_restaurant(table_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)  
)
COMMENT = '예약';

INSERT INTO reservation(reservation_date, reservation_time, gcs_count, note, guest_name, table_id, employee_id) VALUES
('24-11-11','18:00:00',2,null,'선동일',4,1),
('24-11-21','18:30:00',4,'birthday_party','송종기',3,2),
('24-12-10','19:30:00',6,null,'하이유',3,3),
('24-12-18','13:00:00',4,'business_lunch','이중석',5,4),
('24-12-25','19:30:00',5,null,'임시환',4,5);


