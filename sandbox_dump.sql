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
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    appointment_date date,
    status character varying(20)
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_appointment_id_seq OWNER TO postgres;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: billing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing (
    bill_id integer NOT NULL,
    appointment_id integer,
    total_amount numeric(10,2),
    payment_status character varying(20),
    payment_date date
);


ALTER TABLE public.billing OWNER TO postgres;

--
-- Name: billing_bill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.billing_bill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.billing_bill_id_seq OWNER TO postgres;

--
-- Name: billing_bill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.billing_bill_id_seq OWNED BY public.billing.bill_id;


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctors (
    doctor_id integer NOT NULL,
    name character varying(100),
    specialization character varying(50),
    experience integer,
    consultation_fee numeric(10,2)
);


ALTER TABLE public.doctors OWNER TO postgres;

--
-- Name: doctors_doctor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctors_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doctors_doctor_id_seq OWNER TO postgres;

--
-- Name: doctors_doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctors_doctor_id_seq OWNED BY public.doctors.doctor_id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    name character varying(100),
    age integer,
    gender character varying(10),
    city character varying(50),
    registration_date date
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patients_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patients_patient_id_seq OWNER TO postgres;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patients_patient_id_seq OWNED BY public.patients.patient_id;


--
-- Name: treatments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treatments (
    treatment_id integer NOT NULL,
    appointment_id integer,
    diagnosis character varying(100),
    treatment_description text,
    cost numeric(10,2)
);


ALTER TABLE public.treatments OWNER TO postgres;

--
-- Name: treatments_treatment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treatments_treatment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatments_treatment_id_seq OWNER TO postgres;

--
-- Name: treatments_treatment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treatments_treatment_id_seq OWNED BY public.treatments.treatment_id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);


--
-- Name: billing bill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing ALTER COLUMN bill_id SET DEFAULT nextval('public.billing_bill_id_seq'::regclass);


--
-- Name: doctors doctor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors ALTER COLUMN doctor_id SET DEFAULT nextval('public.doctors_doctor_id_seq'::regclass);


--
-- Name: patients patient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients ALTER COLUMN patient_id SET DEFAULT nextval('public.patients_patient_id_seq'::regclass);


--
-- Name: treatments treatment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatments ALTER COLUMN treatment_id SET DEFAULT nextval('public.treatments_treatment_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (appointment_id, patient_id, doctor_id, appointment_date, status) FROM stdin;
1	1	1	2024-01-10	completed
2	2	2	2024-01-11	completed
3	3	3	2024-01-12	cancelled
4	4	4	2024-01-13	completed
5	5	5	2024-01-14	pending
6	6	6	2024-01-15	completed
7	7	7	2024-01-16	completed
8	8	8	2024-01-17	completed
9	9	9	2024-01-18	pending
10	10	10	2024-01-19	completed
11	11	11	2024-01-20	completed
12	12	12	2024-01-21	completed
13	13	13	2024-01-22	pending
14	14	14	2024-01-23	completed
15	15	15	2024-01-24	completed
16	16	16	2024-01-25	cancelled
17	17	17	2024-01-26	completed
18	18	18	2024-01-27	completed
19	19	19	2024-01-28	pending
20	20	20	2024-01-29	completed
21	21	1	2024-02-01	completed
22	22	2	2024-02-02	completed
23	23	3	2024-02-03	completed
24	24	4	2024-02-04	pending
25	25	5	2024-02-05	completed
26	26	6	2024-02-06	completed
27	27	7	2024-02-07	completed
28	28	8	2024-02-08	completed
29	29	9	2024-02-09	cancelled
30	30	10	2024-02-10	completed
31	31	11	2024-02-11	completed
32	32	12	2024-02-12	completed
33	33	13	2024-02-13	pending
34	34	14	2024-02-14	completed
35	35	15	2024-02-15	completed
36	36	16	2024-02-16	completed
37	37	17	2024-02-17	pending
38	38	18	2024-02-18	completed
39	39	19	2024-02-19	completed
40	40	20	2024-02-20	completed
\.


--
-- Data for Name: billing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.billing (bill_id, appointment_id, total_amount, payment_status, payment_date) FROM stdin;
1	1	6500.00	paid	2024-01-10
2	2	2300.00	paid	2024-01-11
3	4	3300.00	paid	2024-01-13
4	6	1700.00	paid	2024-01-15
5	7	1400.00	paid	2024-01-16
6	8	2200.00	paid	2024-01-17
7	10	8000.00	pending	2024-01-19
8	11	7000.00	paid	2024-01-20
9	12	2100.00	paid	2024-01-21
10	14	3800.00	paid	2024-01-23
11	15	10000.00	pending	2024-01-24
12	17	1500.00	paid	2024-01-26
13	18	2100.00	paid	2024-01-27
14	20	18000.00	paid	2024-01-29
15	21	4500.00	paid	2024-02-01
16	22	2100.00	paid	2024-02-02
17	23	9000.00	paid	2024-02-03
18	25	7000.00	paid	2024-02-05
19	26	2200.00	paid	2024-02-06
20	27	1500.00	paid	2024-02-07
21	28	2000.00	paid	2024-02-08
22	30	9000.00	pending	2024-02-10
23	31	25000.00	paid	2024-02-11
24	32	6500.00	paid	2024-02-12
25	34	4200.00	paid	2024-02-14
26	35	12000.00	paid	2024-02-15
27	36	2000.00	paid	2024-02-16
28	38	2500.00	paid	2024-02-18
29	39	3500.00	paid	2024-02-19
30	40	20000.00	pending	2024-02-20
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctors (doctor_id, name, specialization, experience, consultation_fee) FROM stdin;
1	Dr. Rajesh Kumar	Cardiologist	15	1500.00
2	Dr. Neha Sharma	Dermatologist	10	800.00
3	Dr. Amit Verma	Orthopedic	12	1200.00
4	Dr. Priya Singh	Gynecologist	14	1300.00
5	Dr. Vikram Rao	Neurologist	18	2000.00
6	Dr. Sneha Iyer	Pediatrician	9	900.00
7	Dr. Arjun Nair	General Physician	11	700.00
8	Dr. Kavita Mehta	ENT Specialist	13	1000.00
9	Dr. Rohit Gupta	Psychiatrist	16	1400.00
10	Dr. Meera Joshi	Oncologist	20	2500.00
11	Dr. Karan Patel	Cardiologist	17	1600.00
12	Dr. Simran Kaur	Dermatologist	8	750.00
13	Dr. Aditya Roy	Orthopedic	10	1100.00
14	Dr. Pooja Sharma	Gynecologist	12	1250.00
15	Dr. Manish Yadav	Neurologist	19	2100.00
16	Dr. Naina Kapoor	Pediatrician	7	850.00
17	Dr. Rahul Jain	General Physician	9	650.00
18	Dr. Divya Bansal	ENT Specialist	11	950.00
19	Dr. Gaurav Tiwari	Psychiatrist	14	1350.00
20	Dr. Shreya Ghosh	Oncologist	18	2400.00
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (patient_id, name, age, gender, city, registration_date) FROM stdin;
1	Rahul Sharma	32	Male	Mumbai	2023-01-10
2	Ananya Gupta	28	Female	Delhi	2023-02-12
3	Vikram Singh	45	Male	Pune	2023-03-15
4	Sneha Patil	30	Female	Mumbai	2023-04-18
5	Arjun Mehta	50	Male	Bangalore	2023-05-21
6	Neha Kapoor	27	Female	Delhi	2023-06-10
7	Karan Verma	36	Male	Hyderabad	2023-07-05
8	Priya Nair	41	Female	Chennai	2023-08-08
9	Amit Joshi	29	Male	Pune	2023-09-01
10	Riya Shah	33	Female	Ahmedabad	2023-10-03
11	Sahil Khan	38	Male	Mumbai	2023-01-25
12	Meera Iyer	44	Female	Chennai	2023-02-20
13	Rohit Das	52	Male	Kolkata	2023-03-10
14	Pooja Kulkarni	35	Female	Pune	2023-04-22
15	Yash Jain	31	Male	Jaipur	2023-05-15
16	Divya Bansal	26	Female	Delhi	2023-06-18
17	Aditya Roy	48	Male	Kolkata	2023-07-20
18	Simran Kaur	29	Female	Chandigarh	2023-08-14
19	Manish Tiwari	55	Male	Lucknow	2023-09-19
20	Kavya Reddy	34	Female	Hyderabad	2023-10-23
21	Nikhil Agarwal	37	Male	Delhi	2023-01-12
22	Isha Malhotra	25	Female	Mumbai	2023-02-17
23	Harsh Vardhan	42	Male	Patna	2023-03-21
24	Tanvi Desai	39	Female	Surat	2023-04-26
25	Deepak Mishra	47	Male	Varanasi	2023-05-30
26	Shreya Ghosh	28	Female	Kolkata	2023-06-02
27	Abhishek Yadav	33	Male	Lucknow	2023-07-05
28	Ritika Arora	36	Female	Delhi	2023-08-09
29	Gaurav Sharma	40	Male	Jaipur	2023-09-13
30	Naina Kapoor	31	Female	Mumbai	2023-10-18
31	Mohit Saini	45	Male	Delhi	2023-01-14
32	Alok Dubey	50	Male	Bhopal	2023-02-19
33	Rashmi Singh	38	Female	Patna	2023-03-23
34	Ankit Saxena	34	Male	Lucknow	2023-04-28
35	Pallavi Joshi	29	Female	Pune	2023-05-02
36	Suresh Pillai	53	Male	Chennai	2023-06-06
37	Geeta Devi	60	Female	Varanasi	2023-07-10
38	Ramesh Kumar	49	Male	Patna	2023-08-15
39	Sunita Yadav	41	Female	Lucknow	2023-09-20
40	Ajay Gupta	46	Male	Delhi	2023-10-25
\.


--
-- Data for Name: treatments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treatments (treatment_id, appointment_id, diagnosis, treatment_description, cost) FROM stdin;
1	1	Heart Disease	Medication and lifestyle changes	5000.00
2	2	Skin Allergy	Antihistamines prescribed	1500.00
3	4	Pregnancy Checkup	Routine checkup	2000.00
4	6	Child Fever	Paracetamol and rest	800.00
5	7	General Checkup	Basic consultation	700.00
6	8	Ear Infection	Antibiotics	1200.00
7	10	Cancer Screening	Initial screening tests	6000.00
8	11	Cardiac Issue	ECG and meds	5500.00
9	12	Skin Rash	Cream and meds	1300.00
10	14	Pregnancy Followup	Ultrasound	2500.00
11	15	Neurological Disorder	MRI scan	8000.00
12	17	General Fever	Basic treatment	600.00
13	18	ENT Infection	Medication	1100.00
14	20	Cancer Treatment	Chemotherapy session	15000.00
15	21	Heart Check	Routine ECG	3000.00
16	22	Skin Infection	Ointments	1400.00
17	23	Bone Fracture	Cast applied	7000.00
18	25	Neurological Issue	Medication	5000.00
19	26	Child Care	Vaccination	1200.00
20	27	General Illness	Basic meds	800.00
21	28	ENT Check	Cleaning and meds	1000.00
22	30	Cancer Followup	Checkup	7000.00
23	31	Cardiac Surgery	Minor procedure	20000.00
24	32	Skin Treatment	Laser therapy	5000.00
25	34	Pregnancy	Routine visit	2200.00
26	35	Brain Scan	CT Scan	9000.00
27	36	Child Illness	Medication	900.00
28	38	ENT Issue	Treatment	1300.00
29	39	Mental Health	Therapy session	2000.00
30	40	Cancer Therapy	Session	14000.00
\.


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 40, true);


--
-- Name: billing_bill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billing_bill_id_seq', 30, true);


--
-- Name: doctors_doctor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctors_doctor_id_seq', 20, true);


--
-- Name: patients_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patients_patient_id_seq', 40, true);


--
-- Name: treatments_treatment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treatments_treatment_id_seq', 30, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: billing billing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_pkey PRIMARY KEY (bill_id);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (doctor_id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- Name: treatments treatments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatments
    ADD CONSTRAINT treatments_pkey PRIMARY KEY (treatment_id);


--
-- Name: appointments appointments_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(doctor_id);


--
-- Name: appointments appointments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: billing billing_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- Name: treatments treatments_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatments
    ADD CONSTRAINT treatments_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- PostgreSQL database dump complete
--

