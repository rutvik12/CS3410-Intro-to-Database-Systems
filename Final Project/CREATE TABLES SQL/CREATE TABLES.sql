USE COMPANY 
GO

CREATE TABLE DEPARTMENT(
DepartmentID                 int            NOT NULL IDENTITY(500,1),
DepartmentName               varchar(50)    NOT NULL,
DepartmentNumber             int            NOT NULL,
DepartmentManager            varchar(50)    NULL,
DepartmentManagerStartDate   date           NULL,
CONSTRAINT                   DepartmentPK   PRIMARY KEY(DepartmentID),
CONSTRAINT                   DepartmentAK1  UNIQUE(DepartmentNumber),
);

CREATE TABLE PROJECT(
ProjectID                     int            NOT NULL IDENTITY(5000,1),
ProjectName                   varchar(50)    NOT NULL,
ProjectNumber                 int            NOT NULL,
ProjectLocation               varchar(50)    NOT NULL,
DepartmentID	                int            NOT NULL,
CONSTRAINT                    ProjectPK      PRIMARY KEY(ProjectID),
CONSTRAINT                    ProjectAK1     UNIQUE(ProjectNumber),
CONSTRAINT                    DepartmentFK   FOREIGN KEY(DepartmentID)
                              REFERENCES DEPARTMENT(DepartmentID)
                              ON DELETE NO ACTION
);

CREATE TABLE EMPLOYEE(
EmployeeID                     int            NOT NULL IDENTITY(100,1),
EmployeeName                   varchar(50)    NOT NULL,
EmployeeSSN                    int            NOT NULL,
EmployeeAddress               varchar(255)    NULL,
EmployeeSalary	              int             NULL,
EmployeeSex                   varchar(25)     NULL,
EmployeeDOB                   date            NULL,
EmployeeSupervisor            varchar(50)     NULL,
DepartmentID                  int             NOT NULL,
CONSTRAINT                    EmployeePK      PRIMARY KEY(EmployeeID),
CONSTRAINT                    EmployeeAK1     UNIQUE(EmployeeName),
CONSTRAINT                    Emp_DepartmentFK   FOREIGN KEY(DepartmentID)
                              REFERENCES DEPARTMENT(DepartmentID)
                              ON DELETE NO ACTION,
CONSTRAINT                    Employee_SupervisorFK  FOREIGN KEY(EmployeeSupervisor)
                              REFERENCES EMPLOYEE(EmployeeName)
							  ON UPDATE NO ACTION
							  ON DELETE NO ACTION,
);

CREATE TABLE EMPLOYEE_HOURS_PER_WEEK(
EmployeeID	             int        NOT NULL,
ProjectID                int        NOT NULL,
PayDate                  date       NOT NULL,
HoursPerWeek             int        NOT NULL,
CONSTRAINT          EmployeeHoursPK   PRIMARY KEY(EmployeeID, ProjectID, PayDate),
CONSTRAINT          Hours_EmployeeFK        FOREIGN KEY(EmployeeID)
                    REFERENCES EMPLOYEE(EmployeeID)
                    ON DELETE CASCADE,         
CONSTRAINT          Hours_ProjectFK         FOREIGN KEY(ProjectID)
                    REFERENCES PROJECT(ProjectID)
                    ON DELETE CASCADE, 
);

CREATE TABLE EmployeeDependent(  
DependentFirstName       varchar(50)   NOT NULL,
EmployeeID               int           NOT NULL,
DependentSex             varchar(25)   NULL,
DependentDOB             date          NULL,
CONSTRAINT           EmployeeDependentPK    PRIMARY KEY(DependentFirstName, EmployeeID),
CONSTRAINT           Dependent_EmployeeFK             FOREIGN KEY(EmployeeID)
                         REFERENCES EMPLOYEE(EmployeeID)
                           ON DELETE CASCADE,
);

CREATE TABLE LOCATION( 
DepartmentLocation           varchar(255)     NOT NULL,
DepartmentID                 int              NOT NULL,
CONSTRAINT                LocationPK       PRIMARY KEY(DepartmentID, DepartmentLocation),
CONSTRAINT                Location_DepartmentFK     FOREIGN KEY(DepartmentID)
                            REFERENCES  DEPARTMENT(DepartmentID)
                               ON DELETE CASCADE,
);

