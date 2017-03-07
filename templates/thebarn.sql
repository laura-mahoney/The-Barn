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
    id integer NOT NULL,
    shift_id integer NOT NULL,
    dog_id integer NOT NULL,
    play_mate1 integer,
    play_mate2 integer
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
    score character varying(10)
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
3	no	no	no	yes	false	yes
4	yes	no	yes	no	false	yes
5	yes	no	no	yes	false	yes
6	no	yes	no	no	false	yes
7	no	no	no	no	false	no
8	yes	no	yes	yes	false	yes
9	no	yes	yes	no	false	no
10	no	no	no	no	false	yes
11	no	no	no	no	false	no
12	no	yes	yes	no	false	no
13	no	no	no	no	false	no
14	no	no	no	no	false	no
15	no	no	no	no	false	no
16	no	no	no	no	false	no
17	no	yes	no	yes	false	yes
18	yes	no	no	yes	false	no
19	no	no	yes	yes	false	no
20	yes	yes	no	yes	false	yes
21	no	no	no	no	false	no
22	no	yes	yes	yes	false	no
23	yes	no	no	no	false	yes
24	yes	no	no	no	false	yes
25	yes	yes	yes	yes	false	yes
26	yes	no	no	yes	false	no
27	no	no	yes	no	false	yes
28	no	no	no	no	false	no
29	no	no	yes	yes	false	no
30	no	no	no	no	false	no
31	no	no	no	no	false	no
32	no	no	no	no	false	no
33	no	no	yes	yes	false	no
34	yes	no	yes	yes	false	no
35	yes	yes	no	yes	false	yes
36	yes	yes	no	no	false	no
37	no	no	no	yes	false	no
38	yes	no	no	no	false	no
39	yes	yes	yes	yes	false	no
40	yes	yes	no	no	false	yes
41	yes	yes	yes	no	false	no
42	yes	yes	yes	no	false	yes
43	no	yes	yes	yes	false	no
44	yes	yes	yes	yes	false	yes
45	no	no	no	no	false	no
46	no	no	no	no	false	no
47	no	no	no	no	false	no
48	yes	yes	no	yes	false	no
49	yes	no	no	yes	false	no
50	yes	yes	no	no	false	yes
51	yes	yes	yes	yes	false	yes
52	yes	yes	yes	yes	false	yes
53	yes	yes	no	yes	false	yes
54	yes	no	yes	no	false	no
55	no	no	yes	no	false	no
56	no	yes	yes	yes	false	no
57	yes	no	no	no	false	yes
58	no	yes	no	yes	false	no
59	no	no	no	yes	false	no
60	no	no	no	no	false	no
61	no	no	no	no	false	no
62	no	no	no	no	false	no
63	yes	yes	yes	yes	false	no
64	no	no	no	yes	false	no
65	yes	yes	no	yes	false	yes
66	no	no	yes	yes	false	no
67	no	yes	no	no	false	yes
68	no	no	yes	no	false	yes
69	no	no	no	no	false	no
70	no	no	no	yes	false	no
71	no	no	no	yes	false	no
72	yes	no	no	yes	false	no
73	yes	no	yes	yes	false	no
74	yes	yes	yes	yes	false	yes
75	yes	yes	yes	yes	false	yes
76	no	yes	yes	yes	false	no
77	no	no	no	no	false	no
78	no	no	no	no	false	no
79	no	no	no	no	false	no
80	no	no	no	no	false	no
81	no	yes	no	no	false	no
\.


--
-- Name: activities_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('activities_activity_id_seq', 81, true);


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
1	1	1	10
2	2	1	11
3	3	1	15
4	4	1	16
5	5	1	12
6	6	1	9
7	7	1	9
8	8	1	12
9	9	1	12
10	10	1	4
11	11	1	7
12	12	1	11
13	13	1	11
14	14	1	11
15	15	1	6
16	16	1	16
17	17	1	11
18	18	1	11
19	19	1	10
20	20	1	10
21	21	1	10
22	22	1	10
23	23	1	10
24	24	1	10
25	25	1	10
26	26	1	10
27	27	1	10
28	28	1	10
29	29	1	10
30	30	1	10
31	31	1	10
32	32	1	10
33	33	1	10
34	34	1	10
35	35	1	10
36	36	1	10
37	37	1	10
38	38	1	10
39	39	1	10
40	40	1	10
41	41	1	10
42	42	1	10
43	43	1	10
44	44	1	10
45	45	1	10
\.


--
-- Name: barncrewshift_bc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('barncrewshift_bc_id_seq', 45, true);


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY commands (commands_id, wait, sit, down, drop, leaveit, shake, stay) FROM stdin;
2	1	2	3	3	1	1	2
3	4	4	3	4	3	4	5
4	5	5	3	4	4	5	5
5	4	4	4	2	3	4	5
6	1	1	2	1	1	1	1
7	5	4	5	5	4	4	5
8	3	3	4	4	4	4	4
9	4	3	4	3	2	3	4
10	5	5	4	5	5	1	5
11	4	3	4	5	5	3	4
12	5	5	5	5	5	5	5
13	2	1	2	1	2	1	1
14	1	1	2	1	2	1	1
15	2	1	1	2	2	1	1
16	4	3	4	4	4	4	4
17	4	3	4	5	4	4	5
18	5	5	5	5	5	5	5
19	4	4	3	3	4	4	3
20	1	2	1	1	1	1	1
21	3	4	2	4	3	4	5
22	3	4	3	4	3	5	5
23	3	4	3	4	3	5	5
24	3	4	3	2	3	5	5
25	3	1	2	3	3	2	2
26	4	4	3	4	4	3	5
27	4	5	4	5	4	5	5
28	5	4	5	5	4	5	5
29	1	1	1	1	2	2	1
30	1	1	1	2	1	1	1
31	1	1	1	1	1	1	1
32	4	4	3	4	3	4	5
33	4	3	5	4	3	5	4
34	5	5	5	5	5	5	5
35	3	3	4	4	4	4	4
36	1	2	1	2	1	1	1
37	4	4	4	4	4	4	3
38	4	4	4	3	3	3	2
39	4	3	4	3	4	4	3
40	4	2	5	3	2	4	1
41	5	5	5	5	5	5	5
42	2	3	5	3	4	2	5
43	5	5	5	5	5	4	5
44	1	1	2	1	2	1	1
45	1	1	1	1	2	1	1
46	1	2	1	1	1	1	2
47	4	4	4	3	3	4	5
48	5	4	4	2	4	4	5
49	5	4	4	4	5	4	5
50	4	4	3	4	4	3	4
51	1	2	1	1	2	3	1
52	4	4	5	4	4	4	4
53	4	4	3	4	3	4	4
54	4	4	4	5	4	5	5
55	4	3	4	3	3	4	3
56	5	4	5	4	5	4	4
57	5	5	5	4	4	5	4
58	5	5	5	5	5	5	5
59	1	2	1	1	1	1	1
60	1	1	1	1	1	1	1
61	2	1	2	1	2	1	1
62	4	4	4	4	2	3	4
63	4	4	4	4	4	4	4
64	4	4	4	4	4	4	4
65	5	5	5	5	5	5	5
66	4	4	4	4	4	4	4
67	4	5	4	4	4	4	4
68	4	4	4	4	4	4	4
69	3	4	4	4	4	4	4
70	3	3	3	3	3	3	3
71	2	2	2	2	2	2	2
72	4	5	4	4	4	4	4
73	3	4	5	4	5	4	5
74	5	5	5	5	5	5	5
75	1	2	1	1	1	1	1
76	1	1	1	1	1	1	1
77	1	1	1	1	1	1	1
78	4	4	4	4	4	4	3
79	3	4	4	4	4	4	4
80	4	4	4	4	4	4	4
\.


--
-- Name: commands_commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('commands_commands_id_seq', 80, true);


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

COPY dogplaymates (id, shift_id, dog_id, play_mate1, play_mate2) FROM stdin;
2	2	1	5	10
3	2	2	11	1
4	2	3	12	8
5	2	4	11	10
6	2	5	1	7
7	2	6	8	11
8	2	8	6	10
9	2	9	14	15
10	2	10	8	11
11	2	11	2	8
12	2	12	13	5
13	2	13	14	15
14	2	14	15	13
15	2	15	14	13
16	3	1	5	11
17	3	2	10	10
18	3	3	12	8
19	3	4	6	11
20	3	5	14	9
21	3	6	8	10
22	3	7	2	3
23	3	7	2	3
25	3	9	7	15
26	3	10	8	11
27	3	11	8	2
28	3	12	9	5
29	3	13	15	14
30	3	14	15	13
31	3	15	14	13
32	4	1	10	9
33	4	2	9	10
34	4	3	12	10
35	4	4	10	5
36	4	5	1	9
37	4	6	11	10
38	4	7	6	2
39	4	8	10	9
40	4	9	15	8
41	4	10	11	6
42	4	11	2	10
43	4	12	11	3
44	4	13	15	14
45	4	14	15	13
46	4	15	14	13
47	5	1	4	9
48	5	2	11	7
49	5	3	12	8
50	5	4	11	10
51	5	5	7	15
52	5	6	2	10
53	5	7	9	10
54	5	8	6	10
55	5	9	15	10
56	5	10	8	11
57	5	11	2	8
58	5	12	3	7
59	5	13	15	14
60	5	14	15	13
61	5	15	14	13
24	3	8	10	9
62	13	1	10	6
63	14	1	6	10
64	14	2	6	10
65	14	3	12	10
66	14	4	11	10
67	14	5	1	7
68	14	6	8	3
69	14	7	2	11
70	14	8	6	11
71	14	9	15	13
72	14	10	8	11
73	14	11	8	2
74	14	12	13	15
75	14	13	15	14
76	14	14	13	15
77	14	15	13	14
78	16	2	4	6
79	17	2	7	9
80	18	1	10	5
\.


--
-- Name: dogplaymates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogplaymates_id_seq', 80, true);


--
-- Data for Name: dogshift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshift (dogshift_id, shift_id, dog_id, notes) FROM stdin;
3	2	1	Lolo played on dog mountain for about 30 minutes and had a lot of fun playing with Spot and Willis in the yard. Her knees are improving slowly. Make sure to not wear her out too much. 
4	2	2	Cooper is a big sweetie and he knows his manners so well. Make sure to not over-treat him because he's gaining weight. 
5	2	3	Chet is doing much better and got over his case of dog flu. He played with his girlfriend Billie, and they ran around the yard. Chet and I went on a long walk around the neighborhood and he did very well on leash. 
6	2	4	Snorkles is such a sweetheart. She is being kenneled with one of the puppies and is getting along well with him. I noticed she had a sore on her front right paw and it resulted in a lot of limping during playtime. 
7	2	5	Zelda is such a cute puppy and is very loving. She is still learning all of the basic commands, and has a lot of fun running around the yard with the bigger dogs. 
8	2	6	Willis is going home soon! Yay! He had a very good day and spent a lot of time playing with Mila and Linus on Dog Mountain. His command skills have progressed a lot over the past few weeks and it's clear he is progressing at the barn.
9	2	8	Instead of playing fetch with Mila, I worked on basic obedience commands and it looks like she's improved a lot over the past few weeks being at the barn. 
10	2	9	This teenager, Spot, played really well with the puppies. He was a little bit mouthy with me and gave me little nibbles on my sweatshirt. I think he is hungry for treats! Oh, Spot!
11	2	10	Matzo loved playing in the puppy pool today. He splashed around and had a great time. Make sure to only feed him 3/4 cup of food because he's on a diet. Also, this big guy just got adopted! He will be re-homed soon. 
12	2	11	Linus is sick. Please make sure to give him his medicine with his food. It's in the top shelf of the cupboard. Today, he did a lot of great work on dog mountain and had a lot of fun.  
13	2	12	Billie is the perfect dog! She had a good day running around with the puppies and teaching them basic manners. 
14	2	13	Freckles is so adorable and had a good day playing with his brothers and Billie. Freckles is growing very fast. Don't forget to give him vitamins and salmon oil with his food. 
15	2	14	Toby is the runt of the litter and is growing slower. Make sure that during play sessions the other dogs don't push him around too much. 
16	2	15	Big Elf is the dominant puppy from his litter. Make sure he doesn't boss around Toby or Freckles. He is very 'in your face'. Big Elf is able to climb dog mountain! Good job, little guy. 
17	3	1	Today Lolo went up and down dog mountain many times. She's doing much better at it, and is working on her commands.
18	3	2	Cooper is a big sweetie and he knows his manners so well. Make sure to not over-treat him because he's gaining weight.
19	3	3	Chet is doing much better and got over his case of dog flu. He played with his girlfriend Billie, and they ran around the yard. Chet and I went on a long walk around the neighborhood and he did very well on leash. 
20	3	4	Snorkles is such a sweetheart. She is being kenneled with one of the puppies and is getting along well with him. I noticed she had a sore on her front right paw and it resulted in a lot of limping during playtime. 
21	3	5	Zelda is such a cute puppy and is very loving. She is still learning all of the basic commands, and has a lot of fun running around the yard with the bigger dogs. 
22	3	6	 Willis is going home soon! Yay! He had a very good day and spent a lot of time playing with Mila and Linus on Dog Mountain. His command skills have progressed a lot over the past few weeks and it's clear he is progressing at the barn.
23	3	7	Zilla had a great day. 
24	3	7	Zilla had a great day. Make sure to give her lots of hugs.  
25	3	8	 Instead of playing fetch with Mila, I worked on basic obedience commands and it looks like she's improved a lot over the past few weeks being at the barn.
26	3	9	This teenager, Spot, played really well with the puppies. He was a little bit mouthy with me and gave me little nibbles on my sweatshirt. I think he is hungry for treats! Oh, Spot!
27	3	10	Matzo loved playing in the puppy pool today. He splashed around and had a great time. Make sure to only feed him 3/4 cup of food because he's on a diet. Also, this big guy just got adopted! He will be re-homed soon. 
28	3	11	Linus is sick. Please make sure to give him his medicine with his food. It's in the top shelf of the cupboard. Today, he did a lot of great work on dog mountain and had a lot of fun. 
29	3	12	Billie is the perfect dog! She had a good day running around with the puppies and teaching them basic manners. 
30	3	13	Freckles is so adorable and had a good day playing with his brothers and Billie. Freckles is growing very fast. Don't forget to give him vitamins and salmon oil with his food. 
31	3	14	Toby is the runt of the litter and is growing slower. Make sure that during play sessions the other dogs don't push him around too much. 
32	3	15	Big Elf is the dominant puppy from his litter. Make sure he doesn't boss around Toby or Freckles. He is very 'in your face'. Big Elf is able to climb dog mountain! Good job, little guy. 
33	4	1	Lolo played on dog mountain for about 30 minutes and had a lot of fun playing with Spot and Willis in the yard. Her knees are improving slowly. Make sure to not wear her out too much.
34	4	2	Cooper is a big sweetie and he knows his manners so well. Make sure to not over-treat him because he's gaining weight. 
35	4	3	 Chet is doing much better and got over his case of dog flu. He played with his girlfriend Billie, and they ran around the yard. Chet and I went on a long walk around the neighborhood and he did very well on leash.
36	4	4	Snorkles is such a sweetheart. She is being kenneled with one of the puppies and is getting along well with him. I noticed she had a sore on her front right paw and it resulted in a lot of limping during playtime. 
37	4	5	Zelda is such a cute puppy and is very loving. She is still learning all of the basic commands, and has a lot of fun running around the yard with the bigger dogs.
38	4	6	Willis is going home soon! Yay! He had a very good day and spent a lot of time playing with Mila and Linus on Dog Mountain. His command skills have progressed a lot over the past few weeks and it's clear he is progressing at the barn.
39	4	7	Zilla had a great day. Make sure to give her lots of hugs.  
40	4	8	Instead of playing fetch with Mila, I worked on basic obedience commands and it looks like she's improved a lot over the past few weeks being at the barn.
41	4	9	 This teenager, Spot, played really well with the puppies. He was a little bit mouthy with me and gave me little nibbles on my sweatshirt. I think he is hungry for treats! Oh, Spot!
42	4	10	Matzo loved playing in the puppy pool today. He splashed around and had a great time. Make sure to only feed him 3/4 cup of food because he's on a diet. Also, this big guy just got adopted! He will be re-homed soon.
43	4	11	Linus is sick. Please make sure to give him his medicine with his food. It's in the top shelf of the cupboard. Today, he did a lot of great work on dog mountain and had a lot of fun. 
44	4	12	Billie is the perfect dog! She had a good day running around with the puppies and teaching them basic manners.
45	4	13	Freckles is so adorable and had a good day playing with his brothers and Billie. Freckles is growing very fast. Don't forget to give him vitamins and salmon oil with his food. 
46	4	14	Toby is the runt of the litter and is growing slower. Make sure that during play sessions the other dogs don't push him around too much. 
47	4	15	Big Elf is the dominant puppy from his litter. Make sure he doesn't boss around Toby or Freckles. He is very 'in your face'. Big Elf is able to climb dog mountain! Good job, little guy. 
48	5	1	Lolo played on dog mountain for about 30 minutes and had a lot of fun playing with Spot and Willis in the yard. Her knees are improving slowly. Make sure to not wear her out too much.
49	5	2	Cooper is a big sweetie and he knows his manners so well. Make sure to not over-treat him because he's gaining weight.
50	5	3	Chet is doing much better and got over his case of dog flu. He played with his girlfriend Billie, and they ran around the yard. Chet and I went on a long walk around the neighborhood and he did very well on leash.
51	5	4	Snorkles is such a sweetheart. She is being kenneled with one of the puppies and is getting along well with him. I noticed she had a sore on her front right paw and it resulted in a lot of limping during playtime.
52	5	5	Zelda is such a cute puppy and is very loving. She is still learning all of the basic commands, and has a lot of fun running around the yard with the bigger dogs. 
53	5	6	Willis is going home soon! Yay! He had a very good day and spent a lot of time playing with Mila and Linus on Dog Mountain. His command skills have progressed a lot over the past few weeks and it's clear he is progressing at the barn.
54	5	7	Zilla had a great day. Make sure to give her lots of hugs.
55	5	8	Instead of playing fetch with Mila, I worked on basic obedience commands and it looks like she's improved a lot over the past few weeks being at the barn.
56	5	9	This teenager, Spot, played really well with the puppies. He was a little bit mouthy with me and gave me little nibbles on my sweatshirt. I think he is hungry for treats! Oh, Spot!
57	5	10	Matzo loved playing in the puppy pool today. He splashed around and had a great time. Make sure to only feed him 3/4 cup of food because he's on a diet. Also, this big guy just got adopted! He will be re-homed soon.
58	5	11	Linus is sick. Please make sure to give him his medicine with his food. It's in the top shelf of the cupboard. Today, he did a lot of great work on dog mountain and had a lot of fun. 
59	5	12	Billie is the perfect dog! She had a good day running around with the puppies and teaching them basic manners.
60	5	13	Freckles is so adorable and had a good day playing with his brothers and Billie. Freckles is growing very fast. Don't forget to give him vitamins and salmon oil with his food.
61	5	14	Toby is the runt of the litter and is growing slower. Make sure that during play sessions the other dogs don't push him around too much.
62	5	15	Big Elf is the dominant puppy from his litter. Make sure he doesn't boss around Toby or Freckles. He is very 'in your face'. Big Elf is able to climb dog mountain! Good job, little guy.
63	13	1	Lolo played on dog mountain for about 30 minutes and had a lot of fun playing with Spot and Willis in the yard. Her knees are improving slowly. Make sure to not wear her out too much.
64	14	1	Lolo played on dog mountain for about 30 minutes and had a lot of fun playing with Spot and Willis in the yard. Her knees are improving slowly. Make sure to not wear her out too much.
65	14	2	Cooper is a big sweetie and he knows his manners so well. Make sure to not over-treat him because he's gaining weight.
66	14	3	Chet is doing much better and got over his case of dog flu. He played with his girlfriend Billie, and they ran around the yard. Chet and I went on a long walk around the neighborhood and he did very well on leash.
67	14	4	Snorkles is such a sweetheart. She is being kenneled with one of the puppies and is getting along well with him. I noticed she had a sore on her front right paw and it resulted in a lot of limping during playtime.
68	14	5	Zelda is such a cute puppy and is very loving. She is still learning all of the basic commands, and has a lot of fun running around the yard with the bigger dogs. 
69	14	6	Willis is going home soon! Yay! He had a very good day and spent a lot of time playing with Mila and Linus on Dog Mountain. His command skills have progressed a lot over the past few weeks and it's clear he is progressing at the barn.
70	14	7	Zilla had a great day. Make sure to give her lots of hugs.
71	14	8	Instead of playing fetch with Mila, I worked on basic obedience commands and it looks like she's improved a lot over the past few weeks being at the barn.
72	14	9	This teenager, Spot, played really well with the puppies. He was a little bit mouthy with me and gave me little nibbles on my sweatshirt. I think he is hungry for treats! Oh, Spot!
73	14	10	Matzo loved playing in the puppy pool today. He splashed around and had a great time. Make sure to only feed him 3/4 cup of food because he's on a diet. Also, this big guy just got adopted! He will be re-homed soon.
74	14	11	Linus is sick. Please make sure to give him his medicine with his food. It's in the top shelf of the cupboard. Today, he did a lot of great work on dog mountain and had a lot of fun. 
75	14	12	Billie is the perfect dog! She had a good day running around with the puppies and teaching them basic manners.
76	14	13	Freckles is so adorable and had a good day playing with his brothers and Billie. Freckles is growing very fast. Don't forget to give him vitamins and salmon oil with his food.
77	14	14	Toby is the runt of the litter and is growing slower. Make sure that during play sessions the other dogs don't push him around too much.
78	14	15	Big Elf is the dominant puppy from his litter. Make sure he doesn't boss around Toby or Freckles. He is very 'in your face'. Big Elf is able to climb dog mountain! Good job, little guy.
79	16	2	Cooper is sick today.
80	17	2	Cooper is sick today.
81	18	1	Lolo had a great day!
\.


--
-- Name: dogshift_dogshift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshift_dogshift_id_seq', 81, true);


--
-- Data for Name: dogshiftactivities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshiftactivities (dsactivities_id, activity_id, dogshift_id) FROM stdin;
1	3	3
2	4	4
3	5	5
4	6	6
5	7	7
6	8	8
7	9	9
8	10	10
9	11	11
10	12	12
11	13	13
12	14	14
13	15	15
14	16	16
15	17	17
16	18	18
17	19	19
18	20	20
19	21	21
20	22	22
21	23	23
22	24	24
23	25	25
24	26	26
25	27	27
26	28	28
27	29	29
28	30	30
29	31	31
30	32	32
31	33	33
32	34	34
33	35	35
34	36	36
35	37	37
36	38	38
37	39	39
38	40	40
39	41	41
40	42	42
41	43	43
42	44	44
43	45	45
44	46	46
45	47	47
46	48	48
47	49	49
48	50	50
49	51	51
50	52	52
51	53	53
52	54	54
53	55	55
54	56	56
55	57	57
56	58	58
57	59	59
58	60	60
59	61	61
60	62	62
61	64	64
62	65	65
63	66	66
64	67	67
65	68	68
66	69	69
67	70	70
68	71	71
69	72	72
70	73	73
71	74	74
72	75	75
73	76	76
74	77	77
75	78	78
76	81	81
\.


--
-- Name: dogshiftactivities_dsactivities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshiftactivities_dsactivities_id_seq', 76, true);


--
-- Data for Name: dogshiftcommands; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshiftcommands (dscommands_id, commands_id, dogshift_id, score) FROM stdin;
1	2	3	\N
2	3	4	\N
3	4	5	\N
4	5	6	\N
5	6	7	\N
6	7	8	\N
7	8	9	\N
8	9	10	\N
9	10	11	\N
10	11	12	\N
11	12	13	\N
12	13	14	\N
13	14	15	\N
14	15	16	\N
15	16	17	\N
16	17	18	\N
17	18	19	\N
18	19	20	\N
19	20	21	\N
20	21	22	\N
21	22	23	\N
22	23	24	\N
23	24	25	\N
24	25	26	\N
25	26	27	\N
26	27	28	\N
27	28	29	\N
28	29	30	\N
29	30	31	\N
30	31	32	\N
31	32	33	\N
32	33	34	\N
33	34	35	\N
34	35	36	\N
35	36	37	\N
36	37	38	\N
37	38	39	\N
38	39	40	\N
39	40	41	\N
40	41	42	\N
41	42	43	\N
42	43	44	\N
43	44	45	\N
44	45	46	\N
45	46	47	\N
46	47	48	\N
47	48	49	\N
48	49	50	\N
49	50	51	\N
50	51	52	\N
51	52	53	\N
52	53	54	\N
53	54	55	\N
54	55	56	\N
55	56	57	\N
56	57	58	\N
57	58	59	\N
58	59	60	\N
59	60	61	\N
60	61	62	\N
61	63	64	\N
62	64	65	\N
63	65	66	\N
64	66	67	\N
65	67	68	\N
66	68	69	\N
67	69	70	\N
68	70	71	\N
69	71	72	\N
70	72	73	\N
71	73	74	\N
72	74	75	\N
73	75	76	\N
74	76	77	\N
75	77	78	\N
76	80	81	4444444
\.


--
-- Name: dogshiftcommands_dscommands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dogshiftcommands_dscommands_id_seq', 76, true);


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
1	2017-02-13 08:30:00	2 hours	\N
2	2017-02-13 17:00:00	3 hours	Today I arrived at the barn and started the shift by letting the puppies out with Billie. After they were done playing I did some dishes and mopped. 
3	2017-02-14 08:30:00	3 hours	Today I arrived at the barn and started the shift by letting the puppies out with Billie. After they were done playing I did some dishes and mopped. 
4	2017-02-14 18:00:00	4 hours	Today I arrived at the barn and started the shift by letting the puppies out with Billie. After they were done playing I did some dishes and mopped. 
5	2017-02-15 08:30:00	2 hours	Today I arrived at the barn and started the shift by letting the puppies out with Billie. After they were done playing I did some dishes and mopped. 
6	2017-02-28 08:30:00	3 hours	\N
7	2017-02-28 08:30:00	3 hours	\N
8	2017-02-28 08:30:00	3 hours	\N
9	2017-02-28 08:30:00	3 hours	General notes
10	2017-03-29 08:30:00	1 hour	\N
11	2017-03-01 08:30:00	3 hours	\N
12	2017-03-02 08:30:00	3 hours	\N
13	2017-03-30 08:30:00	3 hours	\N
14	2017-03-31 08:30:00	3 hours	Today I arrived at the barn and started the shift by letting the puppies out with Billie. I noticed we are currently out of peanut butter, and that makes all the dogs very sad. Please make sure to pick some peanut butter up soon! I also noticed that ants were crawling all over the place. So please make sure to clean up any spills. After all dogs took turns playing, I did some dishes and mopped.  It was a great shift, and when I left everyone was happy. 
15	2017-03-31 08:30:00	3 hours	\N
16	2017-03-31 20:30:00	3 hours	\N
17	2017-03-31 21:30:00	2 hours	\N
18	2017-03-31 22:30:00	3 hours	\N
19	2017-03-01 02:30:00	3 hours	\N
20	2017-03-01 02:30:00	3 hours	\N
21	2017-03-01 02:30:00	3 hours	\N
22	2017-03-01 02:30:00	3 hours	\N
23	2017-03-01 02:30:00	3 hours	\N
24	2017-03-01 02:30:00	3 hours	\N
25	2017-03-01 02:30:00	3 hours	\N
26	2017-03-01 02:30:00	3 hours	\N
27	2017-03-01 02:30:00	3 hours	\N
28	2017-03-01 02:30:00	3 hours	\N
29	2017-03-01 02:30:00	3 hours	\N
30	2017-03-01 02:30:00	3 hours	\N
31	2017-03-01 02:30:00	3 hours	\N
32	2017-03-01 02:30:00	3 hours	\N
33	2017-03-01 02:30:00	3 hours	\N
34	2017-03-01 02:30:00	3 hours	\N
35	2017-03-01 02:30:00	3 hours	\N
36	2017-03-01 02:30:00	3 hours	\N
37	2017-03-01 02:30:00	3 hours	\N
38	2017-03-01 02:30:00	3 hours	\N
39	2017-03-01 02:30:00	3 hours	\N
40	2017-03-01 02:30:00	3 hours	\N
41	2017-03-01 02:30:00	3 hours	\N
42	2017-03-01 02:30:00	3 hours	\N
43	2017-03-01 02:30:00	3 hours	\N
44	2017-03-01 02:30:00	3 hours	\N
45	2017-03-01 02:30:00	3 hours	\N
\.


--
-- Name: shift_shift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('shift_shift_id_seq', 45, true);


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
    ADD CONSTRAINT dogplaymates_pkey PRIMARY KEY (id, shift_id);


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

