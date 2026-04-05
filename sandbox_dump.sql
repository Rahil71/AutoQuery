--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text,
    email text
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    order_date date
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text,
    price integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, email) FROM stdin;
1	Rahil	rahil@gmail.com
2	John	john@gmail.com
3	Alice	alice@gmail.com
4	Bob	bob@gmail.com
5	Charlie	charlie@gmail.com
6	David	david@gmail.com
7	Eve	eve@gmail.com
8	Frank	frank@gmail.com
9	Grace	grace@gmail.com
10	Hank	hank@gmail.com
11	Ivy	ivy@gmail.com
12	Jack	jack@gmail.com
13	Karen	karen@gmail.com
14	Leo	leo@gmail.com
15	Mona	mona@gmail.com
16	Nina	nina@gmail.com
17	Oscar	oscar@gmail.com
18	Paul	paul@gmail.com
19	Quinn	quinn@gmail.com
20	Rose	rose@gmail.com
21	Steve	steve@gmail.com
22	Tina	tina@gmail.com
23	Uma	uma@gmail.com
24	Victor	victor@gmail.com
25	Wendy	wendy@gmail.com
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity) FROM stdin;
1	1	1	3
2	1	2	2
3	1	3	5
4	1	4	1
5	1	5	2
6	1	6	1
7	2	2	4
8	2	3	3
9	2	6	2
10	2	7	1
11	2	8	2
12	2	9	1
13	3	1	2
14	3	4	3
15	3	5	2
16	3	9	4
17	3	10	1
18	4	1	1
19	4	2	2
20	4	6	3
21	4	8	2
22	4	10	1
23	4	11	2
24	5	3	3
25	5	4	2
26	5	7	1
27	5	11	2
28	5	12	1
29	6	5	2
30	6	6	4
31	6	9	3
32	6	12	2
33	6	13	1
34	7	2	2
35	7	7	1
36	7	8	2
37	7	13	3
38	7	14	1
39	8	1	3
40	8	4	2
41	8	6	1
42	8	14	2
43	8	15	1
44	9	3	1
45	9	5	2
46	9	9	2
47	9	10	1
48	9	16	3
49	10	2	4
50	10	4	3
51	10	8	2
52	10	11	1
53	10	17	2
54	11	1	2
55	11	5	3
56	11	6	1
57	11	18	2
58	11	19	1
59	12	2	1
60	12	3	4
61	12	7	2
62	12	12	3
63	12	20	1
64	13	4	2
65	13	5	3
66	13	9	1
67	13	13	2
68	13	21	1
69	14	1	1
70	14	3	2
71	14	6	3
72	14	8	1
73	14	22	2
74	15	2	2
75	15	4	1
76	15	7	3
77	15	10	2
78	15	23	1
79	16	3	4
80	16	5	2
81	16	9	1
82	16	11	2
83	16	24	3
84	17	1	3
85	17	6	1
86	17	8	2
87	17	12	2
88	17	25	1
89	18	2	2
90	18	4	3
91	18	7	1
92	18	13	2
93	18	14	1
94	19	3	1
95	19	5	2
96	19	9	3
97	19	15	2
98	19	16	1
99	20	1	2
100	20	6	3
101	20	8	2
102	20	17	1
103	20	18	2
104	21	2	1
105	21	4	2
106	21	7	3
107	21	10	1
108	21	19	2
109	22	3	2
110	22	5	1
111	22	9	4
112	22	12	2
113	22	20	1
114	23	1	3
115	23	6	2
116	23	11	1
117	23	13	3
118	23	21	2
119	24	2	2
120	24	4	3
121	24	8	1
122	24	14	2
123	24	22	1
124	25	3	1
125	25	5	3
126	25	9	2
127	25	15	1
128	25	16	2
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_id, order_date) FROM stdin;
1	1	2024-01-01
2	2	2024-01-02
3	3	2024-01-03
4	4	2024-01-04
5	5	2024-01-05
6	6	2024-01-06
7	7	2024-01-07
8	8	2024-01-08
9	9	2024-01-09
10	10	2024-01-10
11	11	2024-01-11
12	12	2024-01-12
13	13	2024-01-13
14	14	2024-01-14
15	15	2024-01-15
16	16	2024-01-16
17	17	2024-01-17
18	18	2024-01-18
19	19	2024-01-19
20	20	2024-01-20
21	21	2024-01-21
22	22	2024-01-22
23	23	2024-01-23
24	24	2024-01-24
25	25	2024-01-25
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price) FROM stdin;
1	Laptop	80000
2	Phone	40000
3	Headphones	2000
4	Keyboard	1500
5	Mouse	800
6	Monitor	12000
7	Tablet	30000
8	Smartwatch	10000
9	Camera	50000
10	Printer	7000
11	Speaker	3000
12	Router	2500
13	Hard Drive	6000
14	SSD	9000
15	USB Drive	700
16	Power Bank	1500
17	Charger	1200
18	Webcam	3500
19	Microphone	4500
20	Gaming Chair	15000
21	Desk Lamp	2000
22	Projector	25000
23	VR Headset	45000
24	Drone	60000
25	Graphics Card	70000
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 25, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 128, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 25, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 25, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- PostgreSQL database dump complete
--

