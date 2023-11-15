# dbiASM
A slight description and overall of our Assignment of DatabaseIntro in FPT Uni


TABLE OF CONTENTS
I)	INTRODUCE THE PROBLEM…………………………………………………………………………………………….
1)	DESCRIBE THE PROBLEM……………………………………………………………………………………………………….
2)	MANAGEMENT OBJECTIVES…………………………………………………………………………………………………..

II)	ENTITY – RELATIONSHIP – ER…………………………………………………………………………………………
1)	DEFINITION ENTITY – ATTRIBUTE…………………………………………………………………………………………..
2)	SET-UP ENTITY – RELATIONSHIP…………………………………………………………………………………………….

III)	DATA DICTIONARY………………………………………………………………………………………………………….
1)	DEFINITION OF TABLES………………………………………………………………………………………………………….
1)	SET-UP TRIGGER…………………………………………………………………………………………………………………….

IV)	QUERY………………………………………………………………………………………………………….



I)	INTRODUCE THE PROBLEM
1,	DESCRIBE THE PROBLEM
FPT Universities are experiencing rapid growth in the number of students and require an efficient data management system to keep track of individual student information. Currently, student information is stored in various files, books, and unrelated systems, leading to complexity in information retrieval, semester tracking, and report generation. 
With the advancement of technology, the school wants to build an automated and integrated student management database to help them monitor the learning progress, manage academic-related data, and provide specific information to stakeholders such as parents and regulatory authorities. 
We, group 7, intend to create one of the basic realist databases to ensure perfection in managing students’ info. After a time of consideration, we’ve decided to give out these results: 
•	Students, recruited by FPT, all have their own information,
which is required as their entrance conditions. Diving deeper into the semester, 
Unis will use that info to define and group students by certain groups of info.
•	Students: in sum, students’ personal info, both for Uni entrance conditions and for management.
•	Major: Each student admitted to the Uni has the right to choose 1 in a whole listed Major, though each still has their own variety, which can be found suitable for any student.
•	Course: Belong to the Major, we have a course, that introduces the students to a long session of lectures but separated in general, 
courses will differ based on the Major that the students choose.
Courses in a semester will connect to each other as a condition, for example: you need to finish PRO in the previous semester to learn LAB in the succeeding semester.
•	Assessment: These are like qualification tests for the students, to show how and in which method the student studied over the past semester effectively, besides, each alternative will have its own minimum required score, which will be based on the importance of the assessment.
•	Results: During the whole semester, students will have to face and conquer a diversity of points, included in an academic transcript then to 
evaluate the student’s effort and performance during the process. And consider if they either have to retake the course or the final exam.
•	Penalty: Talking about the results, for the students who performed effortlessly in the past semester, or in any other situation that they cannot pass the final exam and achieve the desired MINIMUM results, they will then have to face a thing called course retake fee. These will even based on when and how soon you started to retake those courses. Other than that, students who cheat or vandalize, etc... that interfere with the Uni’s rules, will also have to face fees or even disqualification.

	 Main Goal:
This database aims to help monitor students' learning progress and manage academic-related data. It intends to streamline the management of students' personal information, majors, courses, assessments, results, and penalties to ensure efficient data management within the educational institution.

________________________________________
II)	ENTITY – RELATIONSHIP – ER
1)	DEFINITION ENTITY – ATTRIBUTE
Given the problem description and management goals, we can outline various entities and their associated attributes as follows: 	
-	Student: Store a student’s information
StudentID,  First Name, Last Name, MajorID, Sex, DateOfBirth, Address, EnrollYear, Email, Scholarship.
o	EnrollYear: The year in which that student enrolls at the school.
o	Scholarship: The scholarship of a student, from 0 means no scholarship, to 1 means full scholarship.
-	Study : Store information about courses the students study 
StudentID, CourseId, Semester , AverageScore
o	AverageScore: The average score of a course of a student study in a semester.
-	Major: Store information about the majors the school has
MajorID, Name.
-	Penalty: Store information about the penalty of students
StudentID, PenaltyName, Fee, Date, Details
o	Date: The date on which the penalty occurred.
o	Details: The reason for the penalty.
-	Course: Store information about the courses the school provides
CourseID, CourseName, NumberOfAssessments.
o	NumberOfAssessments: The number of assessments this course has.
-	Assessment: Store information about the assessments the courses have
AssessmentID, AssessmentName, CourseID, PassingScore, Weight
o	PassingScore: The minimum score for passing this particular assessment. Students have to pass all the assessments to pass a course.
o	Weight: The weight of this assessment to the overall score of a course (eg: Weight=0.4 means the assessment take 40% of the overall score)
-	Result: Store the results of each assessment
StudentID, CourseID, AssessmentID, Semester, Score
-	Prerequisite: Store information about courses that have prerequisite courses that need to be passed before studying
CourseID, PrerequisiteID.

2)	SET-UP ERD

•	Key/identifier attribute
	

•	Attribute description/description
	
•	Entity
	

•	Weak entity
	

•	Relationship
	

•	Connectivity (force) = 1
	

•	Connectivity = N	

    

________________________________________

 
	________________________________________
 

III)	DATA DICTIONARY
Just for example on some tables (other table are similar, you have to define all the tables in your database). Note: to run the query you have to define the table 1 first then go to the side tables much
1)	DEFINITION OF TABLES

A.	TABLE STUDENT
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
StudentID	Varchar(10)			PK, Not null
LastName	nvarchar(50)			not null
FirstName	nvarchar(50)			not null
MajorId	varchar(5)			FK references Major(MajorId)
Sex	char(1)		‘F’ or ‘M’	not null
DateOfBirth	date			
Address	nvarchar(100)			
EnrollYear	int			not null
Email	varchar(50)			not null
Schoolarship	float	0.0	>=0 and <= 1	not null



B.	TABLE MAJOR
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
MajorId	varchar(5)			PK
Name	nvarchar(50)			not null



C.	TABLE COURSE
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
CourseId	varchar(10)			PK
CourseName	nvarchar(50)			not null
NumberOfAssessments	int		>= 0	not null


D.	TABLE PREREQUISITE
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
CourseId	varchar(10)			unique, FK references Course(CourseId)
PrerequisiteId	varchar(10)			unique, FK references Course(CourseId)


E.	TABLE STUDY
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
StudentId	varchar(10)			PK, FK references Student(StudentId)
CourseId	varchar(10)			PK, FK references Course(CourseId)
Semester	varchar(10)			PK
AverageScore	float	0.0	>= 0 and <= 10	


F.	TABLE ASSESSMENT
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
AssessmentId	varchar(10)			PK
AssessmentName	nvarchar(50)			not null
CourseId	varchar(10)			PK, FK references Course(CourseId)
PassingScore	float		>= 0 and <= 10	not null
Weight	float		> 0 and <= 1	not null


G.	TABLE RESULT
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
AssessmentId	varchar(10)			PK
StudentId	varchar(10)			PK, FK references Student(StudentId)
CourseId	varchar(10)			PK, FK references Assessment(CourseId)
AssessmentId	varchar(10)			PK, FK references Assessment(AssessmentId)
Semester	varchar(10)			PK
Score	float	0	>= 0 and <= 10	not null


H.	TABLE PENALTY
Column Name	Data Type	Default	Check	Key/ Index/ Constraint
StudentId	varchar(10)			PK, FK references Student(StudentId)
PenaltyName	nvarchar(50)			PK
Fee	money			
Date	date			PK
Details	nvarchar(200)			
StudentId	varchar(10)			PK, FK references Student(StudentId)




2)	SET-UP TRIGGER
* PLEASE READ IN DOCX FILE

