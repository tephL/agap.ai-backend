--
-- PostgreSQL database dump
--

\restrict J85icEfSqFDOHmdpKfd6hHYTXpxAO8G1lONb0oFyPkigL8vFbPnTMr1IFr1NTrm

-- Dumped from database version 17.10 (Debian 17.10-0+deb13u1)
-- Dumped by pg_dump version 17.10 (Debian 17.10-0+deb13u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family (
    family_id integer NOT NULL,
    name character varying(150) NOT NULL,
    created_by integer
);


ALTER TABLE public.family OWNER TO postgres;

--
-- Name: family_family_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_family_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_family_id_seq OWNER TO postgres;

--
-- Name: family_family_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_family_id_seq OWNED BY public.family.family_id;


--
-- Name: family_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_members (
    family_member_id integer NOT NULL,
    family_id integer NOT NULL,
    user_id integer NOT NULL,
    relation character varying(50) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    CONSTRAINT family_members_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.family_members OWNER TO postgres;

--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_members_family_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_members_family_member_id_seq OWNER TO postgres;

--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_members_family_member_id_seq OWNED BY public.family_members.family_member_id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.people OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.people_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_person_id_seq OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.people_person_id_seq OWNED BY public.people.person_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    phone_number character varying(20),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone,
    person_id integer,
    role_id integer NOT NULL,
    family_id integer,
    hashed_password character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: family family_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family ALTER COLUMN family_id SET DEFAULT nextval('public.family_family_id_seq'::regclass);


--
-- Name: family_members family_member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members ALTER COLUMN family_member_id SET DEFAULT nextval('public.family_members_family_member_id_seq'::regclass);


--
-- Name: people person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN person_id SET DEFAULT nextval('public.people_person_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family (family_id, name, created_by) FROM stdin;
1	Test Family for Members	\N
3	Fresh Test Family	\N
4	The Santos Family	\N
\.


--
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_members (family_member_id, family_id, user_id, relation, status) FROM stdin;
1	4	11	mother	accepted
2	4	12	son	accepted
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (person_id, first_name, middle_name, last_name, gender, disabilities, age, city, barangay, street, address) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, name) FROM stdin;
100	citizens
911	dispatcher
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, phone_number, created_at, archived_at, person_id, role_id, family_id, hashed_password) FROM stdin;
6	tephL	090909	2026-08-17 22:45:56.00047-04	\N	\N	100	\N	$2b$10$48KRv.GiCyNOZu/c3x5aUe0nqA/U4UzUxgZzlLOgv4DUAkwTadGpC
9	testuser	09171234567	2026-08-18 01:38:56.616648-04	\N	\N	100	3	$2b$10$WK6GqTA209MPPWbIVJC3PenLy8bmLk/KWu5IwEBt8iXrTNuvNnSM.
10	newuser2	09181234567	2026-08-18 03:47:24.300473-04	\N	\N	100	1	$2b$10$vuirAue9xxnSVpzB1N4aV.RAGtYKnUtOD7fniL2W4btNv6UKiVOse
11	mother_45	0917450	2026-08-19 00:49:22.090434-04	\N	\N	100	\N	$2b$10$Oc2VPcDyaqJhIpCJwS4yaeP9fQheaMuxSvWO9mgVlQFQ.4reCpdmO
12	son_45	0918451	2026-08-19 00:49:22.933997-04	\N	\N	100	\N	$2b$10$UPUZbOxzUYExyi0EIJXcn.K/81jWxYJ8J1.tEWJwZIrMMxdTk5FKy
13	mother_628	09176280	2026-08-19 01:05:51.031106-04	\N	\N	100	\N	$2b$10$QL3KHhin48So1AEN8fItGeeN/DS0GFwcP2gWI0yOBJkczSFhKexyu
14	son_628	09186281	2026-08-19 01:05:51.735953-04	\N	\N	100	\N	$2b$10$Ib5ExQmyBXASDRpg2GuD/unPxBo1loK0YYNyMTUh.b4IE2DrCWnsm
15	mother_28422	0917284220	2026-08-19 01:11:21.082703-04	\N	\N	100	\N	$2b$10$HhuKZXPPFicW9G9gbTQcReG8FEcyvcDJk7tqBpi/3o6Zn70uFZ7kK
16	son_28422	0918284221	2026-08-19 01:11:21.806642-04	\N	\N	100	\N	$2b$10$XjKJ.lbjWuOOKD/YIf43QeK9VUqup.a7msUuhU3SsEyUhu1mulRYW
17	mother_32331	0917323310	2026-08-19 01:36:07.628103-04	\N	\N	100	\N	$2b$10$dJ7MBQ5N2iCyJJG4p4XNb.zyEGOFXDqo2s5YzTWu541yE2k9Xv3EW
18	son_32331	0918323311	2026-08-19 01:36:08.370882-04	\N	\N	100	\N	$2b$10$jh0YV8/xjuEo3K1ID0JLyOqKDOxMvHPM5cMRvWm/ce4O5XflUv5ua
19	mother_23369	0917233690	2026-08-19 01:46:51.242344-04	\N	\N	100	\N	$2b$10$OMIrfSENJnj1BAtz3S38IeLSTNzQ9KboIcJ5kdW/HGFu6rAuPD5a6
20	son_23369	0918233691	2026-08-19 01:46:51.976039-04	\N	\N	100	\N	$2b$10$8HxaG4GbQys3zpZO8p/gXusrKZltYIL12NbG1jdNMf8t.AjWumQs.
21	mother_18055	0917180550	2026-08-19 02:40:27.765284-04	\N	\N	100	\N	$2b$10$9iOz4bvIBB.kIL19S67HKO/LT97ESwq6TUu/4VdSwEe5dJD0ZT9tK
22	son_18055	0918180551	2026-08-19 02:40:31.242026-04	\N	\N	100	\N	$2b$10$iFbPHWsD4qyaUL6ElHGV0O6TXCp./Z32QKZLgDFvZZ/XAPMQOjBPe
23	mother_20425	0917204250	2026-08-19 02:44:39.802499-04	\N	\N	100	\N	$2b$10$fMPgTCvtqbEAB9/Z6F.DmOQ.qWq.oVzqFgA03Xta0hjP5s79wxPTu
24	son_20425	0918204251	2026-08-19 02:44:40.722408-04	\N	\N	100	\N	$2b$10$zL5BPrVu6rQ5BzxV0UiB0O2eZ8FNGbK477V6Db1uidqszOTNzjnMa
\.


--
-- Name: family_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_family_id_seq', 10, true);


--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_members_family_member_id_seq', 14, true);


--
-- Name: people_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.people_person_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 24, true);


--
-- Name: family_members family_members_family_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_family_id_user_id_key UNIQUE (family_id, user_id);


--
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (family_member_id);


--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pkey PRIMARY KEY (family_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: one_accepted_family_per_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_accepted_family_per_user ON public.family_members USING btree (user_id) WHERE ((status)::text = 'accepted'::text);


--
-- Name: family family_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: family_members family_members_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_family_id_fkey FOREIGN KEY (family_id) REFERENCES public.family(family_id) ON DELETE CASCADE;


--
-- Name: family_members family_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: users users_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_family_id_fkey FOREIGN KEY (family_id) REFERENCES public.family(family_id) ON DELETE SET NULL;


--
-- Name: users users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(person_id) ON DELETE CASCADE;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict J85icEfSqFDOHmdpKfd6hHYTXpxAO8G1lONb0oFyPkigL8vFbPnTMr1IFr1NTrm

