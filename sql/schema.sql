--
-- PostgreSQL database dump
--

\restrict q5r4WfykBBquSbcVzRr1r5FsWU5WGAE2kxxOb7oYeTcFjbwA9tai0EAJ5Eq6DoP

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
    CONSTRAINT family_members_status_check CHECK (
        ((status)::text = ANY (
            (ARRAY[
                'pending'::character varying,
                'accepted'::character varying,
                'rejected'::character varying
            ])::text[]
        ))
    )
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

ALTER SEQUENCE public.family_members_family_member_id_seq
OWNED BY public.family_members.family_member_id;

--
-- Name: images; Type: TABLE; Schema: public; Owner: tephl
--

CREATE TABLE public.images (
    image_id integer NOT NULL,
    public_url text,
    created_at timestamp with time zone DEFAULT now(),
    submitted_by integer
);


ALTER TABLE public.images OWNER TO tephl;

--
-- Name: images_image_id_seq; Type: SEQUENCE; Schema: public; Owner: tephl
--

CREATE SEQUENCE public.images_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_image_id_seq OWNER TO tephl;

--
-- Name: images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tephl
--

ALTER SEQUENCE public.images_image_id_seq OWNED BY public.images.image_id;


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

ALTER SEQUENCE public.people_person_id_seq
OWNED BY public.people.person_id;

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

ALTER SEQUENCE public.roles_role_id_seq
OWNED BY public.roles.role_id;

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

ALTER SEQUENCE public.users_user_id_seq
OWNED BY public.users.user_id;

--
-- Name: family family_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ALTER COLUMN family_id
    SET DEFAULT nextval('public.family_family_id_seq'::regclass);


--
-- Name: images image_id; Type: DEFAULT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.images ALTER COLUMN image_id SET DEFAULT nextval('public.images_image_id_seq'::regclass);

--
-- Name: family_members family_member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ALTER COLUMN family_member_id
    SET DEFAULT nextval('public.family_members_family_member_id_seq'::regclass);

--
-- Name: people person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ALTER COLUMN person_id
    SET DEFAULT nextval('public.people_person_id_seq'::regclass);

--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ALTER COLUMN role_id
    SET DEFAULT nextval('public.roles_role_id_seq'::regclass);

--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ALTER COLUMN user_id
    SET DEFAULT nextval('public.users_user_id_seq'::regclass);

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

COPY public.family_members
(family_member_id, family_id, user_id, relation, status)
FROM stdin;
1	4	11	mother	accepted
2	4	12	son	accepted
\.

--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.images (image_id, public_url, created_at, submitted_by) FROM stdin;
1	http://res.cloudinary.com/pi52m6i7/image/upload/v1787127573/2026_08_19/ddwwnyi1urf8iytz0rfw.png	\N	6
2	http://res.cloudinary.com/pi52m6i7/image/upload/v1787127677/2026_08_19/uoawvwow8n6fpioamidm.png	2026-08-19 16:21:24.457726+08	6
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: tephl
--

COPY public.people
(person_id, first_name, middle_name, last_name, gender, disabilities, age, city, barangay, street, address)
FROM stdin;
6	rhez	\N	astrera	male	\N	18	malolos	pinagbakahan	\N	lot 7
7	rhez	\N	astrera	male	\N	18	malolos	pinagbakahan	\N	lot 7
8	rhez	\N	lee	male	\N	18	malolos	pinagbakahan	\N	lot 7
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

COPY public.users
(user_id, username, phone_number, created_at, archived_at, person_id, role_id, family_id, hashed_password)
FROM stdin;
6	tephL	090909	2026-08-18 10:45:56.00047+08	\N	8	100	\N	$2b$10$48KRv.GiCyNOZu/c3x5aUe0nqA/U4UzUxgZzlLOgv4DUAkwTadGpC
9	testuser	09171234567	2026-08-18 01:38:56.616648-04	\N	\N	100	3	$2b$10$WK6GqTA209MPPWbIVJC3PenLy8bmLk/KWu5IwEBt8iXrTNuvNnSM.
10	newuser2	09181234567	2026-08-18 03:47:24.300473-04	\N	\N	100	1	$2b$10$vuirAue9xxnSVpzB1N4aV.RAGtYKnUtOD7fniL2W4btNv6UKiVOse
11	tungtungsahur	9662081096	2026-08-19 15:13:29.065517+08	\N	\N	100	\N	$2b$10$2wHhpLGpc5/GpJuKDYe6feyzvMbF8ZAmkv4rmV/p1UYEokSEMJIgC
12	testtest	9662081099	2026-08-19 15:25:49.265533+08	\N	\N	100	\N	$2b$10$7BsclZj/EI112pIdI1cf7uFdGy4BxAQUP5j14QdclPnlZ8X1OZq4K

\.

--
-- Name: family_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(
    'public.family_family_id_seq',
    6,
    true
);

--
-- Name: images_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tephl
--

SELECT pg_catalog.setval('public.images_image_id_seq', 2, true);


--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(
    'public.family_members_family_member_id_seq',
    6,
    true
);

--
-- Name: people_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(
    'public.people_person_id_seq',
    8,
    true
);

--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(
    'public.roles_role_id_seq',
    1,
    false
);

--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(
    'public.users_user_id_seq',
    16,
    true
);

SELECT pg_catalog.setval('public.users_user_id_seq', 12, true);

--
-- Name: family_members family_members_family_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_family_id_user_id_key
    UNIQUE (family_id, user_id);
  
--
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey
    PRIMARY KEY (family_member_id);

--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pkey
    PRIMARY KEY (family_id);

--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey
    PRIMARY KEY (person_id);

--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key
    UNIQUE (name);

--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey
    PRIMARY KEY (role_id);

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey
    PRIMARY KEY (user_id);

--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key
    UNIQUE (username);

--
-- Name: one_accepted_family_per_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_accepted_family_per_user
ON public.family_members
USING btree (user_id)
WHERE ((status)::text = 'accepted'::text);

--
-- Name: family family_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- Name: images images_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_users_id_fkey FOREIGN KEY (submitted_by) REFERENCES public.users(user_id);


--
-- Name: users users_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tephl
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_created_by_fkey
    FOREIGN KEY (created_by)
    REFERENCES public.users(user_id);

--
-- Name: family_members family_members_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_family_id_fkey
    FOREIGN KEY (family_id)
    REFERENCES public.family(family_id)
    ON DELETE CASCADE;

--
-- Name: family_members family_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_user_id_fkey
    FOREIGN KEY (user_id)
    REFERENCES public.users(user_id)
    ON DELETE CASCADE;

--
-- Name: users users_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_family_id_fkey
    FOREIGN KEY (family_id)
    REFERENCES public.family(family_id)
    ON DELETE SET NULL;

--
-- Name: users users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_person_id_fkey
    FOREIGN KEY (person_id)
    REFERENCES public.people(person_id)
    ON DELETE CASCADE;

--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey
    FOREIGN KEY (role_id)
    REFERENCES public.roles(role_id)
    ON DELETE RESTRICT;


-- ==================================================================
-- Dispatcher teams / clusters / assignments
-- Hand-appended to match sql/migrations/2026-08-23-dispatcher-teams.sql.
-- These will fold into the pg_dump layout on the next full dump.
-- ==================================================================

CREATE TABLE public.team (
    team_id integer NOT NULL,
    name character varying(150) NOT NULL,
    contact_number character varying(50),
    location_text character varying(255),
    latitude double precision,
    longitude double precision,
    status character varying(20) DEFAULT 'available'::character varying NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT team_status_check CHECK (
        ((status)::text = ANY ((ARRAY['available'::character varying, 'busy'::character varying, 'offline'::character varying])::text[]))
    )
);

CREATE SEQUENCE public.team_team_id_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.team_team_id_seq OWNED BY public.team.team_id;

ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (team_id);

CREATE TABLE public.cluster (
    cluster_id integer NOT NULL,
    name character varying(150) NOT NULL,
    latitude double precision,
    longitude double precision,
    priority character varying(20) DEFAULT 'medium'::character varying NOT NULL,
    status character varying(20) DEFAULT 'open'::character varying NOT NULL,
    report_count integer DEFAULT 0 NOT NULL,
    people_affected integer DEFAULT 0 NOT NULL,
    ai_summary text,
    action_plan jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT cluster_priority_check CHECK (
        ((priority)::text = ANY ((ARRAY['high'::character varying, 'medium'::character varying, 'low'::character varying])::text[]))
    ),
    CONSTRAINT cluster_status_check CHECK (
        ((status)::text = ANY ((ARRAY['open'::character varying, 'saved'::character varying, 'resolved'::character varying])::text[]))
    )
);

CREATE SEQUENCE public.cluster_cluster_id_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.cluster_cluster_id_seq OWNED BY public.cluster.cluster_id;

ALTER TABLE ONLY public.cluster ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_cluster_id_seq'::regclass);

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_id);

CREATE TABLE public.assignment (
    assignment_id integer NOT NULL,
    team_id integer NOT NULL,
    cluster_id integer NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT assignment_status_check CHECK (
        ((status)::text = ANY ((ARRAY['pending'::character varying, 'dispatched'::character varying, 'resolved'::character varying])::text[]))
    )
);

CREATE SEQUENCE public.assignment_assignment_id_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.assignment_assignment_id_seq OWNED BY public.assignment.assignment_id;

ALTER TABLE ONLY public.assignment ALTER COLUMN assignment_id SET DEFAULT nextval('public.assignment_assignment_id_seq'::regclass);

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_pkey PRIMARY KEY (assignment_id);

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.team(team_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster(cluster_id) ON DELETE CASCADE;

CREATE INDEX idx_assignment_team ON public.assignment USING btree (team_id);
CREATE INDEX idx_assignment_cluster ON public.assignment USING btree (cluster_id);

--
-- PostgreSQL database dump complete
--

\unrestrict q5r4WfykBBquSbcVzRr1r5FsWU5WGAE2kxxOb7oYeTcFjbwA9tai0EAJ5Eq6DoP

