go
create database Niggars

-- Ngành học
create table Major(
	[MajorId] varchar(5) primary key,
	[Name] nvarchar(50) not null
);

-- Sinh viên
create table Student(
	[StudentId] varchar(10) primary key, -- Mã học sinh, vd: HE180053
	[LastName] nvarchar(50) not null,
	[FirstName] nvarchar(50) not null,
	[MajorId] varchar(5) foreign key references [Major]([MajorId]) not null,
	[Sex] char(1) not null,
	[DateOfBirth] date, -- format: yyyy-mm-dd
	[Address] nvarchar(100),
	[EnrollYear] int not null,
	[Email] varchar(50) not null -- mail fpt
);

-- Môn học
create table Course(
	[CourseId] varchar(10) primary key,
	[CourseName] nvarchar(50) not null
);

-- Quan hệ M-M giữa Student và Course
create table Study(
	[StudentId] varchar(10) foreign key references [Student]([StudentId]),
	[CourseId] varchar(10) foreign key references [Course]([CourseId]),
	[Semester] varchar(10), -- Kỳ mà học sinh đấy học môn này, vd: FA23, SU23,...
	[Grade] varchar(10), -- Cái này là kết quả môn học, điểm chữ từ F -> A+, F là trượt môn, cái này sẽ được update dựa theo Result
	primary key([StudentId], [CourseId], [Semester])
);

-- Các đầu điểm tương ứng với từng môn học
create table Assessment(
	[AssessmentId] varchar(10),
	[AssessmentName] nvarchar(50) not null,
	[CourseId] varchar(10) foreign key references [Course]([CourseId]),
	[PassingScore] float not null, -- Điểm ít nhất để pass đầu điểm này
	primary key([AssessmentId], [CourseId])
);

-- Kết quả của từng đầu điểm
create table Result(
	[StudentId] varchar(10) foreign key references [Student]([StudentId]),
	[CourseId] varchar(10),
	[AssessmentId] varchar(10),
	[Semester] varchar(10),
	[Score] float not null, -- Cái này sẽ so sánh với Assessment.PassingScore, sau đó update Study.Grade
	primary key([StudentId], [CourseId], [AssessmentId], [Semester]),
	foreign key([CourseId], [AssessmentId]) references [Assessment]([AssessmentId], [CourseId])
);

-- Phạt
create table Penalty(
	[StudentId] varchar(10) foreign key references [Student]([StudentId]),
	[PenaltyName] nvarchar(50), -- Tên hình phạt, vd: Phạt vi phạm quy chế, Phạt học lại,...
	[Fee] money, -- Tiền phạt
	[Date] date not null, -- format: yyyy-mm-dd
	[Details] nvarchar(200), -- Chi tiết hình phạt, vd: sử dụng phần mềm trái quy định,...
	primary key([StudentId], [PenaltyName])
);

--
-- Thêm trọng số vào mỗi Assessment, và thêm số đầu điểm vào trong Course
alter table Course
add [NumberOfAssessments] int not null check([NumberOfAssessments] >= 0);
alter table Assessment
add [Weight] float not null check([Weight] > 0 and [Weight] <= 1);

-- Thêm học bổng vào Student
alter table Student
add [Schoolarship] float not null default(0.0) check([Schoolarship] >= 0.0 and [Schoolarship] <= 1.0);

-- Thêm constraints vào các thuộc tính
alter table Student
add check([Sex] in ('M', 'F'));
alter table Assessment
add check([PassingScore] >= 0 and [PassingScore] <= 10);
alter table Result
add check([Score] >= 0 and [Score] <= 10);

-- Thêm AverageScore vào Study
alter table Study
drop column [Grade];
alter table Study
add [AverageScore] float default(0.0) check([AverageScore] >= 0.0 and [AverageScore] <= 10.0);