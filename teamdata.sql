--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Roles
--

CREATE ROLE admin;
ALTER ROLE admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE editor;
ALTER ROLE editor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE hoch_admin;
ALTER ROLE hoch_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:pYMf+SIZMLmyaObcxwOPzg==$dmJMzToM4g9ru0+9y4oB9aYDdnjoPlODYXBSX/76yss=:tOsiAVgq0MsxPj3hU0L1wwlixVmPXVLSrTBGL+9pSlQ=';
CREATE ROLE hoch_editor;
ALTER ROLE hoch_editor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:5iY/88UtR1UOX3l0/mZAeg==$PsHDo82jK+rFWd2DAh0Q6PKYl2ffMqrguPCGRWyATfg=:D+Yg4A4GnyFiBwF8JoHjR1oUEN7M4k3sOOhrQe+pcJE=';
CREATE ROLE hoch_visitor;
ALTER ROLE hoch_visitor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:GFFq2OqOehQG3b3L3LJsCw==$XoUBlto0Xoa0EUIem0zlJ4Hc9/1QV43pKcFQcnd+068=:1+xnyciGbVPKHBpuzUh0+hHag9b6TqRN4wfAi/9m9AE=';
CREATE ROLE visitor;
ALTER ROLE visitor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;


--
-- Role memberships
--

GRANT admin TO hoch_admin GRANTED BY postgres;
GRANT editor TO hoch_editor GRANTED BY postgres;
GRANT visitor TO hoch_visitor GRANTED BY postgres;



--
-- Name: teamdata; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE teamdata WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'German_Austria.1252';


ALTER DATABASE teamdata OWNER TO admin;

\connect teamdata

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_reviews; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_reviews (
    stars integer NOT NULL,
    description character varying(1000),
    admin_id integer NOT NULL,
    employee_id integer NOT NULL,
    admin_review_id integer NOT NULL,
    CONSTRAINT chk_budget CHECK (((stars >= 0) AND (stars <= 5)))
);


ALTER TABLE public.admin_reviews OWNER TO admin;

--
-- Name: admin_reviews_admin_review_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_reviews_admin_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_reviews_admin_review_id_seq OWNER TO admin;

--
-- Name: admin_reviews_admin_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_reviews_admin_review_id_seq OWNED BY public.admin_reviews.admin_review_id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admins (
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    birthday date NOT NULL,
    joined date NOT NULL,
    admin_id integer NOT NULL,
    CONSTRAINT chk_birthday CHECK ((birthday < CURRENT_DATE)),
    CONSTRAINT chk_joined CHECK (((joined <= CURRENT_DATE) AND (joined > (birthday + '18 years'::interval))))
);


ALTER TABLE public.admins OWNER TO admin;

--
-- Name: admins_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admins_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admins_admin_id_seq OWNER TO admin;

--
-- Name: admins_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admins_admin_id_seq OWNED BY public.admins.admin_id;


--
-- Name: customer_reviews; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.customer_reviews (
    stars integer NOT NULL,
    description character varying(1000),
    admin_id integer NOT NULL,
    employee_id integer NOT NULL,
    customer_review_id integer NOT NULL,
    CONSTRAINT chk_budget CHECK (((stars >= 0) AND (stars <= 5)))
);


ALTER TABLE public.customer_reviews OWNER TO admin;

--
-- Name: customer_reviews_customer_review_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.customer_reviews_customer_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_reviews_customer_review_id_seq OWNER TO admin;

--
-- Name: customer_reviews_customer_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.customer_reviews_customer_review_id_seq OWNED BY public.customer_reviews.customer_review_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.customers (
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    birthday date NOT NULL,
    joined date NOT NULL,
    company character varying(100) DEFAULT 'None'::character varying NOT NULL,
    budget numeric DEFAULT 0 NOT NULL,
    customer_id integer NOT NULL,
    CONSTRAINT chk_birthday CHECK ((birthday < CURRENT_DATE)),
    CONSTRAINT chk_budget CHECK ((budget >= (0)::numeric)),
    CONSTRAINT chk_joined CHECK (((joined <= CURRENT_DATE) AND (joined > (birthday + '18 years'::interval))))
);


ALTER TABLE public.customers OWNER TO admin;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO admin;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: employeedetails; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW public.employeedetails AS
SELECT
    NULL::integer AS id,
    NULL::text AS employee,
    NULL::numeric AS age,
    NULL::text AS "managed by",
    NULL::character varying[] AS skills,
    NULL::bigint AS rating,
    NULL::character varying[] AS projects;


ALTER TABLE public.employeedetails OWNER TO admin;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employees (
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    birthday date NOT NULL,
    joined date NOT NULL,
    employee_id integer NOT NULL,
    admin_id integer,
    CONSTRAINT chk_birthday CHECK ((birthday < CURRENT_DATE)),
    CONSTRAINT chk_joined CHECK (((joined <= CURRENT_DATE) AND (joined > (birthday + '18 years'::interval))))
);


ALTER TABLE public.employees OWNER TO admin;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_employee_id_seq OWNER TO admin;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: has_skills; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_skills (
    employee_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.has_skills OWNER TO admin;

--
-- Name: has_themes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_themes (
    project_id integer NOT NULL,
    theme_id integer NOT NULL
);


ALTER TABLE public.has_themes OWNER TO admin;

--
-- Name: projectdetails; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW public.projectdetails AS
SELECT
    NULL::integer AS id,
    NULL::character varying(100) AS name,
    NULL::text AS manager,
    NULL::text AS customer,
    NULL::character varying[] AS themes,
    NULL::character varying[] AS roles;


ALTER TABLE public.projectdetails OWNER TO admin;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.projects (
    name character varying(100) NOT NULL,
    start date DEFAULT CURRENT_DATE NOT NULL,
    deadline date NOT NULL,
    admin_id integer NOT NULL,
    customer_id integer NOT NULL,
    project_id integer NOT NULL,
    description character varying(1000) DEFAULT 'Not further details available.'::character varying NOT NULL,
    CONSTRAINT chk_deadline CHECK ((deadline > start))
);


ALTER TABLE public.projects OWNER TO admin;

--
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_project_id_seq OWNER TO admin;

--
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;


--
-- Name: role_categories; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_categories (
    name character varying(75) NOT NULL,
    description character varying(1000) NOT NULL,
    role_category_id integer NOT NULL,
    CONSTRAINT chk_description CHECK ((length((description)::text) >= length((name)::text)))
);


ALTER TABLE public.role_categories OWNER TO admin;

--
-- Name: role_categories_role_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.role_categories_role_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_categories_role_category_id_seq OWNER TO admin;

--
-- Name: role_categories_role_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.role_categories_role_category_id_seq OWNED BY public.role_categories.role_category_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.roles (
    name character varying(75) NOT NULL,
    description character varying(1000) NOT NULL,
    salary numeric DEFAULT 0 NOT NULL,
    how_many integer DEFAULT 1 NOT NULL,
    role_category_id integer NOT NULL,
    role_id integer NOT NULL,
    project_id integer NOT NULL,
    CONSTRAINT chk_description CHECK ((length((description)::text) >= length((name)::text))),
    CONSTRAINT chk_salary CHECK ((salary >= (0)::numeric))
);


ALTER TABLE public.roles OWNER TO admin;

--
-- Name: roledetails; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW public.roledetails AS
 SELECT r.role_id AS id,
    r.name AS job,
    r.description AS jobdescription,
    r.salary,
    r.how_many AS available,
    rc.role_category_id AS jobid,
    rc.description AS roledescription,
    rc.name AS role
   FROM (public.roles r
     LEFT JOIN public.role_categories rc USING (role_category_id));


ALTER TABLE public.roledetails OWNER TO admin;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO admin;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.skills (
    name character varying(50) NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.skills OWNER TO admin;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skills_skill_id_seq OWNER TO admin;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- Name: themes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.themes (
    name character varying(75) NOT NULL,
    description character varying(1000) NOT NULL,
    theme_id integer NOT NULL,
    CONSTRAINT chk_description CHECK ((length((description)::text) >= length((name)::text)))
);


ALTER TABLE public.themes OWNER TO admin;

--
-- Name: themes_theme_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.themes_theme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_theme_id_seq OWNER TO admin;

--
-- Name: themes_theme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.themes_theme_id_seq OWNED BY public.themes.theme_id;


--
-- Name: works_in; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.works_in (
    employee_id integer NOT NULL,
    project_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.works_in OWNER TO admin;

--
-- Name: admin_reviews admin_review_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_reviews ALTER COLUMN admin_review_id SET DEFAULT nextval('public.admin_reviews_admin_review_id_seq'::regclass);


--
-- Name: admins admin_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admins ALTER COLUMN admin_id SET DEFAULT nextval('public.admins_admin_id_seq'::regclass);


--
-- Name: customer_reviews customer_review_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer_reviews ALTER COLUMN customer_review_id SET DEFAULT nextval('public.customer_reviews_customer_review_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: projects project_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);


--
-- Name: role_categories role_category_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_categories ALTER COLUMN role_category_id SET DEFAULT nextval('public.role_categories_role_category_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- Name: themes theme_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.themes ALTER COLUMN theme_id SET DEFAULT nextval('public.themes_theme_id_seq'::regclass);


--
-- Data for Name: admin_reviews; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_reviews (stars, description, admin_id, employee_id, admin_review_id) FROM stdin;
5	great!	3	3	2
5	great!	3	6	3
5	great!	3	12	4
5	great!	3	14	5
3	meh!	1	8	10
3	meh!	1	11	11
1	bad	1	7	15
1	bad	8	9	17
\.


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admins (firstname, lastname, birthday, joined, admin_id) FROM stdin;
Dieter	Schmiedt	2001-08-08	2022-03-11	1
Herbert	Schmiedt	2000-07-08	2022-04-11	2
Max	Dieter	1999-08-24	2020-09-21	3
Daniel	Simsek	2002-08-24	2021-07-24	5
Adrian	Duller	2000-11-01	2021-05-30	7
Richard	Sims	2003-11-01	2022-01-01	8
Ralf	Mustermann	2000-07-30	2022-02-24	10
Raphael	Losko	2002-04-06	2022-02-06	11
Corina	Samuel	2001-08-16	2021-07-24	12
Kristof	Müller	2002-04-19	2022-03-29	14
Simon	Henmüller	2001-08-29	2022-03-23	15
Samuel	Richter	2000-11-03	2022-02-13	16
Peter	Niederwieser	2001-12-12	2022-01-22	17
Lenno	Weingraber	1999-08-03	2020-07-07	18
\.


--
-- Data for Name: customer_reviews; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.customer_reviews (stars, description, admin_id, employee_id, customer_review_id) FROM stdin;
5	great!	1	7	1
5	great!	1	11	4
5	great!	1	14	5
5	great!	5	14	7
5	great!	5	7	8
5	great!	8	7	12
3	meh	1	7	13
3	meh	1	11	14
3	meh	5	11	15
3	meh	5	7	16
3	meh	5	12	17
3	meh	3	12	18
3	meh	3	11	19
1	bad	3	11	20
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.customers (firstname, lastname, birthday, joined, company, budget, customer_id) FROM stdin;
Dieter	Schmiedt	2001-08-08	2022-03-11	None	0	1
Lindsey 	Gary	1987-11-17	2019-08-08	COP1	150	2
Henleigh  	Tyrel	2000-11-27	2021-07-13	COP1	150	3
Tyler   	Starr	2001-01-27	2021-06-11	COP1	300	4
Ayrton	Sparrow	2002-10-10	2021-08-20	COP2	105	6
Rebekah	Douglas	2000-10-17	2019-04-27	COP2	200	7
Dominika	Michael	2000-05-07	2019-01-02	COP2	20	8
Primrose	Dennis	2000-03-27	2019-01-12	COP2	50	9
Rebeca	Winters	2000-12-07	2019-08-02	COP3	500	10
Ajay	Millar	2000-02-03	2019-04-23	COP4	50	11
Madison	Greenaway	2000-11-04	2019-05-07	COP4	75	12
Candice	Amos	2000-06-12	2019-05-07	COP4	705	13
Kester	Bateman	2000-03-12	2019-02-09	COP4	0	14
Usman	Flowers	2000-08-26	2019-11-10	COP5	1000	15
Lennart	Weingraber	1999-08-03	2020-07-07	idk GmbH	100	16
Lennokraft007	Weingraber008	1999-08-03	2020-07-07	idk GmbH 007	100	17
Lennart	Weingraber	1999-08-03	2020-07-07	idk GmbH	100	18
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employees (firstname, lastname, birthday, joined, employee_id, admin_id) FROM stdin;
James	John	1986-11-11	2010-05-10	3	1
Johann	Jun	1994-06-21	2013-05-18	6	1
Gustav	Müller	1987-03-09	2018-02-18	10	3
Dani	Jabb	1977-03-17	2017-01-18	11	3
Tesla	Echte Daten	1957-01-17	2007-01-18	12	3
Max	Mustermann	1997-03-27	2016-02-08	14	5
Echter	Mann	1988-03-17	2016-01-08	15	5
Echter	Frau	1978-03-17	2015-02-08	16	7
Ernst	Mitbier	1999-03-07	2019-02-08	17	7
Lennart	Weingraber	1999-08-03	2020-07-07	19	2
Maximilian	Weingraber	1998-03-30	2020-05-08	7	\N
Robert	Gustav	1999-09-19	2018-04-18	8	\N
Samuel	Summe	1979-04-19	2018-04-28	9	\N
Jaycee 	Marlin	1987-11-17	2019-08-08	18	\N
\.


--
-- Data for Name: has_skills; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_skills (employee_id, skill_id) FROM stdin;
7	11
7	8
9	11
9	13
9	12
11	12
10	12
10	13
10	5
10	7
9	7
\.


--
-- Data for Name: has_themes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_themes (project_id, theme_id) FROM stdin;
2	1
3	2
7	6
8	7
10	9
11	10
12	11
13	12
14	13
15	14
16	15
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.projects (name, start, deadline, admin_id, customer_id, project_id, description) FROM stdin;
Mr.Banerro	2022-04-26	2024-07-15	5	13	7	Not further details available.
N.a.N.	2022-01-20	2022-07-12	11	2	8	Not further details available.
INSY H12	2020-07-23	2023-08-08	1	15	10	Not further details available.
MHA LT D2S	2021-08-30	2024-04-02	2	14	11	Not further details available.
Daniel UwU	2022-03-07	2025-02-22	12	6	13	Not further details available.
Feichti Rockt	2020-03-09	2023-01-21	8	3	14	Not further details available.
After the End	2021-09-22	2022-09-28	3	7	15	Not further details available.
Life or just a Game	2022-01-01	2022-07-18	8	1	16	Not further details available.
Dodo	1209-08-03	1720-07-07	2	1	18	Not fly!
HowTo2	2022-04-22	2023-04-04	1	4	2	I Love asjdkha das
MY MILK	2022-03-03	2023-05-15	15	18	3	It is great fun! Ig
Raphael ist ein super Mensch	2020-03-01	2022-04-27	16	2	12	cap? no cap?
YOUR MILKY	1999-08-03	2020-07-07	2	1	19	[ Insert funny milky joke ]
\.


--
-- Data for Name: role_categories; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_categories (name, description, role_category_id) FROM stdin;
ITler	ITler	1
Mathematician	Mathematician: Does math	2
Translator GE	Translator: German to English	3
Translator EG	Translator: English to German	4
Vue Expert	Vue Expert: Does Vue	5
JavaScript Expert	JavaScript Expert: Does JavaScript	6
SQL Expert	SQL Expert: Does SQL	7
HTML Expert	HTML Expert: Does HTML	8
Project Manager	Project Manager: Does managment	9
Microsoft Office Expert	Microsoft Office Expert: Does Microsoft Office	10
Compass	Compass: Does Microsoft spin	11
Voice Acter	Voice Acter: Does Voice Acting	12
Writer	Writer: Does writing	13
Politician	Politician: Does politics	14
Economician	Economician: Does economics	15
Dancer	Dancer: Does dancing	16
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.roles (name, description, salary, how_many, role_category_id, role_id, project_id) FROM stdin;
Not Itler	Does stuff	1000	3	1	1	2
Mathsman	Does maths	10000	1	2	2	2
Translator	German to English	400	5	3	3	2
Translator P5	German to English	200	12	3	4	2
Vue Expert	 Vue3 and more	600	4	5	6	3
JavaScript Expert	 JavaScript and more	600	4	5	7	3
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.skills (name, skill_id) FROM stdin;
Math	4
English	5
German	6
Vue	7
JavaScipt	8
SQL	9
HTML	10
Project Managment	11
Microsoft Office	12
Geography	13
Voice Acting	14
Writing	15
Politics	16
Economics	17
Dancing	18
\.


--
-- Data for Name: themes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.themes (name, description, theme_id) FROM stdin;
Magic	Much Magic	1
Math	Much Math	2
Horror	Much Horror	3
Action	Much Action	4
Animation	Much Animation	5
Comedy	Much Comedy	6
Crime	Much Crime	7
Drama	Much Drama	8
Experimental	Much Experimental	9
Fantasy	Much Fantasy	10
Historical	Much Historical	11
Romance	Much Romance	12
Thriller	Much Thriller	13
Western	Much Western	14
Other	Much Other	15
\.


--
-- Data for Name: works_in; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.works_in (employee_id, project_id, role_id) FROM stdin;
3	2	2
6	2	4
7	3	6
8	3	7
\.


--
-- Name: admin_reviews_admin_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_reviews_admin_review_id_seq', 17, true);


--
-- Name: admins_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admins_admin_id_seq', 18, true);


--
-- Name: customer_reviews_customer_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.customer_reviews_customer_review_id_seq', 23, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 18, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 19, true);


--
-- Name: projects_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.projects_project_id_seq', 23, true);


--
-- Name: role_categories_role_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_categories_role_category_id_seq', 16, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 16, true);


--
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 18, true);


--
-- Name: themes_theme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.themes_theme_id_seq', 15, true);


--
-- Name: admin_reviews admin_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_reviews
    ADD CONSTRAINT admin_reviews_pkey PRIMARY KEY (admin_review_id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (admin_id);


--
-- Name: customer_reviews customer_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer_reviews
    ADD CONSTRAINT customer_reviews_pkey PRIMARY KEY (customer_review_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: has_skills has_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_skills
    ADD CONSTRAINT has_skills_pkey PRIMARY KEY (employee_id, skill_id);


--
-- Name: has_themes has_themes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_themes
    ADD CONSTRAINT has_themes_pkey PRIMARY KEY (project_id, theme_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- Name: role_categories role_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_categories
    ADD CONSTRAINT role_categories_pkey PRIMARY KEY (role_category_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (theme_id);


--
-- Name: works_in works_in_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works_in
    ADD CONSTRAINT works_in_pkey PRIMARY KEY (employee_id, project_id, role_id);


--
-- Name: projectdetails _RETURN; Type: RULE; Schema: public; Owner: admin
--

CREATE OR REPLACE VIEW public.projectdetails AS
 SELECT p.project_id AS id,
    p.name,
    concat(a.firstname, ' ', a.lastname) AS manager,
    concat(c.firstname, ' ', c.lastname) AS customer,
    array_agg(t.name) AS themes,
    array_agg(r.name) AS roles
   FROM (((((public.projects p
     LEFT JOIN public.admins a USING (admin_id))
     LEFT JOIN public.customers c USING (customer_id))
     LEFT JOIN public.has_themes ht USING (project_id))
     LEFT JOIN public.themes t USING (theme_id))
     LEFT JOIN public.roles r USING (project_id))
  GROUP BY p.project_id, a.admin_id, c.customer_id;


--
-- Name: employeedetails _RETURN; Type: RULE; Schema: public; Owner: admin
--

CREATE OR REPLACE VIEW public.employeedetails AS
 SELECT e.employee_id AS id,
    concat(e.firstname, ' ', e.lastname) AS employee,
    (EXTRACT(year FROM now()) - EXTRACT(year FROM e.birthday)) AS age,
    concat(a.firstname, ' ', a.lastname) AS "managed by",
    array_agg(DISTINCT s.name) AS skills,
    ((sum(DISTINCT cr.stars) + sum(DISTINCT ar.stars)) / (count(DISTINCT cr.customer_review_id) + count(DISTINCT ar.admin_review_id))) AS rating,
    array_agg(DISTINCT p.name) AS projects
   FROM (((((((public.employees e
     LEFT JOIN public.admins a USING (admin_id))
     LEFT JOIN public.has_skills hs USING (employee_id))
     LEFT JOIN public.skills s USING (skill_id))
     LEFT JOIN public.admin_reviews ar USING (employee_id))
     LEFT JOIN public.customer_reviews cr USING (employee_id))
     LEFT JOIN public.works_in wi USING (employee_id))
     LEFT JOIN public.projects p USING (project_id))
  GROUP BY e.employee_id, a.admin_id;


--
-- Name: roledetails roledetails_update; Type: RULE; Schema: public; Owner: admin
--

CREATE RULE roledetails_update AS
    ON UPDATE TO public.roledetails DO INSTEAD ( UPDATE public.roles SET name = new.job, description = new.jobdescription, salary = new.salary, how_many = new.available
  WHERE (roles.role_id = old.id);
 UPDATE public.role_categories SET description = new.roledescription, name = new.role
  WHERE (role_categories.role_category_id = old.jobid);
);


--
-- Name: employees fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_admin FOREIGN KEY (admin_id) REFERENCES public.admins(admin_id) ON DELETE SET NULL;


--
-- Name: projects fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_admin FOREIGN KEY (admin_id) REFERENCES public.admins(admin_id);


--
-- Name: admin_reviews fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_reviews
    ADD CONSTRAINT fk_admin FOREIGN KEY (admin_id) REFERENCES public.admins(admin_id) ON DELETE CASCADE;


--
-- Name: customer_reviews fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer_reviews
    ADD CONSTRAINT fk_admin FOREIGN KEY (admin_id) REFERENCES public.admins(admin_id) ON DELETE CASCADE;


--
-- Name: projects fk_customer; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: has_skills fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_skills
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: works_in fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works_in
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: admin_reviews fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_reviews
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: customer_reviews fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer_reviews
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: works_in fk_project; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works_in
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: has_themes fk_project; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_themes
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: roles fk_project; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: works_in fk_role; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works_in
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;


--
-- Name: roles fk_role_category; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_role_category FOREIGN KEY (role_category_id) REFERENCES public.role_categories(role_category_id) ON DELETE CASCADE;


--
-- Name: has_skills fk_skill; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_skills
    ADD CONSTRAINT fk_skill FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id) ON DELETE CASCADE;


--
-- Name: has_themes fk_theme; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_themes
    ADD CONSTRAINT fk_theme FOREIGN KEY (theme_id) REFERENCES public.themes(theme_id) ON DELETE CASCADE;


--
-- Name: DATABASE teamdata; Type: ACL; Schema: -; Owner: admin
--

REVOKE CONNECT,TEMPORARY ON DATABASE teamdata FROM PUBLIC;
GRANT TEMPORARY ON DATABASE teamdata TO PUBLIC;
GRANT CONNECT ON DATABASE teamdata TO visitor;
GRANT CONNECT ON DATABASE teamdata TO editor;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO admin;
GRANT USAGE ON SCHEMA public TO visitor;
GRANT USAGE ON SCHEMA public TO editor;


--
-- Name: TABLE admin_reviews; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT ON TABLE public.admin_reviews TO visitor;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.admin_reviews TO editor;


--
-- Name: SEQUENCE admin_reviews_admin_review_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.admin_reviews_admin_review_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.admin_reviews_admin_review_id_seq TO visitor;


--
-- Name: TABLE admins; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.admins TO editor;
GRANT SELECT ON TABLE public.admins TO visitor;


--
-- Name: SEQUENCE admins_admin_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.admins_admin_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.admins_admin_id_seq TO visitor;


--
-- Name: TABLE customer_reviews; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT ON TABLE public.customer_reviews TO visitor;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.customer_reviews TO editor;


--
-- Name: SEQUENCE customer_reviews_customer_review_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.customer_reviews_customer_review_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.customer_reviews_customer_review_id_seq TO visitor;


--
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.customers TO editor;
GRANT SELECT ON TABLE public.customers TO visitor;


--
-- Name: SEQUENCE customers_customer_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.customers_customer_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.customers_customer_id_seq TO visitor;


--
-- Name: TABLE employeedetails; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.employeedetails TO editor;
GRANT SELECT ON TABLE public.employeedetails TO visitor;


--
-- Name: TABLE employees; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.employees TO editor;
GRANT SELECT ON TABLE public.employees TO visitor;


--
-- Name: SEQUENCE employees_employee_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.employees_employee_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.employees_employee_id_seq TO visitor;


--
-- Name: TABLE has_skills; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.has_skills TO editor;
GRANT SELECT ON TABLE public.has_skills TO visitor;


--
-- Name: TABLE has_themes; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.has_themes TO editor;
GRANT SELECT ON TABLE public.has_themes TO visitor;


--
-- Name: TABLE projectdetails; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT ON TABLE public.projectdetails TO visitor;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.projectdetails TO editor;


--
-- Name: TABLE projects; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.projects TO editor;
GRANT SELECT ON TABLE public.projects TO visitor;


--
-- Name: SEQUENCE projects_project_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.projects_project_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.projects_project_id_seq TO visitor;


--
-- Name: TABLE role_categories; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.role_categories TO editor;
GRANT SELECT ON TABLE public.role_categories TO visitor;


--
-- Name: SEQUENCE role_categories_role_category_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.role_categories_role_category_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.role_categories_role_category_id_seq TO visitor;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.roles TO editor;
GRANT SELECT ON TABLE public.roles TO visitor;


--
-- Name: TABLE roledetails; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.roledetails TO editor;
GRANT SELECT ON TABLE public.roledetails TO visitor;


--
-- Name: SEQUENCE roles_role_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.roles_role_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.roles_role_id_seq TO visitor;


--
-- Name: TABLE skills; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.skills TO editor;
GRANT SELECT ON TABLE public.skills TO visitor;


--
-- Name: SEQUENCE skills_skill_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.skills_skill_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.skills_skill_id_seq TO visitor;


--
-- Name: TABLE themes; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.themes TO editor;
GRANT SELECT ON TABLE public.themes TO visitor;


--
-- Name: SEQUENCE themes_theme_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.themes_theme_id_seq TO editor;
GRANT SELECT ON SEQUENCE public.themes_theme_id_seq TO visitor;


--
-- Name: TABLE works_in; Type: ACL; Schema: public; Owner: admin
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.works_in TO editor;
GRANT SELECT ON TABLE public.works_in TO visitor;


--
-- PostgreSQL database dump complete
--

