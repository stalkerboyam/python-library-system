--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

-- Started on 2018-05-02 20:44:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE myapp;
--
-- TOC entry 2831 (class 1262 OID 16395)
-- Name: myapp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myapp WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE myapp OWNER TO postgres;

\connect myapp

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2834 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16431)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    name text,
    book_code text,
    category_id integer,
    price double precision,
    quantity integer,
    available_quantity integer,
    id integer NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16453)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 2835 (class 0 OID 0)
-- Dependencies: 199
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 198 (class 1259 OID 16439)
-- Name: borrow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.borrow (
    user_id integer,
    book_id integer,
    borrow_date date,
    return_date date,
    returned integer,
    borrow_id integer NOT NULL
);


ALTER TABLE public.borrow OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16503)
-- Name: borrow_borrow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.borrow_borrow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.borrow_borrow_id_seq OWNER TO postgres;

--
-- TOC entry 2836 (class 0 OID 0)
-- Dependencies: 203
-- Name: borrow_borrow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.borrow_borrow_id_seq OWNED BY public.borrow.borrow_id;


--
-- TOC entry 200 (class 1259 OID 16476)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_name text,
    category_id integer NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16494)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO postgres;

--
-- TOC entry 2837 (class 0 OID 0)
-- Dependencies: 202
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 196 (class 1259 OID 16415)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username text,
    password text,
    phone text,
    role integer,
    first_name text,
    last_name text,
    user_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16485)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 2838 (class 0 OID 0)
-- Dependencies: 201
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 2692 (class 2604 OID 16455)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 2693 (class 2604 OID 16505)
-- Name: borrow borrow_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow ALTER COLUMN borrow_id SET DEFAULT nextval('public.borrow_borrow_id_seq'::regclass);


--
-- TOC entry 2694 (class 2604 OID 16496)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- TOC entry 2691 (class 2604 OID 16487)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 2819 (class 0 OID 16431)
-- Dependencies: 197
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books (name, book_code, category_id, price, quantity, available_quantity, id) VALUES ('Database 2', 'CS308', 2, 3200, 280, 98, 23);
INSERT INTO public.books (name, book_code, category_id, price, quantity, available_quantity, id) VALUES ('Ahmed and the cityZ', 'cityZ', 2, 120, 120, 220, 20);
INSERT INTO public.books (name, book_code, category_id, price, quantity, available_quantity, id) VALUES ('Fo2sh and the liverpool team', 'FBO', 1, 300, 20, 983, 17);
INSERT INTO public.books (name, book_code, category_id, price, quantity, available_quantity, id) VALUES ('DB2', 'cs308', 2, 200, 100, 100, 24);


--
-- TOC entry 2820 (class 0 OID 16439)
-- Dependencies: 198
-- Data for Name: borrow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.borrow (user_id, book_id, borrow_date, return_date, returned, borrow_id) VALUES (1, 20, '2018-05-01', NULL, NULL, 27);
INSERT INTO public.borrow (user_id, book_id, borrow_date, return_date, returned, borrow_id) VALUES (1, 17, '2018-05-01', NULL, NULL, 28);


--
-- TOC entry 2822 (class 0 OID 16476)
-- Dependencies: 200
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (category_name, category_id) VALUES ('Math', 1);
INSERT INTO public.categories (category_name, category_id) VALUES ('CS', 2);
INSERT INTO public.categories (category_name, category_id) VALUES ('ADV Math2', 4);


--
-- TOC entry 2818 (class 0 OID 16415)
-- Dependencies: 196
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (username, password, phone, role, first_name, last_name, user_id) VALUES ('AAAAAAAAA', 'AAAA', '1112Z', 2, 'AXXXX', 'BXXXXX', 2);
INSERT INTO public.users (username, password, phone, role, first_name, last_name, user_id) VALUES ('wqe', '2ewq', '12', 2, 'x', 'dqw', 3);
INSERT INTO public.users (username, password, phone, role, first_name, last_name, user_id) VALUES ('ahmed', '123', '11111', 1, 'ahmed', 'mostafa', 1);
INSERT INTO public.users (username, password, phone, role, first_name, last_name, user_id) VALUES ('SuperAdmin', 'SuperAdmin', '20009', 2, 'Super', 'Super', 7);


--
-- TOC entry 2839 (class 0 OID 0)
-- Dependencies: 199
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 24, true);


--
-- TOC entry 2840 (class 0 OID 0)
-- Dependencies: 203
-- Name: borrow_borrow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.borrow_borrow_id_seq', 28, true);


--
-- TOC entry 2841 (class 0 OID 0)
-- Dependencies: 202
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 4, true);


--
-- TOC entry 2842 (class 0 OID 0)
-- Dependencies: 201
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);


--
-- TOC entry 2696 (class 2606 OID 16510)
-- Name: borrow primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow
    ADD CONSTRAINT "primary" PRIMARY KEY (borrow_id);


--
-- TOC entry 2833 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-05-02 20:44:15

--
-- PostgreSQL database dump complete
--

