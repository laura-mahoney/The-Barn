--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE activities (
    activity_id integer NOT NULL,
    dogmountain character varying(20),
    flirtpole character varying(20),
    drills character varying(20),
    walkonleash character varying(20),
    pushups character varying(20),
    "fetch" character varying(20)
);


ALTER TABLE activities OWNER TO vagrant;

--
-- Name: activities_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE activities_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activities_activity_id_seq OWNER TO vagrant;

--
-- Name: activities_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE activities_activity_id_seq OWNED BY activities.activity_id;


--
-- Name: barncrew; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE barncrew (
    crew_id integer NOT NULL,
    fname character varying(20) NOT NULL,
    lname character varying(20) NOT NULL,
    email character varying(30) NOT NULL,
    phone character varying(20) NOT NULL,
    password character varying(30) NOT NULL,
    pos_code character varying(10)
);


ALTER TABLE barncrew OWNER TO vagrant;

--
-- Name: barncrew_crew_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE barncrew_crew_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE barncrew_crew_id_seq OWNER TO vagrant;

--
-- Name: barncrew_crew_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE barncrew_crew_id_seq OWNED BY barncrew.crew_id;


--
-- Name: barncrewshift; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE barncrewshift (
    bc_id integer NOT NULL,
    shift_id integer NOT NULL,
    crew_id integer NOT NULL,
    support_id integer
);


ALTER TABLE barncrewshift OWNER TO vagrant;

--
-- Name: barncrewshift_bc_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE barncrewshift_bc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE barncrewshift_bc_id_seq OWNER TO vagrant;

--
-- Name: barncrewshift_bc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE barncrewshift_bc_id_seq OWNED BY barncrewshift.bc_id;


--
-- Name: commands; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE commands (
    commands_id integer NOT NULL,
    wait integer,
    sit integer,
    down integer,
    drop integer,
    leaveit integer,
    shake integer,
    stay integer
);


ALTER TABLE commands OWNER TO vagrant;

--
-- Name: commands_commands_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE commands_commands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE commands_commands_id_seq OWNER TO vagrant;

--
-- Name: commands_commands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE commands_commands_id_seq OWNED BY commands.commands_id;


--
-- Name: dog; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dog (
    dog_id integer NOT NULL,
    dog_name character varying(20),
    kennel_id integer NOT NULL,
    breed character varying(60) NOT NULL,
    gender character varying(10) NOT NULL,
    altered boolean NOT NULL,
    age double precision NOT NULL,
    intake_date timestamp without time zone NOT NULL
);


ALTER TABLE dog OWNER TO vagrant;

--
-- Name: dog_dog_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dog_dog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dog_dog_id_seq OWNER TO vagrant;

--
-- Name: dog_dog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dog_dog_id_seq OWNED BY dog.dog_id;


--
-- Name: dogplaymates; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dogplaymates (
    shift_id integer NOT NULL,
    dog_id integer NOT NULL,
    play_mate1 integer,
    play_mate2 integer,
    id integer NOT NULL
);


ALTER TABLE dogplaymates OWNER TO vagrant;

--
-- Name: dogplaymates_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dogplaymates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dogplaymates_id_seq OWNER TO vagrant;

--
-- Name: dogplaymates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dogplaymates_id_seq OWNED BY dogplaymates.id;


--
-- Name: dogshift; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dogshift (
    dogshift_id integer NOT NULL,
    shift_id integer NOT NULL,
    dog_id integer NOT NULL,
    notes character varying(3000) NOT NULL
);


ALTER TABLE dogshift OWNER TO vagrant;

--
-- Name: dogshift_dogshift_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dogshift_dogshift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dogshift_dogshift_id_seq OWNER TO vagrant;

--
-- Name: dogshift_dogshift_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dogshift_dogshift_id_seq OWNED BY dogshift.dogshift_id;


--
-- Name: dogshiftactivities; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dogshiftactivities (
    dsactivities_id integer NOT NULL,
    activity_id integer,
    dogshift_id integer NOT NULL
);


ALTER TABLE dogshiftactivities OWNER TO vagrant;

--
-- Name: dogshiftactivities_dsactivities_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dogshiftactivities_dsactivities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dogshiftactivities_dsactivities_id_seq OWNER TO vagrant;

--
-- Name: dogshiftactivities_dsactivities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dogshiftactivities_dsactivities_id_seq OWNED BY dogshiftactivities.dsactivities_id;


--
-- Name: dogshiftcommands; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dogshiftcommands (
    dscommands_id integer NOT NULL,
    commands_id integer NOT NULL,
    dogshift_id integer NOT NULL,
    score integer
);


ALTER TABLE dogshiftcommands OWNER TO vagrant;

--
-- Name: dogshiftcommands_dscommands_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dogshiftcommands_dscommands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dogshiftcommands_dscommands_id_seq OWNER TO vagrant;

--
-- Name: dogshiftcommands_dscommands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dogshiftcommands_dscommands_id_seq OWNED BY dogshiftcommands.dscommands_id;


--
-- Name: kennel; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE kennel (
    kennel_id integer NOT NULL,
    dog_door boolean NOT NULL,
    size character varying(10) NOT NULL,
    indoor boolean NOT NULL
);


ALTER TABLE kennel OWNER TO vagrant;

--
-- Name: kennel_kennel_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE kennel_kennel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kennel_kennel_id_seq OWNER TO vagrant;

--
-- Name: kennel_kennel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE kennel_kennel_id_seq OWNED BY kennel.kennel_id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE positions (
    pos_code character varying(10) NOT NULL
);


ALTER TABLE positions OWNER TO vagrant;

--
-- Name: shift; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE shift (
    shift_id integer NOT NULL,
    date_time timestamp without time zone NOT NULL,
    duration character varying(20),
    notes character varying(3000)
);


ALTER TABLE shift OWNER TO vagrant;

--
-- Name: shift_shift_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE shift_shift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shift_shift_id_seq OWNER TO vagrant;

--
-- Name: shift_shift_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE shift_shift_id_seq OWNED BY shift.shift_id;


--
-- Name: activity_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY activities ALTER COLUMN activity_id SET DEFAULT nextval('activities_activity_id_seq'::regclass);


--
-- Name: crew_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew ALTER COLUMN crew_id SET DEFAULT nextval('barncrew_crew_id_seq'::regclass);


--
-- Name: bc_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift ALTER COLUMN bc_id SET DEFAULT nextval('barncrewshift_bc_id_seq'::regclass);


--
-- Name: commands_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY commands ALTER COLUMN commands_id SET DEFAULT nextval('commands_commands_id_seq'::regclass);


--
-- Name: dog_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog ALTER COLUMN dog_id SET DEFAULT nextval('dog_dog_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates ALTER COLUMN id SET DEFAULT nextval('dogplaymates_id_seq'::regclass);


--
-- Name: dogshift_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshift ALTER COLUMN dogshift_id SET DEFAULT nextval('dogshift_dogshift_id_seq'::regclass);


--
-- Name: dsactivities_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftactivities ALTER COLUMN dsactivities_id SET DEFAULT nextval('dogshiftactivities_dsactivities_id_seq'::regclass);


--
-- Name: dscommands_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftcommands ALTER COLUMN dscommands_id SET DEFAULT nextval('dogshiftcommands_dscommands_id_seq'::regclass);


--
-- Name: kennel_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY kennel ALTER COLUMN kennel_id SET DEFAULT nextval('kennel_kennel_id_seq'::regclass);


--
-- Name: shift_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY shift ALTER COLUMN shift_id SET DEFAULT nextval('shift_shift_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY activities (activity_id, dogmountain, flirtpole, drills, walkonleash, pushups, "fetch") FROM stdin;
1	yes	no	false	false	false	false
2	yes	no	no	false	false	false
3	yes	no	no	yes	no	false
4	yes	no	yes	no	no	no
8	yes	no	no	yes	no	no
9	yes	no	no	yes	no	no
\.


--
-- Name: activities_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('activities_activity_id_seq', 9, true);


--
-- Data for Name: barncrew; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY barncrew (crew_id, fname, lname, email, phone, password, pos_code) FROM stdin;
1	Diana	Right	dright@gmail.com	925-925-6889	password	mgmt
2	Tom	Right	tright@gmail.com	925-555-4545	password	mgmt
3	Anicka	Jones	msjojoForLife@me.com	510-610-1243	password	volunteer
4	Becky	Beckwith	becksbeck23@yahoo.com	650-233-9987	password	volunteer
5	Joyce	Patch	jpcool@me.com	925-432-4352	password	volunteer
6	Chase	Sanchez	cjsanchez2014@gmail.com	676-933-7680	password	volunteer
7	Rafi	Riner	rafraf4565@yahoo.com	510-510-2340	password	volunteer
8	Laura	Clover	lclover678@gmail.com	510-320-3254	password	volunteer
9	Peter	Wong	pwong65@me.com	650-766-1818	password	admin
10	Biko	Smith	bmith@gmail.com	925-405-6789	password	admin
11	Valerie	Rau	vrau@gmail.com	925-901-4554	password	volunteer
12	Kyle	Cloyne	bikerguy1266@me.com	510-856-1212	password	volunteer
13	Robert	Jackson	jackr18@yahoo.com	650-999-3987	password	volunteer
14	Dano	Spade	dspade@me.com	925-432-7611	password	volunteer
15	Quiana	Ford	ford657@gmail.com	510-736-7680	password	volunteer
16	Jackie	Xavier	xavier101@yahoo.com	510-980-2341	password	volunteer
17	Samuel	Nola	nolanola@gmail.com	510-767-3223	password	volunteer
18	Kathrine	Apple	ilikeapples@me.com	510-745-1232	password	admin
\.


--
-- Name: barncrew_crew_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('barncrew_crew_id_seq', 18, true);


--
-- Data for Name: barncrewshift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY barncrewshift (bc_id, shift_id, crew_id, support_id) FROM stdin;
1	1	1	5
2	2	1	8
3	3	1	7
4	4	1	14
5	5	1	16
6	6	1	5
7	7	1	6
8	8	1	6
9	9	1	4
10	10	1	6
11	11	1	6
12	12	1	6
13	13	1	5
14	14	1	8
15	15	1	5
16	16	1	5
17	17	1	6
18	18	1	7
19	19	1	3
\.


--
-- Name: barncrewshift_bc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('barncrewshift_bc_id_seq', 19, true);


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY commands (commands_id, wait, sit, down, drop, leaveit, shake, stay) FROM stdin;
1	2	3	\N	\N	\N	\N	\N
2	1	3	2	3	3	\N	\N
3	2	3	4	4	2	3	\N
4	4	4	4	3	4	3	4
8	1	4	3	2	3	3	3
9	2	\N	1	2	2	2	2
\.


--
-- Name: commands_commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('commands_commands_id_seq', 9, true);


--
-- Data for Name: dog; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dog (dog_id, dog_name, kennel_id, breed, gender, altered, age, intake_date) FROM stdin;
1	Lolo	1	American Pit Bull Terrier Mix	Female	t	4	2016-11-05 00:00:00
2	Cooper	2	American Pit Bull Terrier Mix	Male	t	5	2016-11-01 00:00:00
3	Chet	3	Husky	Male	t	3	2016-01-23 00:00:00
4	Snorkles	4	American Staffordshire Terrier	Female	t	2	2016-10-10 00:00:00
5	Zelda	5	Staffordshire Bull Terrier	Female	f	0.25	2016-12-15 00:00:00
6	Willis	6	American Staffordshire Terrier	Male	t	2	2016-09-01 00:00:00
7	Zilla	5	American Pit Bull Terrier Mix/Bulldog	Female	t	3	2016-10-12 00:00:00
8	Mila	8	American Pit Bull Terrier Mix	Female	t	3	2016-07-01 00:00:00
9	Spot	8	American Pit Bull Terrier Mix/Lab	Male	f	0.5	2016-10-20 00:00:00
10	Matzo	9	American Pit Bull Terrier Mix/Bulldog	Male	t	4	2016-07-01 00:00:00
11	Linus	9	American Pit Bull Terrier Mix/Bulldog	Male	t	6	2016-05-10 00:00:00
12	Billie	10	Wolfdog Mix	Female	t	3	2014-08-15 00:00:00
13	Freckles	11	American Pit Bull Terrier Mix	Male	f	0.25	2016-06-10 00:00:00
14	Toby	11	American Pit Bull Terrier Mix	Male	f	0.25	2016-06-10 00:00:00
15	Big Elf	11	American Pit Bull Terrier Mix	Male	f	0.25	2016-06-10 00:00:00
\.


--
-- Name: dog_dog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dog_dog_id_seq', 15, true);


--
-- Data for Name: dogplaymates; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogplaymates (shift_id, dog_id, play_mate1, play_mate2, id) FROM stdin;
3	1	3	4	1
4	1	5	6	2
5	1	5	8	3
6	1	8	8	4
6	4	12	14	5
7	1	7	4	6
\.


--
-- Name: dogplaymates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogplaymates_id_seq', 6, true);


--
-- Data for Name: dogshift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshift (dogshift_id, shift_id, dog_id, notes) FROM stdin;
1	3	1	Another lolo pupdate
2	4	1	Lolo did a great job today!
3	5	1	Lolo had a great day!
4	6	1	This is Lolo's pupdate!!!!
7	6	4	Cooper had a great day!
8	7	1	Lolo is having a bad day
\.


--
-- Name: dogshift_dogshift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshift_dogshift_id_seq', 8, true);


--
-- Data for Name: dogshiftactivities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshiftactivities (dsactivities_id, activity_id, dogshift_id) FROM stdin;
1	3	3
2	4	4
3	8	7
4	9	8
\.


--
-- Name: dogshiftactivities_dsactivities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshiftactivities_dsactivities_id_seq', 4, true);


--
-- Data for Name: dogshiftcommands; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshiftcommands (dscommands_id, commands_id, dogshift_id, score) FROM stdin;
1	3	3	\N
2	4	4	\N
3	8	7	\N
4	9	8	\N
\.


--
-- Name: dogshiftcommands_dscommands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshiftcommands_dscommands_id_seq', 4, true);


--
-- Data for Name: kennel; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY kennel (kennel_id, dog_door, size, indoor) FROM stdin;
1	t	Small	t
2	t	Large	t
3	t	Large	t
4	f	Medium	t
5	f	Large	f
6	f	Large	f
7	t	Small	t
8	f	Small	t
9	t	Large	t
10	f	Large	f
11	f	Small	f
12	t	Large	t
\.


--
-- Name: kennel_kennel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('kennel_kennel_id_seq', 1, false);


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY positions (pos_code) FROM stdin;
mgmt
admin
volunteer
\.


--
-- Data for Name: shift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY shift (shift_id, date_time, duration, notes) FROM stdin;
1	2017-02-28 08:30:00	2 hours	\N
2	2017-02-28 20:30:00	3 hours	\N
3	2017-03-01 08:30:00	2 hours	\N
4	2017-03-04 21:30:00	2 hours	\N
5	2017-03-04 22:30:00	2 hours	\N
6	2017-02-26 08:08:00	2 hours	Here is a general notes!
7	2017-03-01 08:30:00	2 hours	Here are more general notes!
8	2017-02-28 08:30:00	2 hours	\N
9	0019-12-23 08:23:00	2 hours	\N
10	2017-02-05 08:30:00	2 hours	\N
11	2017-02-28 08:30:00	2 hours	\N
12	2017-02-28 08:30:00	2 hours	\N
13	2017-02-13 08:30:00	1 hour	\N
14	2017-02-27 08:30:00	2 hours	\N
15	2017-02-28 08:30:00	1 hour	\N
16	2017-02-27 08:30:00	3 hours	\N
17	2017-02-28 08:30:00	2 hours	\N
18	2017-02-20 08:30:00	3 hours	\N
19	2017-02-28 08:30:00	2 hours	\N
\.


--
-- Name: shift_shift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('shift_shift_id_seq', 19, true);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (activity_id);


--
-- Name: barncrew_email_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew
    ADD CONSTRAINT barncrew_email_key UNIQUE (email);


--
-- Name: barncrew_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew
    ADD CONSTRAINT barncrew_pkey PRIMARY KEY (crew_id);


--
-- Name: barncrewshift_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_pkey PRIMARY KEY (bc_id);


--
-- Name: commands_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY commands
    ADD CONSTRAINT commands_pkey PRIMARY KEY (commands_id);


--
-- Name: dog_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog
    ADD CONSTRAINT dog_pkey PRIMARY KEY (dog_id);


--
-- Name: dogplaymates_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates
    ADD CONSTRAINT dogplaymates_pkey PRIMARY KEY (id);


--
-- Name: dogshift_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshift
    ADD CONSTRAINT dogshift_pkey PRIMARY KEY (dogshift_id);


--
-- Name: dogshiftactivities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftactivities
    ADD CONSTRAINT dogshiftactivities_pkey PRIMARY KEY (dsactivities_id);


--
-- Name: dogshiftcommands_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftcommands
    ADD CONSTRAINT dogshiftcommands_pkey PRIMARY KEY (dscommands_id);


--
-- Name: kennel_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY kennel
    ADD CONSTRAINT kennel_pkey PRIMARY KEY (kennel_id);


--
-- Name: positions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (pos_code);


--
-- Name: shift_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY shift
    ADD CONSTRAINT shift_pkey PRIMARY KEY (shift_id);


--
-- Name: barncrew_pos_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew
    ADD CONSTRAINT barncrew_pos_code_fkey FOREIGN KEY (pos_code) REFERENCES positions(pos_code);


--
-- Name: barncrewshift_crew_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_crew_id_fkey FOREIGN KEY (crew_id) REFERENCES barncrew(crew_id);


--
-- Name: barncrewshift_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES shift(shift_id);


--
-- Name: barncrewshift_support_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_support_id_fkey FOREIGN KEY (support_id) REFERENCES barncrew(crew_id);


--
-- Name: dog_kennel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog
    ADD CONSTRAINT dog_kennel_id_fkey FOREIGN KEY (kennel_id) REFERENCES kennel(kennel_id);


--
-- Name: dogplaymates_dog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates
    ADD CONSTRAINT dogplaymates_dog_id_fkey FOREIGN KEY (dog_id) REFERENCES dog(dog_id);


--
-- Name: dogplaymates_play_mate1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates
    ADD CONSTRAINT dogplaymates_play_mate1_fkey FOREIGN KEY (play_mate1) REFERENCES dog(dog_id);


--
-- Name: dogplaymates_play_mate2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates
    ADD CONSTRAINT dogplaymates_play_mate2_fkey FOREIGN KEY (play_mate2) REFERENCES dog(dog_id);


--
-- Name: dogplaymates_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogplaymates
    ADD CONSTRAINT dogplaymates_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES shift(shift_id);


--
-- Name: dogshift_dog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshift
    ADD CONSTRAINT dogshift_dog_id_fkey FOREIGN KEY (dog_id) REFERENCES dog(dog_id);


--
-- Name: dogshift_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshift
    ADD CONSTRAINT dogshift_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES shift(shift_id);


--
-- Name: dogshiftactivities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftactivities
    ADD CONSTRAINT dogshiftactivities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES activities(activity_id);


--
-- Name: dogshiftactivities_dogshift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftactivities
    ADD CONSTRAINT dogshiftactivities_dogshift_id_fkey FOREIGN KEY (dogshift_id) REFERENCES dogshift(dogshift_id);


--
-- Name: dogshiftcommands_commands_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftcommands
    ADD CONSTRAINT dogshiftcommands_commands_id_fkey FOREIGN KEY (commands_id) REFERENCES commands(commands_id);


--
-- Name: dogshiftcommands_dogshift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dogshiftcommands
    ADD CONSTRAINT dogshiftcommands_dogshift_id_fkey FOREIGN KEY (dogshift_id) REFERENCES dogshift(dogshift_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

