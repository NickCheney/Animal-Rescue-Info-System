use animalRescueInfo;

create table Organization(
	ID		varchar(50) not null,
	name 		varchar(50) not null,
	address 	varchar(100) not null,
	phone_num 	char(10) not null,
	ownr_ID		varchar(50),
	primary key(ID)
);

create table Employee(
	emp_ID	varchar(50) not null,
	fname		varchar(50) not null,
	lname		varchar(50) not null,
	address 	varchar(100) not null,
	phone_num	char(10) not null,
	org_id	 	varchar(100) not null,
	primary key(emp_ID),
	foreign key(org_id) references Organization(ID)
	on delete cascade
);

create table SPCA_Branch(
	ID 		varchar(50) not null,
	primary key(ID),
	foreign key(ID) references Organization(ID) on delete cascade
);

create table Rescuer_Org(
	ID 		varchar(50) not null,
	primary key(ID),
	foreign key(ID) references Organization(ID) on delete cascade
);

create table Shelter(
	ID 		varchar(50) not null,
	url		varchar(100) not null,
	primary key(ID),
	foreign key(ID) references Organization(ID) on delete cascade
);

create table Donation(
	payment_id	char(10) not null,
	fname_payee	varchar(50) not null,
	lname_payee 	varchar(50), #last name null if organization donates
	org_ID 	varchar(50) not null,
	amount	decimal(15,2) not null,
	don_date	date not null,
	primary key(payment_id),
	foreign key(org_ID) references Organization(ID)
);

create table Adopter(
	family_name	varchar(50) not null,
	phone_num	char(10) not null,
	address 	varchar(100) not null,
	primary key(family_name, phone_num)
);

create table Driver(
	fname		varchar(50) not null,
	lname		varchar(50) not null,
	license_number 	char(15) not null,
	license_plate 	char(7) not null,
	phone_num	char(10) not null,
	primary key(license_number)
);

create table DrivesFor(
	Lic_num		char(15) not null,
	resc_ID		varchar(50) not null,
	Primary key(lic_num, resc_ID),
	Foreign key(lic_num) references Driver(license_number) on delete cascade,
	Foreign key(resc_ID) references Rescuer_Org(ID)

);


create table Animal(
	ID 			char(10) not null,
	species		varchar(50) not null,
	adopt_fam_name 	varchar(50),
	adopt_phone_num 	char(10),
	adopt_fee 		decimal(10,2),
	primary key(ID),
	foreign key(adopt_fam_name, adopt_phone_num) references Adopter(family_name, phone_num)
);

Create table Relocates(
	animal_ID 		char(10) not null,
	org_ID			varchar(50) not null,
	Fee			decimal(10,2),
	move_Date		date not null,
	Primary key(animal_ID, org_ID),
	Foreign key(animal_ID) references Animal(ID),
	Foreign key(org_ID) references Organization(ID)
);

Create table Transports(
	driver_lic_num 	char(15) not null,
	pickup_ID 		varchar(50) not null,
	dropoff_ID		varchar(50) not null,
	animal_ID			char(10) not null,
	Primary key(driver_lic_num, pickup_ID, animal_ID),
	foreign key(driver_lic_num) references Driver(license_number),
	foreign key(animal_ID) references Animal(ID),
	Foreign key(pickup_ID) references SPCA_Branch(ID),
	Foreign key(dropoff_ID) references Shelter(ID),
	Foreign key(animal_ID, dropoff_ID) references Relocates(animal_ID, org_ID)
);


create table Vet(
	vetID 		char(10) not null,
	fname 		varchar(50) not null,
	lname 		varchar(50) not null,
	primary key(vetID)
);

create table Capacity(
	species 		varchar(50) not null,
	max_num 	integer not null,
	sltr_ID 		varchar(50) not null,
	primary key(species, sltr_ID),
	foreign key(sltr_ID) references Shelter(ID)
	on delete cascade
);

create table Visits(
	animal_id 	char(10) not null,
	vet_id 		char(10) not null,
	appt_date 	date not null,
	condit 		varchar(200) not null,
	weight 		decimal(7,3) not null,
	primary key(animal_id, vet_id),
	foreign key(animal_id) references Animal(ID) on delete cascade,
	foreign key(vet_id) references Vet(vetID)
);

delete from Organization;
delete from Employee;
delete from SPCA_Branch;
delete from Rescuer_Org;
delete from Shelter;
delete from Donation;
delete from Adopter;
delete from Driver;
delete from DrivesFor;
delete from Animal;
delete from Transports;
delete from Relocates;
delete from Vet;
delete from Capacity;
delete from Visits;


insert into Organization values ('123456789', 'Kingston SPCA', '20 Brock St, Kingston, Ontario, K7L1M1','6133928901', '7492349283789');
insert into Organization values ('100000000', 'Cataraqui SPCA', '123 Electric Ave, Kingston, Ontario, K7L1G6','6131111111', '5656565656');

insert into Organization values ('13091239811', 'Kingston Animal Shelter','30 Division St, Kingston, Ontario, K7L3F2','6134893029', '193082039');
insert into Organization values ('13579111315', 'Cataraqui Animal Shelter','30 Brock St, Kingston, Ontario, K7L1K3','6132222222', '1500000000');

insert into Organization values ('91028391028', 'Kingston Animal Rescue', '45 Union St, Kingston, Ontario, K7L2B3', '6134902893', '102938120');
insert into Organization values ('99999999999', 'Swamp Monsters Animal Rescue', '85 Rocky Rd, Kingston, Ontario, K7L2H2', '6139999999', '2000000000');

	/* SPCA Employees*/
insert into Employee values ('93120381', 'Kanye', 'West', '30 Malibu Drive, Kingston, Ontario, K7L3B3', '9056127389', '123456789');
insert into Employee values ('30239482', 'Travis', 'Scott', '29 Third Line, Kingston, Ontario, K7L0U2', '6139028902', '123456789');
insert into Employee values ('7492349283789', 'Big', 'Bossman', '20 Dundas Road, Kingston, Ontario, K7L8J8', '6137890219', '123456789');

insert into Employee values ('5656565656', 'Rick', 'Harrison', '30 Chevy Drive, Kingston, Ontario, K7L3C3', '9056100000', '100000000');
insert into Employee values ('8000000000', 'Chum', 'Lee', '45 Chevy Drive, Kingston, Ontario, K7L3C3', '9056100002', '100000000');

	/* Shelter Employees*/
insert into Employee values ('30128310', 'Steven', 'Speilberg', '332 Sequel Road, Kingston, Ontario, K7L0B2', '6139482789', '13091239811');
insert into Employee values ('901283131', 'Mark', 'Whalberg', '90 Splatoon Street, Kingston, Ontario, K7L0U3', '6139280931', '13091239811');
insert into Employee values ('193082039', 'Lil', 'Bossman', '80 Toronto Road, Kingston, Ontario, K7L3YB', '6132890172', '13091239811');

insert into Employee values ('1500000000', 'Lil', 'Basedgod', '88 Toronto Road, Kingston, Ontario, K7L3YB', '6132890192', '13579111315');
insert into Employee values ('1500000001', 'Big', 'Basedgod', '88 Toronto Road, Kingston, Ontario, K7L3YB', '6132890193', '13579111315');


	/* Rescuer Employees*/
insert into Employee values ('82301810', 'Zooey', 'Deschanel', '500 Summer Road, Kingston, Ontario, K7L0Y2', '6131792091', '91028391028');
insert into Employee values ('03912893', 'Rooney', 'Mara', '389 Tattoo Avenue, Kingston, Ontario, K7L7B2', '6137849281', '91028391028');
insert into Employee values ('102938120', 'Medium', 'Bossman', '6th Avenue, Kingston, Ontario, K7L9B2', '6139876289', '91028391028');

insert into Employee values ('2000000000', 'Rick', 'Ross', '18 Perky Ln, Kingston, Ontario, K7P9B2', '6138888888', '99999999999');
insert into Employee values ('2000000001', 'Rick', 'Ross Jr.', '18 Perky Ln, Kingston, Ontario, K7P9B2', '6138888889', '99999999999');

alter table Organization add foreign key (ownr_ID) references Employee(emp_ID);

insert into SPCA_Branch values ('123456789');
insert into SPCA_Branch values ('100000000');

insert into Rescuer_Org values ('91028391028');
insert into Rescuer_Org values ('99999999999');

insert into Shelter values ('13091239811', 'www.KingstonAnimalShelter.ca');
insert into Shelter values ('13579111315', 'www.CataraquiAnimalShelter.ca');

insert into Donation values ('1920374892', 'Donald', 'Trump', '123456789', 2.01, '2018-02-02');
insert into Donation values ('3829017389', 'Bernie', 'Sanders', '123456789', 1000.25, '2018-11-11');
insert into Donation values ('3829081902', 'Justin', 'Trudeau', '123456789', 50.50, '2019-03-03');
insert into Donation values ('1111111111', 'Tom', 'Hanks', '13091239811', 2500.00, '2018-02-24');
insert into Donation values ('2222222222', 'Barack', 'Obama', '91028391028', 420.00, '2018-08-10');

insert into Adopter values ('Steelers', '905678293', '30 Pittspurg Palace, Kingston, Ontario, K7L8U2');
insert into Adopter values ('Raptors', '905782917', '87 Air Canada Drive, Kingston, Ontario, K7L2I2');
insert into Adopter values ('Chelsea', '9056189029', '12 London Court, Kingston, Ontario, K7L4H2');

insert into Driver values ('Lamborghini', 'Mercy', '938291029836278', 'A7H26SG', '905738291');
insert into Driver values ('Subaru', 'Impreza', '817289301928173', 'AH72G790', '6169289301');

insert into DrivesFor values ('938291029836278', '91028391028');
insert into DrivesFor values ('938291029836278', '99999999999');
insert into DrivesFor values ('817289301928173', '91028391028');

insert into Animal values ('0192837648', 'Cat', Null, Null, Null);
insert into Animal values ('7283182091', 'Dog', Null, Null, Null);
insert into Animal values ('1111111111', 'Rabbit', Null, Null, Null);
insert into Animal values ('2222222222', 'Mouse', Null, Null, Null);
insert into Animal values ('2830183010', 'Jaguar', Null, Null, Null);
insert into Animal values ('0239298289', 'Dodo Bird', Null, Null, Null);
insert into Animal values ('3801928320', 'Chimpanzee', 'Steelers', '905678293', 1000.25);
insert into Animal values ('3193128780', 'Dolphin', 'Raptors', '905782917', 1000000.00);
insert into Animal values ('0912381039', 'Great Big Whale', 'Chelsea', '9056189029', 5000000.00);

#all animals start at an SPCA location
insert into Relocates values ('0192837648', '123456789', Null, '2019-10-10');
insert into Relocates values ('7283182091', '123456789', Null, '2017-10-10');
insert into Relocates values ('2830183010', '123456789', Null, '2019-05-05');
insert into Relocates values ('0239298289', '123456789', Null, '2018-06-06');
insert into Relocates values ('3801928320', '123456789', Null, '2016-11-04');
insert into Relocates values ('3193128780', '123456789', Null, '2017-10-10');
insert into Relocates values ('0912381039', '123456789', Null, '2018-08-08');
insert into Relocates values ('1111111111', '100000000', Null, '2018-06-06');
insert into Relocates values ('2222222222', '100000000', Null, '2018-06-06');

#some are moved again
insert into Relocates values ('0239298289', '13091239811', 25.00, '2018-09-07');
Insert into Relocates values ('0192837648', '13091239811', 15.00, '2020-01-01');
Insert into Relocates values ('7283182091', '13091239811', 25.00, '2018-02-01');

#some of those moved again were driven by a volunteer for a rescuer organization
insert into Transports values ('938291029836278', '123456789', '13091239811', '0192837648');
insert into Transports values ('817289301928173', '123456789', '13091239811', '7283182091');


insert into Vet values ('1301830129', 'Hannibal', 'Lector');
insert into Vet values ('2103182093', 'Gregory', 'House');

insert into Capacity values ('Cat', 50, '13091239811');
insert into Capacity values ('Dog', 50, '13091239811');
insert into Capacity values ('Dodo Bird', 5, '13091239811');

insert into Visits values ('2830183010', '1301830129', '10-10-19', 'Arthritis', 190.000);
insert into Visits values ('0239298289', '2103182093', '06-06-19', 'Obesity', 40.000);

