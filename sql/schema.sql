--
-- PostgreSQL database dump
--

\restrict Gx3gFjoZnxggDopvLUBruBOnzHPeZ3dhQZbZ5TS3rKujd96SVv5SDHlyYpzqeSL

-- Dumped from database version 15.18 (Debian 15.18-0+deb12u1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-0+deb12u1)

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
-- Name: family; Type: TABLE; Schema: public; Owner: tephl
--

CREATE TABLE public.family (
    family_id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.family OWNER TO tephl;

--
-- Name: family_family_id_seq; Type: SEQUENCE; Schema: public; Owner: tephl
--

CREATE SEQUENCE public.family_family_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_family_id_seq OWNER TO tephl;

--
-- Name: family_family_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tephl
--

ALTER SEQUENCE public.family_family_id_seq OWNED BY public.family.family_id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: tephl
--

CREATE TABLE public.people (
    person_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    last_name character varying(100) NOT NULL,
    gender character varying(20),
    disabilities text[],
    age smallint,
    city character varying(100),
    barangay character varying(100),
    street character varying(150),
    address character varying(100),
    CONSTRAINT people_age_check CHECK ((age >= 0))
);


ALTER TABLE public.people OWNER TO tephl;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: tephl
--

CREATE SEQUENCE public.people_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_person_id_seq OWNER TO tephl;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tephl
--

ALTER SEQUENCE public.people_person_id_seq OWNED BY public.people.person_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: tephl
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO tephl;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: tephl
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO tephl;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tephl
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: tephl
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    phone_number character varying(20),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone,
    person_id integer NOT NULL,
    role_id integer NOT NULL,
    family_id integer
);


ALTER TABLE public.users OWNER TO tephl;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: tephl
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO tephl;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tephl
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: family family_id; Type: DEFAULT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.family ALTER COLUMN family_id SET DEFAULT nextval('public.family_family_id_seq'::regclass);


--
-- Name: people person_id; Type: DEFAULT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.people ALTER COLUMN person_id SET DEFAULT nextval('public.people_person_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.family (family_id, name) FROM stdin;
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.people (person_id, first_name, middle_name, last_name, gender, disabilities, age, city, barangay, street, address) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.roles (role_id, name) FROM stdin;
100	citizens
911	dispatcher
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.users (user_id, username, phone_number, created_at, archived_at, person_id, role_id, family_id) FROM stdin;
\.


--
-- Name: family_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tephl
--

SELECT pg_catalog.setval('public.family_family_id_seq', 1, false);


--
-- Name: people_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tephl
--

SELECT pg_catalog.setval('public.people_person_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tephl
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tephl
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pkey PRIMARY KEY (family_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users users_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_family_id_fkey FOREIGN KEY (family_id) REFERENCES public.family(family_id) ON DELETE SET NULL;


--
-- Name: users users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(person_id) ON DELETE CASCADE;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict Gx3gFjoZnxggDopvLUBruBOnzHPeZ3dhQZbZ5TS3rKujd96SVv5SDHlyYpzqeSL

