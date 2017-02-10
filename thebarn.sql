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
-- Name: barncrew; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE barncrew (
    crew_id integer NOT NULL,
    fname character varying(20) NOT NULL,
    lname character varying(20) NOT NULL,
    email character varying(30) NOT NULL,
    phone character varying(20) NOT NULL,
    pos_code character varying(10) NOT NULL,
    password character varying(30) NOT NULL
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
    id integer NOT NULL,
    shift_id integer NOT NULL,
    crew_id integer NOT NULL,
    mentor_id integer
);


ALTER TABLE barncrewshift OWNER TO vagrant;

--
-- Name: barncrewshift_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE barncrewshift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE barncrewshift_id_seq OWNER TO vagrant;

--
-- Name: barncrewshift_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE barncrewshift_id_seq OWNED BY barncrewshift.id;


--
-- Name: dog; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dog (
    dog_id integer NOT NULL,
    dog_name character varying(20),
    kennel_id integer NOT NULL,
    breed character varying(20) NOT NULL,
    gender character varying(10) NOT NULL,
    altered boolean NOT NULL,
    age integer NOT NULL,
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
-- Name: dogshift; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE dogshift (
    shift_id integer NOT NULL,
    dog_id integer NOT NULL,
    notes character varying(3000) NOT NULL
);


ALTER TABLE dogshift OWNER TO vagrant;

--
-- Name: kennel; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE kennel (
    kennel_id integer NOT NULL,
    dog_door boolean DEFAULT true NOT NULL,
    size character varying(10) NOT NULL,
    indoor boolean DEFAULT true NOT NULL
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
    pos_code character varying(10) NOT NULL,
    pos character varying(20) NOT NULL
);


ALTER TABLE positions OWNER TO vagrant;

--
-- Name: shift; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE shift (
    shift_id integer NOT NULL,
    date_time timestamp without time zone NOT NULL,
    duration character varying(10) NOT NULL,
    notes character varying(3000) NOT NULL
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
-- Name: crew_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew ALTER COLUMN crew_id SET DEFAULT nextval('barncrew_crew_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift ALTER COLUMN id SET DEFAULT nextval('barncrewshift_id_seq'::regclass);


--
-- Name: dog_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog ALTER COLUMN dog_id SET DEFAULT nextval('dog_dog_id_seq'::regclass);


--
-- Name: kennel_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY kennel ALTER COLUMN kennel_id SET DEFAULT nextval('kennel_kennel_id_seq'::regclass);


--
-- Name: shift_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY shift ALTER COLUMN shift_id SET DEFAULT nextval('shift_shift_id_seq'::regclass);


--
-- Data for Name: barncrew; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY barncrew (crew_id, fname, lname, email, phone, pos_code, password) FROM stdin;
\.


--
-- Name: barncrew_crew_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('barncrew_crew_id_seq', 1, false);


--
-- Data for Name: barncrewshift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY barncrewshift (id, shift_id, crew_id, mentor_id) FROM stdin;
\.


--
-- Name: barncrewshift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('barncrewshift_id_seq', 1, false);


--
-- Data for Name: dog; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dog (dog_id, dog_name, kennel_id, breed, gender, altered, age, intake_date) FROM stdin;
\.


--
-- Name: dog_dog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dog_dog_id_seq', 1, false);


--
-- Data for Name: dogshift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dogshift (shift_id, dog_id, notes) FROM stdin;
\.


--
-- Data for Name: kennel; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY kennel (kennel_id, dog_door, size, indoor) FROM stdin;
\.


--
-- Name: kennel_kennel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('kennel_kennel_id_seq', 1, false);


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY positions (pos_code, pos) FROM stdin;
\.


--
-- Data for Name: shift; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY shift (shift_id, date_time, duration, notes) FROM stdin;
\.


--
-- Name: shift_shift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('shift_shift_id_seq', 1, false);


--
-- Name: barncrew_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrew
    ADD CONSTRAINT barncrew_pkey PRIMARY KEY (crew_id);


--
-- Name: barncrewshift_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_pkey PRIMARY KEY (id);


--
-- Name: dog_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog
    ADD CONSTRAINT dog_pkey PRIMARY KEY (dog_id);


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
-- Name: barncrewshift_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES barncrew(crew_id);


--
-- Name: barncrewshift_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY barncrewshift
    ADD CONSTRAINT barncrewshift_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES shift(shift_id);


--
-- Name: dog_kennel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dog
    ADD CONSTRAINT dog_kennel_id_fkey FOREIGN KEY (kennel_id) REFERENCES kennel(kennel_id);


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


