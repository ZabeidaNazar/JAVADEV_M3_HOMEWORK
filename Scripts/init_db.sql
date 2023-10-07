--worker - таблиця для працівників. У таблиці мають бути наступні поля:
--ID - ідентифікатор працівника, ціле число, сурогатний первинний ключ.
--NAME - ім'я працівника, рядок. Обмеження - не має бути NULL, довжина має бути від 2 до 1000 символів включно.
--BIRTHDAY - дата народження. Рік у цій даті має бути більшим за 1900
--LEVEL - рівень технічного розвитку працівника. Має бути обмеження - це поле не може бути NULL, значення поля може бути одним з - Trainee, Junior, Middle, Senior
--SALARY - заробітна плата працівника за 1 місяць. Обмеження - ціле число, не менше 100 і не більше 100 000

CREATE TABLE worker (
	id int PRIMARY KEY,
	"name" varchar NOT NULL CONSTRAINT name_length CHECK (length("name") BETWEEN 2 AND 1000),
	birthday date CONSTRAINT min_year CHECK (EXTRACT (YEAR FROM birthday) > '1900'),
	"level" varchar(7) NOT NULL CONSTRAINT in_levels CHECK ("level" IN ('Trainee', 'Junior', 'Middle', 'Senior')),
	salary int CONSTRAINT salary_size CHECK (salary BETWEEN 100 AND 100_000)
);

--DROP TABLE worker;



--client - таблиця для клієнтів. Мають бути наступні поля:
--ID - ідентифікатор клієнта, ціле число, сурогатний первинний ключ.
--NAME - ім'я працівника, рядок. Обмеження - не має бути NULL, довжина має бути від 2 до 1000 символів включно.

CREATE TABLE client (
	id int PRIMARY KEY,
	"name" varchar NOT NULL CONSTRAINT name_length CHECK (length("name") BETWEEN 2 AND 1000)
);



--project - таблиця для проєктів. Мають бути наступні поля:
--ID - ідентифікатор проєкту, ціле число, сурогатний первинний ключ.
--CLIENT_ID - ідентифікатор клієнта, що замовив цей проєкт
--START_DATE - дата початку виконання проєкту
--FINISH_DATE - дата кінця виконання проєкту

CREATE TABLE project (
	id int PRIMARY KEY,
	client_id int CONSTRAINT client_id_from_project_with_id_from_client REFERENCES client(id) ON DELETE CASCADE,
	"name" varchar CONSTRAINT name_length CHECK (length("name") BETWEEN 1 AND 1000),
	start_date date,
	finish_date date
);



--project_worker - таблиця, що показує, які працівники над якими проєктами працюють. Поля таблиці:
--PROJECT_ID - ідентифікатор проєкту. Зовнішній ключ для таблиці project(id)
--WORKER_ID - ідентифікатор клієнту. Зовнішній ключ для таблиці worker(id)
--первинний ключ для цієї таблиці - складений, пара (PROJECT_ID, WORKER_ID)

CREATE TABLE project_worker (
	project_id int CONSTRAINT project_id_from_project_worker_with_id_from_project REFERENCES project(id) ON DELETE CASCADE,
	worker_id int CONSTRAINT worker_id_from_project_worker_with_id_from_worker REFERENCES worker(id) ON DELETE CASCADE,
	PRIMARY KEY (project_id, worker_id) 
);








