--
-- PostgreSQL database dump
--

\restrict aung1UuRK21TBpWHVn867OcHSsVpVNAqZYm3RSsXemzENrs4wYhKUi01KPR3bnB

-- Dumped from database version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)

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
-- Name: update_report_jobs_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_report_jobs_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_report_jobs_updated_at() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    tax_number character varying(50) NOT NULL,
    address text,
    contact character varying(255),
    logo_url character varying(500),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: customer_companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_companies (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(255) NOT NULL,
    tax_number character varying(50),
    address text,
    contact character varying(255),
    email character varying(255) NOT NULL,
    authorized_person character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_companies OWNER TO postgres;

--
-- Name: customer_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_companies_id_seq OWNER TO postgres;

--
-- Name: customer_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_companies_id_seq OWNED BY public.customer_companies.id;


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    template jsonb NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipment_id_seq OWNER TO postgres;

--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- Name: inspections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspections (
    id integer NOT NULL,
    work_order_id integer NOT NULL,
    equipment_id integer NOT NULL,
    technician_id integer NOT NULL,
    inspection_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    status character varying(50) DEFAULT 'not_started'::character varying,
    inspection_data jsonb DEFAULT '{}'::jsonb,
    photo_urls jsonb DEFAULT '[]'::jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    inspection_number character varying(50)
);


ALTER TABLE public.inspections OWNER TO postgres;

--
-- Name: inspections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inspections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inspections_id_seq OWNER TO postgres;

--
-- Name: inspections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inspections_id_seq OWNED BY public.inspections.id;


--
-- Name: offers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers (
    id integer NOT NULL,
    company_id integer NOT NULL,
    offer_number character varying(50) NOT NULL,
    customer_company_id integer NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    items jsonb NOT NULL,
    notes text,
    total_amount numeric(10,2),
    tracking_token character varying(255),
    created_by integer NOT NULL,
    approved_by integer,
    approved_at timestamp without time zone,
    sent_at timestamp without time zone,
    viewed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    customer_decision character varying(20),
    customer_decision_note text,
    customer_decision_at timestamp without time zone
);


ALTER TABLE public.offers OWNER TO postgres;

--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_id_seq OWNER TO postgres;

--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_id_seq OWNED BY public.offers.id;


--
-- Name: report_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_jobs (
    id integer NOT NULL,
    report_id integer NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    last_error text,
    priority integer DEFAULT 100 NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.report_jobs OWNER TO postgres;

--
-- Name: report_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.report_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_jobs_id_seq OWNER TO postgres;

--
-- Name: report_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.report_jobs_id_seq OWNED BY public.report_jobs.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    inspection_id integer NOT NULL,
    is_signed boolean DEFAULT false,
    signed_at timestamp without time zone,
    signed_by integer,
    qr_token character varying(255),
    sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    unsigned_pdf_path text,
    signed_pdf_path text,
    report_style jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: technicians; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.technicians (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(255) NOT NULL,
    surname character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(50),
    password_hash character varying(255) NOT NULL,
    e_signature_pin character varying(255),
    permissions jsonb DEFAULT '[]'::jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.technicians OWNER TO postgres;

--
-- Name: technicians_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.technicians_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technicians_id_seq OWNER TO postgres;

--
-- Name: technicians_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.technicians_id_seq OWNED BY public.technicians.id;


--
-- Name: work_order_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_order_assignments (
    id integer NOT NULL,
    work_order_id integer NOT NULL,
    technician_id integer NOT NULL,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.work_order_assignments OWNER TO postgres;

--
-- Name: work_order_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_order_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_order_assignments_id_seq OWNER TO postgres;

--
-- Name: work_order_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_order_assignments_id_seq OWNED BY public.work_order_assignments.id;


--
-- Name: work_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_orders (
    id integer NOT NULL,
    company_id integer NOT NULL,
    work_order_number character varying(50) NOT NULL,
    customer_company_id integer NOT NULL,
    offer_id integer,
    status character varying(50) DEFAULT 'not_started'::character varying,
    scheduled_date date,
    notes text,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.work_orders OWNER TO postgres;

--
-- Name: work_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_orders_id_seq OWNER TO postgres;

--
-- Name: work_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_orders_id_seq OWNED BY public.work_orders.id;


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: customer_companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_companies ALTER COLUMN id SET DEFAULT nextval('public.customer_companies_id_seq'::regclass);


--
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- Name: inspections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections ALTER COLUMN id SET DEFAULT nextval('public.inspections_id_seq'::regclass);


--
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers ALTER COLUMN id SET DEFAULT nextval('public.offers_id_seq'::regclass);


--
-- Name: report_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_jobs ALTER COLUMN id SET DEFAULT nextval('public.report_jobs_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: technicians id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technicians ALTER COLUMN id SET DEFAULT nextval('public.technicians_id_seq'::regclass);


--
-- Name: work_order_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_order_assignments ALTER COLUMN id SET DEFAULT nextval('public.work_order_assignments_id_seq'::regclass);


--
-- Name: work_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders ALTER COLUMN id SET DEFAULT nextval('public.work_orders_id_seq'::regclass);


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, tax_number, address, contact, logo_url, created_at, updated_at) FROM stdin;
1	ABC Mühendislik A.Ş.	1234567890	İstanbul Ticaret Merkezi No: 123	+90 212 555 0123	\N	2025-08-16 23:42:54.346668	2025-08-16 23:42:54.346668
\.


--
-- Data for Name: customer_companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_companies (id, company_id, name, tax_number, address, contact, email, authorized_person, created_at, updated_at) FROM stdin;
1	1	XYZ İnşaat Ltd.Şti.	9876543210	Ankara Sanayi Sitesi No: 456	+90 312 555 0456	info@xyz.com	Mehmet Demir	2025-08-16 23:42:54.349038	2025-08-16 23:42:54.349038
2	1	Test Musteri 1756850326	1234567890	\N	\N	test1756850326@ex.com	\N	2025-09-03 00:58:46.934492	2025-09-03 00:58:46.934492
3	1	Test Musteri 1756926284	91756926284	\N	\N	test1756926284@ex.com	\N	2025-09-03 22:04:44.878495	2025-09-03 22:04:44.878495
4	1	Test Musteri 1756927943	91756927943	\N	\N	test1756927943@ex.com	\N	2025-09-03 22:32:23.144774	2025-09-03 22:32:23.144774
5	1	Test Musteri 1756927961	91756927961	\N	\N	test1756927961@ex.com	\N	2025-09-03 22:32:41.531814	2025-09-03 22:32:41.531814
6	1	Test Musteri 1756929106	91756929106	\N	\N	test1756929106@ex.com	\N	2025-09-03 22:51:46.16312	2025-09-03 22:51:46.16312
7	1	Test Musteri 1756929380	91756929380	\N	\N	test1756929380@ex.com	\N	2025-09-03 22:56:20.854295	2025-09-03 22:56:20.854295
8	1	Test Musteri 1756933189	91756933189	\N	\N	test1756933189@ex.com	\N	2025-09-03 23:59:49.577085	2025-09-03 23:59:49.577085
9	1	Test Musteri 1756937527	91756937527	\N	\N	test1756937527@ex.com	\N	2025-09-04 01:12:07.518266	2025-09-04 01:12:07.518266
10	1	Test Musteri 1756937716	91756937716	\N	\N	test1756937716@ex.com	\N	2025-09-04 01:15:16.44328	2025-09-04 01:15:16.44328
11	1	Test Musteri 1756937951	91756937951	\N	\N	test1756937951@ex.com	\N	2025-09-04 01:19:11.161003	2025-09-04 01:19:11.161003
12	1	Test Musteri 1756937976	91756937976	\N	\N	test1756937976@ex.com	\N	2025-09-04 01:19:36.667654	2025-09-04 01:19:36.667654
13	1	Test Musteri 1756937992	91756937992	\N	\N	test1756937992@ex.com	\N	2025-09-04 01:19:52.130062	2025-09-04 01:19:52.130062
14	1	Test Musteri 1757103832	91757103832	\N	\N	test1757103832@ex.com	\N	2025-09-05 23:23:52.598217	2025-09-05 23:23:52.598217
15	1	Test Musteri 1757104826	91757104826	\N	\N	test1757104826@ex.com	\N	2025-09-05 23:40:26.668803	2025-09-05 23:40:26.668803
16	1	Test Musteri 1757105272	91757105272	\N	\N	test1757105272@ex.com	\N	2025-09-05 23:47:52.362194	2025-09-05 23:47:52.362194
17	1	Test Musteri 1757105513	91757105513	\N	\N	test1757105513@ex.com	\N	2025-09-05 23:51:53.966814	2025-09-05 23:51:53.966814
18	1	Test Musteri 1757186517	91757186517	dsds	dsdsds	test1757186517@ex.com	dsds	2025-09-06 22:21:57.173082	2025-09-10 00:30:25.265795
19	1	BAŞKENT	6341079669	ADRS YOK	05389552692	eposta@yok.com	YETKĞLİ YOK	2025-09-15 19:07:00.895614	2025-09-15 19:07:00.895614
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (id, company_id, name, type, template, is_active, created_at, updated_at) FROM stdin;
2	1	Basınçlı Hava Tankı	tank	{"sections": [{"title": "Genel Bilgiler", "fields": [{"name": "muayene_tarihi", "type": "date", "label": "Muayene Tarihi", "required": true}, {"name": "muayene_yeri", "type": "text", "label": "Muayene Yeri", "required": true}, {"name": "imalat_yili", "type": "number", "label": "İmalat Yılı", "required": true}]}, {"title": "Teknik Özellikler", "fields": [{"name": "hacim", "type": "number", "label": "Hacim (L)", "required": true}, {"name": "max_basinc", "type": "number", "label": "Maksimum Basınç (bar)", "required": true}, {"name": "malzeme", "type": "text", "label": "Malzeme", "required": true}]}, {"title": "Test Sonuçları", "fields": [{"name": "hidrolik_test", "type": "table", "label": "Hidrolik Test Sonuçları", "columns": [{"name": "test_basinci", "type": "number", "label": "Test Basıncı (bar)"}, {"name": "sonuc", "type": "select", "label": "Sonuç", "options": ["Başarılı", "Başarısız"]}], "required": true}]}]}	t	2025-08-16 23:42:54.349038	2025-08-16 23:42:54.349038
1	1	Kule Vinç	vinc	{"sections": [{"title": "Test", "fields": [{"name": "test", "type": "text", "label": "Test", "required": true}]}]}	t	2025-08-16 23:42:54.349038	2025-08-16 23:54:28.1583
3	1	mobil vinç	vinç	{"sections": [{"title": "Genel Bilgiler", "fields": [{"name": "muayene_tarihi", "type": "date", "label": "Muayene Tarihi", "required": true}, {"name": "muayene_yeri", "type": "text", "label": "Muayene Yeri", "required": true}, {"name": "seri_no", "type": "text", "label": "Seri Numarası", "required": false}]}]}	t	2025-08-19 19:34:20.644427	2025-08-19 19:34:20.644427
4	1	dsad	dsadasdsa	{"sections": [{"title": "Genel Bilgiler", "fields": [{"name": "muayene_tarihi", "type": "date", "label": "Muayene Tarihi", "required": true}, {"name": "muayene_yeri", "type": "text", "label": "Muayene Yeri", "required": true}, {"name": "seri_no", "type": "text", "label": "Seri Numarası", "required": false}]}]}	t	2025-08-19 19:34:50.460086	2025-08-19 19:34:50.460086
5	1	Kule Vinc 1756849577	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 00:46:17.036309	2025-09-03 00:46:17.036309
6	1	Kule Vinc 1756849835	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 00:50:35.84836	2025-09-03 00:50:35.84836
7	1	Kule Vinc 1756849891	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 00:51:31.958642	2025-09-03 00:51:31.958642
8	1	Kule Vinc 1756850326	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 00:58:46.948867	2025-09-03 00:58:46.948867
9	1	Kule Vinc 1756922000	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 20:53:20.897053	2025-09-03 20:53:20.897053
10	1	Kule Vinc 1756924103	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 21:28:23.776497	2025-09-03 21:28:23.776497
11	1	Kule Vinc 1756924179	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 21:29:39.631407	2025-09-03 21:29:39.631407
12	1	Kule Vinc 1756924212	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 21:30:12.799287	2025-09-03 21:30:12.799287
13	1	Kule Vinc 1756926284	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 22:04:44.8942	2025-09-03 22:04:44.8942
14	1	Kule Vinc 1756927943	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 22:32:23.152949	2025-09-03 22:32:23.152949
15	1	Kule Vinc 1756927961	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 22:32:41.545895	2025-09-03 22:32:41.545895
16	1	Kule Vinc 1756929106	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 22:51:46.183514	2025-09-03 22:51:46.183514
17	1	Kule Vinc 1756929380	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-03 22:56:20.873567	2025-09-03 22:56:20.873567
19	1	Kule Vinc 1756937527	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-04 01:12:07.534603	2025-09-04 01:12:07.534603
20	1	Kule Vinc 1756937716	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-04 01:15:16.460403	2025-09-04 01:15:16.460403
21	1	Kule Vinc 1756937951	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-04 01:19:11.170547	2025-09-04 01:19:11.170547
22	1	Kule Vinc 1756937976	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-04 01:19:36.682092	2025-09-04 01:19:36.682092
23	1	Kule Vinc 1756937992	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-04 01:19:52.136489	2025-09-04 01:19:52.136489
24	1	Kule Vinc 1757103832	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-05 23:23:52.612539	2025-09-05 23:23:52.612539
25	1	Kule Vinc 1757104826	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-05 23:40:26.692245	2025-09-05 23:40:26.692245
26	1	Kule Vinc 1757105272	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-05 23:47:52.383871	2025-09-05 23:47:52.383871
27	1	Kule Vinc 1757105513	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-05 23:51:53.98719	2025-09-05 23:51:53.98719
28	1	Kule Vinc 1757186517	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	t	2025-09-06 22:21:57.182475	2025-09-06 22:21:57.182475
18	1	Kule Vinc 1756933189	vinc	{"sections": [{"id": "genel", "type": "key_value", "items": [{"name": "muayene_tarihi", "label": "Tarih", "required": true, "valueType": "date"}, {"name": "muayene_yeri", "label": "Yer", "required": true, "valueType": "text"}], "title": "Genel"}, {"id": "guvenlik", "type": "checklist", "title": "Güvenlik", "questions": [{"name": "emniyet_sistemi", "label": "Emniyet", "options": ["Uygun", "Uygun Değil"], "required": true, "passValues": ["Uygun"]}]}, {"id": "fotolar", "type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 6}]}	f	2025-09-03 23:59:49.598022	2025-09-10 00:29:17.781856
30	1	MOBİL VİNÇ	Kaldırma iletme	{"sections": [{"type": "table", "field": "firma_adi", "title": "FİRMA BİLGİLERİ", "columns": [{"name": "a", "type": "text", "label": "A1"}, {"name": "b", "type": "text", "label": "B1"}]}], "settings": {"reportStyle": {"scale": "small"}}}	t	2025-09-20 17:43:23.991591	2025-09-20 17:43:23.991591
29	1	Örnek Ekipman — Kule Vinç	Kule Vinç	{"sections": [{"type": "key_value", "items": [{"name": "imalatci", "label": "İmalatçı", "valueType": "text"}, {"name": "model", "label": "Model", "valueType": "text"}, {"name": "seri_no", "label": "Seri No", "valueType": "text"}, {"name": "uretim_tarihi", "label": "Üretim Tarihi", "valueType": "date"}, {"name": "calisma_ortami", "label": "Çalışma Ortamı", "options": [{"label": "İç Mekan", "value": "ic"}, {"label": "Dış Mekan", "value": "dis"}], "valueType": "select"}, {"name": "azami_kapasite_ton", "label": "Azami Kapasite (ton)", "valueType": "number"}], "title": "Genel Bilgiler"}, {"type": "checklist", "title": "Güvenlik Kontrolleri", "questions": [{"name": "emniyet_switch", "label": "Emniyet Switch", "options": ["Uygun", "Uygun Değil", "N/A"]}, {"name": "limit_switch", "label": "Limit Switch", "options": ["Uygun", "Uygun Değil", "N/A"]}, {"name": "halat_durumu", "label": "Halat Durumu", "options": ["Uygun", "Uygun Değil", "N/A"]}, {"name": "kanca_durumu", "label": "Kanca Durumu", "options": ["Uygun", "Uygun Değil", "N/A"]}]}, {"type": "key_value", "items": [{"name": "maksimum_yukseklik_m", "label": "Maksimum Yükseklik (m)", "valueType": "number"}, {"name": "bom_uzunlugu_m", "label": "Bom Uzunluğu (m)", "valueType": "number"}, {"name": "kullanim_amaci", "label": "Kullanım Amacı", "valueType": "text"}, {"name": "son_bakim_tarihi", "label": "Son Bakım Tarihi", "valueType": "date"}], "title": "Teknik Değerler"}, {"type": "table", "field": "bakim_kayitlari", "title": "Bakım / Servis Kayıtları", "columns": [{"name": "tarih", "label": "Tarih"}, {"name": "islem", "label": "İşlem"}, {"name": "teknisyen", "label": "Teknisyen"}, {"name": "not", "label": "Not"}]}, {"type": "photos", "field": "genel_gorunum", "title": "Fotoğraflar", "display": "grid", "maxCount": 12}, {"type": "notes", "field": "ek_notlar", "title": "Ek Notlar"}], "settings": {"reportStyle": {"scale": "small"}}}	t	2025-09-11 17:23:52.376749	2025-09-20 12:23:13.249617
\.


--
-- Data for Name: inspections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inspections (id, work_order_id, equipment_id, technician_id, inspection_date, start_time, end_time, status, inspection_data, photo_urls, created_at, updated_at, inspection_number) FROM stdin;
14	14	24	2	2025-11-27	09:00:00	17:00:00	completed	{"test": "ok", "photos": ["/uploads/inspections/14/inspection_1757534095497_wj4x2l.jpg", "/uploads/inspections/14/inspection_1757535341679_g1gx9i.jpeg"], "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-05", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/14/inspection_1757103832718_zcx0br.png", "/uploads/inspections/14/inspection_1757534095497_wj4x2l.jpg", "/uploads/inspections/14/inspection_1757535341679_g1gx9i.jpeg"]	2025-09-05 23:23:52.678639	2025-09-10 23:15:41.685003	INSP-000000014
7	7	17	2	2025-10-24	09:00:00	17:00:00	completed	{"test": "ok", "photos": ["/uploads/inspections/7/inspection_1757534796476_cmyef5.jpg", "/uploads/inspections/7/inspection_1757535751334_xnwx2a.jpg"], "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-03", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/7/inspection_1756929380952_ow1cxy.png", "/uploads/inspections/7/inspection_1757534796476_cmyef5.jpg", "/uploads/inspections/7/inspection_1757535751334_xnwx2a.jpg"]	2025-09-03 22:56:20.928039	2025-09-10 23:22:31.338693	INSP-000000007
2	2	1	2	2025-08-25	09:00:00	17:00:00	in_progress	{"muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-03", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/2/inspection_1756849577149_e207d0.png", "/uploads/inspections/2/inspection_1756849835943_6phvmi.png", "/uploads/inspections/2/inspection_1756849892048_wt2dbr.png", "/uploads/inspections/2/inspection_1756850327047_c0fdz1.png", "/uploads/inspections/2/inspection_1756922000963_52rte9.png", "/uploads/inspections/2/inspection_1756924103841_knguox.png", "/uploads/inspections/2/inspection_1756924179688_6alvax.png", "/uploads/inspections/2/inspection_1756924212862_gljba1.png"]	2025-08-16 23:56:09.166997	2025-09-10 21:09:30.585069	INSP-000000002
8	8	18	2	2025-11-22	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-03", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/8/inspection_1756933189685_kxjowk.png"]	2025-09-03 23:59:49.655228	2025-09-10 21:09:30.585069	INSP-000000008
9	9	19	2	2025-09-11	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-04", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/9/inspection_1756937527595_5ap6a2.png"]	2025-09-04 01:12:07.577137	2025-09-10 21:09:30.585069	INSP-000000009
19	19	28	2	2025-08-09	09:00:00	17:00:00	not_started	{}	[]	2025-09-10 19:11:41.19331	2025-09-10 21:09:30.585069	INSP-000000019
10	10	20	2	2025-09-20	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-04", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/10/inspection_1756937716532_71l3e7.png"]	2025-09-04 01:15:16.50853	2025-09-10 21:09:30.585069	INSP-000000010
11	11	21	2	2025-11-14	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-04", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/11/inspection_1756937951238_qs6vif.png"]	2025-09-04 01:19:11.218108	2025-09-10 21:09:30.585069	INSP-000000011
12	12	22	2	2025-09-10	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-04", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/12/inspection_1756937976734_k67lp4.png"]	2025-09-04 01:19:36.718609	2025-09-10 21:09:30.585069	INSP-000000012
13	13	23	2	2025-09-26	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-04", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/13/inspection_1756937992190_21mhdm.png"]	2025-09-04 01:19:52.175795	2025-09-10 21:09:30.585069	INSP-000000013
17	17	27	2	2025-10-30	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-05", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/17/inspection_1757105514083_dqit66.png"]	2025-09-05 23:51:54.049876	2025-09-10 21:09:30.585069	INSP-000000017
3	3	13	2	2025-09-03	09:00:00	17:00:00	completed	{"test": "ok", "muayene_yeri": "Saha A", "genel_gorunum": ["/uploads/inspections/3/inspection_1757967556155_b65244.jpg"], "muayene_tarihi": "2025-09-03", "emniyet_sistemi": "Uygun Değil"}	["/uploads/inspections/3/inspection_1757967556155_b65244.jpg"]	2025-09-03 22:04:44.936477	2025-09-15 20:19:22.607313	INSP-000000003
18	18	28	2	2025-11-03	09:00:00	17:00:00	completed	{"test": "ok", "photos": [], "muayene_yeri": "Saha A", "muayene_tarihi": "2025-09-06", "emniyet_sistemi": "Uygun"}	[]	2025-09-06 22:21:57.226292	2025-09-15 19:13:29.021517	INSP-000000018
20	20	29	3	2024-01-27	09:00:00	17:00:00	not_started	{"model": "dsadad", "photos": ["/uploads/inspections/20/inspection_1757601107078_q67am1.jpg"], "seri_no": "sadsad", "imalatci": "dsa", "ek_notlar": "dsadsa", "halat_durumu": "Uygun", "kanca_durumu": "Uygun", "limit_switch": "Uygun", "genel_gorunum": ["/uploads/inspections/20/inspection_1757796616880_zbhb42.jpeg"], "uretim_tarihi": "2025-05-05", "bom_uzunlugu_m": 55, "calisma_ortami": "ic", "emniyet_switch": "Uygun", "kullanim_amaci": "dsa", "bakim_kayitlari": [{"not": "33", "islem": "33", "tarih": "33", "teknisyen": "33"}], "son_bakim_tarihi": "2025-05-05", "azami_kapasite_ton": 55, "maksimum_yukseklik_m": 55}	["/uploads/inspections/20/inspection_1757796616880_zbhb42.jpeg"]	2025-09-11 17:25:00.871964	2025-09-15 19:22:02.434622	INSP-700884432
23	22	29	1	2025-09-19	09:00:00	17:00:00	not_started	{"model": "sadsad", "seri_no": "sadsa", "imalatci": "dsad", "ek_notlar": "dsadsa", "halat_durumu": "Uygun", "kanca_durumu": "Uygun", "limit_switch": "Uygun", "uretim_tarihi": "2025-12-31", "bom_uzunlugu_m": 55, "calisma_ortami": "ic", "emniyet_switch": "Uygun", "kullanim_amaci": "55", "bakim_kayitlari": [{"not": "55", "islem": "55", "tarih": "55", "teknisyen": "55"}], "son_bakim_tarihi": "2025-05-05", "maksimum_yukseklik_m": 55}	[]	2025-09-19 18:20:43.353761	2025-09-19 18:21:38.284856	INSP-043357254
24	23	29	4	2025-05-05	09:00:00	17:00:00	not_started	{"model": "sadasdsa", "seri_no": "dsada", "imalatci": "dsad", "ek_notlar": "dsadsadsa", "halat_durumu": "Uygun", "kanca_durumu": "Uygun", "limit_switch": "Uygun", "uretim_tarihi": "2025-05-05", "bom_uzunlugu_m": 55, "calisma_ortami": "ic", "emniyet_switch": "Uygun", "kullanim_amaci": "55", "bakim_kayitlari": [{"not": "55", "islem": "55", "tarih": "55", "teknisyen": "55"}], "son_bakim_tarihi": "2025-05-05", "azami_kapasite_ton": 55, "maksimum_yukseklik_m": 55}	[]	2025-09-20 12:24:07.692088	2025-09-20 12:24:56.213432	INSP-047703306
15	15	25	2	2025-11-30	09:00:00	17:00:00	completed	{"test": "ok", "photos": ["/uploads/inspections/15/inspection_1757533811851_cdbfqq.jpg", "/uploads/inspections/15/inspection_1757533825919_91lc3b.png", "/uploads/inspections/15/inspection_1757535524368_9jzk3j.jpg"], "muayene_yeri": "SAHA", "muayene_tarihi": "2025-09-05", "emniyet_sistemi": "Uygun"}	["/uploads/inspections/15/inspection_1757533811851_cdbfqq.jpg", "/uploads/inspections/15/inspection_1757535524368_9jzk3j.jpg"]	2025-09-05 23:40:26.75272	2025-09-20 18:24:56.063457	INSP-000000015
1	1	1	3	2025-08-20	09:00:00	12:00:00	completed	{"test": "UYGUN"}	[]	2025-08-16 23:52:08.388929	2025-09-20 17:58:50.593971	INSP-000000001
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers (id, company_id, offer_number, customer_company_id, status, items, notes, total_amount, tracking_token, created_by, approved_by, approved_at, sent_at, viewed_at, created_at, updated_at, customer_decision, customer_decision_note, customer_decision_at) FROM stdin;
1	1	OFFER-677443251	1	approved	[{"quantity": 1, "unitPrice": 500, "description": "Test muayene", "equipmentId": 1, "equipmentName": "Kule Vinç"}]	Test teklifi	500.00	fc3f59695bf68443b4aa5c07a87e10ab25af79d95116c2e659765649f5e40499	2	2	2025-08-16 23:55:49.563566	\N	\N	2025-08-16 23:54:37.444465	2025-08-16 23:55:49.563566	\N	\N	\N
2	1	OFFER-326961373	2	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 8, "equipmentName": "Kule Vinc 1756850326"}]	Otomatik test teklifi	1000.00	41cd41c6b79e81cc21ac9e7b71c90a6d6ccb957cc5de90a4bc20438adef5d993	2	2	2025-09-03 00:58:46.974984	2025-09-03 00:58:46.985913	\N	2025-09-03 00:58:46.962237	2025-09-03 00:58:46.985913	\N	\N	\N
3	1	OFFER-284902364	3	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 13, "equipmentName": "Kule Vinc 1756926284"}]	Otomatik test teklifi	1000.00	13500c5a291e1dcb9abd704b886e8f44e7a6dfd3044c4dbd65de9df86385fa0b	2	2	2025-09-03 22:04:44.914621	2025-09-03 22:04:44.921638	2025-09-03 22:04:44.930373	2025-09-03 22:04:44.90283	2025-09-03 22:04:44.930373	accepted	OK	2025-09-03 22:04:44.930373
4	1	OFFER-943161429	4	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 14, "equipmentName": "Kule Vinc 1756927943"}]	Otomatik test teklifi	1000.00	00c927d3cacefa1dd3033f85c61bd752a6b39940f0016f8c2cb52bbe454a9739	2	2	2025-09-03 22:32:23.175076	2025-09-03 22:32:23.181167	2025-09-03 22:32:23.189314	2025-09-03 22:32:23.162724	2025-09-03 22:32:23.189314	accepted	OK	2025-09-03 22:32:23.189314
5	1	OFFER-961551007	5	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 15, "equipmentName": "Kule Vinc 1756927961"}]	Otomatik test teklifi	1000.00	fd11d8384264abf57737a930284577c36211d3900d7a75d9fe7a2452e3605395	2	2	2025-09-03 22:32:41.558175	2025-09-03 22:32:41.563647	2025-09-03 22:32:41.570591	2025-09-03 22:32:41.551808	2025-09-03 22:32:41.570591	accepted	OK	2025-09-03 22:32:41.570591
6	1	OFFER-106196438	6	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 16, "equipmentName": "Kule Vinc 1756929106"}]	Otomatik test teklifi	1000.00	02e76c057ce7d42e178062a82270538f87c498037840afa3027e4fb627b7281b	2	2	2025-09-03 22:51:46.207422	2025-09-03 22:51:46.218517	2025-09-03 22:51:46.233096	2025-09-03 22:51:46.196921	2025-09-03 22:51:46.233096	accepted	OK	2025-09-03 22:51:46.233096
7	1	OFFER-380884363	7	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 17, "equipmentName": "Kule Vinc 1756929380"}]	Otomatik test teklifi	1000.00	ed0d04d60355f2534ad25fbd527138b018d95fba34a665c6069fe99cfa08b85a	2	2	2025-09-03 22:56:20.894589	2025-09-03 22:56:20.905488	2025-09-03 22:56:20.918409	2025-09-03 22:56:20.884994	2025-09-03 22:56:20.918409	accepted	OK	2025-09-03 22:56:20.918409
8	1	OFFER-189610651	8	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 18, "equipmentName": "Kule Vinc 1756933189"}]	Otomatik test teklifi	1000.00	5b2bf66c4cbe6035ebf188995b66a6bd6dd64070d52b484f132cbfe581e18455	2	2	2025-09-03 23:59:49.621006	2025-09-03 23:59:49.631526	2025-09-03 23:59:49.644967	2025-09-03 23:59:49.61144	2025-09-03 23:59:49.644967	accepted	OK	2025-09-03 23:59:49.644967
9	1	OFFER-527546992	9	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 19, "equipmentName": "Kule Vinc 1756937527"}]	Otomatik test teklifi	1000.00	4304b08c12af6ad91cad8bacaa8266c1171170989e7a35ba6ce9cf73767c6365	2	2	2025-09-04 01:12:07.554	2025-09-04 01:12:07.561083	2025-09-04 01:12:07.569645	2025-09-04 01:12:07.546841	2025-09-04 01:12:07.569645	accepted	OK	2025-09-04 01:12:07.569645
10	1	OFFER-716470441	10	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 20, "equipmentName": "Kule Vinc 1756937716"}]	Otomatik test teklifi	1000.00	b77468ce64125bb1b47f755d8db9522abf33be13c0ae5b292c2b43b6162eafdd	2	2	2025-09-04 01:15:16.479842	2025-09-04 01:15:16.48889	2025-09-04 01:15:16.500129	2025-09-04 01:15:16.471122	2025-09-04 01:15:16.500129	accepted	OK	2025-09-04 01:15:16.500129
12	1	OFFER-976689850	12	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 22, "equipmentName": "Kule Vinc 1756937976"}]	Otomatik test teklifi	1000.00	4d879df169b83a845151d81c3306c8cab7b2f31807aa955c2ac50fda336ef73c	2	2	2025-09-04 01:19:36.695508	2025-09-04 01:19:36.701636	2025-09-04 01:19:36.711179	2025-09-04 01:19:36.689412	2025-09-04 01:19:36.711179	accepted	OK	2025-09-04 01:19:36.711179
13	1	OFFER-992144441	13	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 23, "equipmentName": "Kule Vinc 1756937992"}]	Otomatik test teklifi	1000.00	bcde9bed552beeba4c191c4f15d8f1951ad35a0492483c1d9d4874c411052978	2	2	2025-09-04 01:19:52.15091	2025-09-04 01:19:52.158149	2025-09-04 01:19:52.167385	2025-09-04 01:19:52.144452	2025-09-04 01:19:52.167385	accepted	OK	2025-09-04 01:19:52.167385
15	1	OFFER-826704836	15	approved	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 25, "equipmentName": "Kule Vinc 1757104826"}]	Otomatik test teklifi	1000.00	23c8a9f758f7cb02b30abd9572d16c66b568bf22334461ce4fe0d15e60999a05	2	2	2025-09-05 23:40:26.716737	2025-09-05 23:40:26.727393	2025-09-05 23:40:26.740813	2025-09-05 23:40:26.705398	2025-09-05 23:40:26.740813	accepted	OK	2025-09-05 23:40:26.740813
17	1	OFFER-514000550	17	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 27, "equipmentName": "Kule Vinc 1757105513"}]	Otomatik test teklifi	1000.00	e11d77824088467c1a9eca8123a8885ebf3691eff53692e70fb5582d6f7473a3	2	2	2025-09-05 23:51:54.011757	2025-09-10 19:47:20.529521	2025-09-05 23:51:54.038828	2025-09-05 23:51:54.000937	2025-09-10 19:47:20.529521	accepted	OK	2025-09-05 23:51:54.038828
18	1	OFFER-517189111	18	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 28, "equipmentName": "Kule Vinc 1757186517"}]	Otomatik test teklifi	1000.00	2c0e0196b9f5fee7560b3546ec68446c1ebcec2d1a54d30fa38d9253f46b5709	2	2	2025-09-06 22:21:57.197837	2025-09-10 20:31:13.059873	2025-09-06 22:21:57.219777	2025-09-06 22:21:57.190336	2025-09-10 20:31:13.059873	accepted	OK	2025-09-06 22:21:57.219777
16	1	OFFER-272396529	16	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 26, "equipmentName": "Kule Vinc 1757105272"}]	Otomatik test teklifi	1000.00	85a56b0cd50b2cdda4bfadf4079abe2c6ee27dde1e58b5665edeec0f8050264e	2	2	2025-09-05 23:47:52.408142	2025-09-13 23:48:12.974287	2025-09-05 23:47:52.435041	2025-09-05 23:47:52.397284	2025-09-13 23:48:12.974287	accepted	OK	2025-09-05 23:47:52.435041
14	1	OFFER-832625702	14	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 24, "equipmentName": "Kule Vinc 1757103832"}]	Otomatik test teklifi	1000.00	8a49ed86b8d425b766708df3f35566484a762276edb3e12a1ee2dbd0ea8cfedf	2	2	2025-09-05 23:23:52.638987	2025-09-15 19:13:47.365582	2025-09-05 23:23:52.667744	2025-09-05 23:23:52.626008	2025-09-15 19:13:47.365582	accepted	OK	2025-09-05 23:23:52.667744
11	1	OFFER-951180115	11	sent	[{"quantity": 1, "unitPrice": 1000, "equipmentId": 21, "equipmentName": "Kule Vinc 1756937951"}]	Otomatik test teklifi	1000.00	b24042c66e6e33829c1638348e4630c6f34266bde88b4edc4d492f1e770e0a8b	2	2	2025-09-04 01:19:11.190165	2025-09-15 20:21:40.307373	2025-09-04 01:19:11.209987	2025-09-04 01:19:11.181234	2025-09-15 20:21:40.307373	accepted	OK	2025-09-04 01:19:11.209987
\.


--
-- Data for Name: report_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_jobs (id, report_id, status, attempts, last_error, priority, started_at, finished_at, created_at, updated_at) FROM stdin;
1	1	completed	1	\N	100	2025-09-03 21:28:24.969657	2025-09-03 21:28:26.218734	2025-09-03 21:28:23.884676	2025-09-03 21:28:26.218734
2	1	completed	1	\N	100	2025-09-03 21:29:40.507538	2025-09-03 21:29:41.740399	2025-09-03 21:29:39.726184	2025-09-03 21:29:41.740399
3	1	completed	1	\N	100	2025-09-03 21:30:13.902669	2025-09-03 21:30:15.150649	2025-09-03 21:30:12.909401	2025-09-03 21:30:15.150649
4	2	completed	1	\N	100	2025-09-03 22:04:46.621388	2025-09-03 22:04:47.893695	2025-09-03 22:04:45.919738	2025-09-03 22:04:47.893695
5	2	completed	1	\N	100	2025-09-03 22:32:25.374811	2025-09-03 22:32:26.611725	2025-09-03 22:32:24.491555	2025-09-03 22:32:26.611725
6	2	completed	1	\N	100	2025-09-03 22:32:44.69497	2025-09-03 22:32:45.922847	2025-09-03 22:32:42.691648	2025-09-03 22:32:45.922847
7	2	completed	1	\N	100	2025-09-03 22:51:47.795827	2025-09-03 22:51:49.358435	2025-09-03 22:51:47.785828	2025-09-03 22:51:49.358435
8	3	completed	1	\N	100	2025-09-03 22:56:22.567553	2025-09-03 22:56:23.971478	2025-09-03 22:56:22.416014	2025-09-03 22:56:23.971478
9	4	completed	1	\N	100	2025-09-03 23:59:51.749439	2025-09-03 23:59:53.306714	2025-09-03 23:59:51.179748	2025-09-03 23:59:53.306714
10	5	completed	1	\N	100	2025-09-04 01:12:09.576737	2025-09-04 01:12:10.68755	2025-09-04 01:12:08.888206	2025-09-04 01:12:10.68755
11	6	completed	1	\N	100	2025-09-04 01:15:19.556599	2025-09-04 01:15:20.617701	2025-09-04 01:15:17.861705	2025-09-04 01:15:20.617701
12	7	completed	1	\N	100	2025-09-04 01:19:13.078358	2025-09-04 01:19:14.403782	2025-09-04 01:19:12.554885	2025-09-04 01:19:14.403782
13	8	completed	1	\N	100	2025-09-04 01:19:38.435064	2025-09-04 01:19:39.469775	2025-09-04 01:19:38.039782	2025-09-04 01:19:39.469775
14	9	completed	1	\N	100	2025-09-04 01:19:53.523632	2025-09-04 01:19:54.492356	2025-09-04 01:19:53.490034	2025-09-04 01:19:54.492356
15	10	completed	1	\N	100	2025-09-05 23:23:54.914037	2025-09-05 23:23:56.281021	2025-09-05 23:23:54.414916	2025-09-05 23:23:56.281021
16	11	completed	1	\N	100	2025-09-05 23:40:29.392714	2025-09-05 23:40:30.790255	2025-09-05 23:40:28.286168	2025-09-05 23:40:30.790255
17	11	completed	1	\N	100	2025-09-05 23:47:54.754789	2025-09-05 23:47:55.947655	2025-09-05 23:47:53.924068	2025-09-05 23:47:55.947655
18	12	completed	1	\N	100	2025-09-05 23:51:57.384903	2025-09-05 23:51:58.778445	2025-09-05 23:51:55.534109	2025-09-05 23:51:58.778445
19	13	completed	1	\N	100	2025-09-06 22:21:59.987572	2025-09-06 22:22:01.217462	2025-09-06 22:21:58.589546	2025-09-06 22:22:01.217462
20	11	completed	1	\N	100	2025-09-10 22:44:19.244542	2025-09-10 22:44:20.279514	2025-09-10 22:44:17.819079	2025-09-10 22:44:20.279514
21	11	failed	1	Failed to launch the browser process! undefined\n[135088:135088:0915/190948.425112:ERROR:zygote_host_impl_linux.cc(101)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.\n\n\nTROUBLESHOOTING: https://pptr.dev/troubleshooting\n	100	2025-09-15 19:09:48.250548	2025-09-15 19:09:48.444295	2025-09-15 19:09:47.920231	2025-09-15 19:09:48.444295
22	10	failed	1	Failed to launch the browser process! undefined\n[135426:135426:0915/192042.663150:ERROR:zygote_host_impl_linux.cc(101)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.\n\n\nTROUBLESHOOTING: https://pptr.dev/troubleshooting\n	100	2025-09-15 19:20:42.498341	2025-09-15 19:20:42.684534	2025-09-15 19:20:42.463957	2025-09-15 19:20:42.684534
23	4	failed	1	Failed to launch the browser process! undefined\n[136899:136899:0915/202041.718129:ERROR:zygote_host_impl_linux.cc(101)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.\n\n\nTROUBLESHOOTING: https://pptr.dev/troubleshooting\n	100	2025-09-15 20:20:41.573564	2025-09-15 20:20:41.740218	2025-09-15 20:20:40.920615	2025-09-15 20:20:41.740218
24	14	completed	1	\N	100	2025-09-19 18:47:32.177046	2025-09-19 18:47:35.848314	2025-09-19 18:47:31.28583	2025-09-19 18:47:35.848314
25	14	completed	1	\N	100	2025-09-19 19:42:02.389789	2025-09-19 19:42:04.642333	2025-09-19 19:42:01.493071	2025-09-19 19:42:04.642333
26	17	processing	1	\N	100	2025-09-20 12:39:03.879408	\N	2025-09-20 12:39:03.044163	2025-09-20 12:39:03.879408
27	11	completed	1	\N	100	2025-09-20 13:41:37.475546	2025-09-20 13:41:40.533296	2025-09-20 13:41:37.015616	2025-09-20 13:41:40.533296
28	16	processing	1	\N	100	2025-09-21 13:04:29.591465	\N	2025-09-21 13:04:28.936842	2025-09-21 13:04:29.591465
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, inspection_id, is_signed, signed_at, signed_by, qr_token, sent_at, created_at, updated_at, unsigned_pdf_path, signed_pdf_path, report_style) FROM stdin;
7	11	t	2025-09-04 01:19:14.763457	3	9ac6e3741ea20a6529ef00356a65dfee	\N	2025-09-04 01:19:11.258589	2025-09-04 01:19:14.763457	/home/damn/Desktop/muayene/backend/uploads/reports/7/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/7/signed.pdf	{}
1	2	f	\N	\N	da129ea59eff0f1b13431b039f6c2422	\N	2025-08-16 23:57:11.097915	2025-09-03 21:30:15.137036	\N	\N	{}
8	12	t	2025-09-04 01:19:39.7371	3	83b8c0c33bb7939d7025909d6237a3b7	\N	2025-09-04 01:19:36.749111	2025-09-04 01:19:39.7371	/home/damn/Desktop/muayene/backend/uploads/reports/8/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/8/signed.pdf	{}
9	13	t	2025-09-04 01:19:54.667764	3	16d605e1f136ebfc0d2bef9bf780f490	\N	2025-09-04 01:19:52.205031	2025-09-04 01:19:54.667764	/home/damn/Desktop/muayene/backend/uploads/reports/9/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/9/signed.pdf	{}
6	10	f	\N	\N	69b05f0a6d8f5faa551b14518555df19	\N	2025-09-04 01:15:16.557032	2025-09-11 17:34:10.251215	\N	\N	{}
3	7	t	2025-09-03 22:56:24.476305	3	4722f3185ec1417895c19fc9ffa397dd	\N	2025-09-03 22:56:20.97403	2025-09-03 22:56:24.476305	/home/damn/Desktop/muayene/backend/uploads/reports/3/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/3/signed.pdf	{}
4	8	t	2025-09-03 23:59:53.782807	3	117df8a14f173a76bedf20ca2209ea79	\N	2025-09-03 23:59:49.713425	2025-09-11 21:45:32.445745	/home/damn/Desktop/muayene/backend/uploads/reports/4/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/4/signed.pdf	{}
5	9	t	2025-09-04 01:12:11.080764	3	2307d03e391e9828407bca243440af92	\N	2025-09-04 01:12:07.613269	2025-09-04 01:12:11.080764	/home/damn/Desktop/muayene/backend/uploads/reports/5/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/5/signed.pdf	{}
12	17	t	2025-09-05 23:51:59.150129	3	0c5b86820cd3eadc284c5c7a4d85e7f4	\N	2025-09-05 23:51:54.111076	2025-09-05 23:51:59.150129	/home/damn/Desktop/muayene/backend/uploads/reports/12/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/12/signed.pdf	{}
2	3	f	\N	\N	14229f2f650a814a593ddff30105d23f	\N	2025-09-03 22:04:44.971476	2025-09-15 20:18:57.071579	\N	\N	{}
10	14	t	2025-09-05 23:23:56.815964	3	12c16ae48ae6e6f8fff9acb0bc61d11f	\N	2025-09-05 23:23:52.745681	2025-09-20 17:38:08.908177	/root/muayene-raporlama/backend/uploads/reports/10/unsigned.pdf	/home/damn/Desktop/muayene/backend/uploads/reports/10/signed.pdf	{}
16	23	f	\N	\N	09a796deb7e9ccd7b2561f011f598201	\N	2025-09-19 18:21:38.406196	2025-09-19 18:21:50.476636	/root/muayene-raporlama/backend/uploads/reports/16/unsigned.pdf	\N	{}
15	1	f	\N	\N	5815d2190e6cfa54d67bc2c8520cea47	\N	2025-09-11 17:33:16.551262	2025-09-20 17:58:52.861152	/root/muayene-raporlama/backend/uploads/reports/15/unsigned.pdf	\N	{}
13	18	f	\N	\N	d77b51e74d305a120f7d1f586a81f525	\N	2025-09-06 22:21:57.26762	2025-09-20 18:28:00.004952	/root/muayene-raporlama/backend/uploads/reports/13/unsigned.pdf	\N	{}
14	20	f	\N	\N	4735c6ada782f3824cc66a5836d62f7d	\N	2025-09-11 17:26:37.615805	2025-09-19 19:42:04.636829	/root/muayene-raporlama/backend/uploads/reports/14/unsigned.pdf	\N	{}
11	15	f	\N	\N	2f9a7026521b526363a83b39b2be49b7	\N	2025-09-05 23:40:26.814511	2025-09-20 18:57:17.741637	/root/muayene-raporlama/backend/uploads/reports/11/unsigned.pdf	\N	{"scale": "medium"}
17	24	f	\N	\N	1bb17c603339e4eba7c5bd6377601fec	\N	2025-09-20 12:24:56.372073	2025-09-20 12:46:33.511325	/root/muayene-raporlama/backend/uploads/reports/17/unsigned.pdf	\N	{"scale": "small"}
\.


--
-- Data for Name: technicians; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.technicians (id, company_id, name, surname, email, phone, password_hash, e_signature_pin, permissions, is_active, created_at, updated_at) FROM stdin;
1	1	Süper	Admin	superadmin@abc.com	+90 555 0001	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	\N	["superAdmin"]	t	2025-08-16 23:42:54.349038	2025-08-16 23:42:54.349038
2	1	Firma	Admin	admin@abc.com	+90 555 0002	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	\N	["companyAdmin", "viewTechnicians", "createTechnician", "editTechnician", "viewCustomers", "createCustomer", "editCustomer", "viewEquipment", "createEquipment", "editEquipment", "viewOffers", "createOffer", "editOffer", "approveOffer", "sendOffer", "viewWorkOrders", "createWorkOrder", "editWorkOrder", "assignWorkOrder", "updateWorkOrderStatus", "viewInspections", "editInspection", "saveInspection", "completeInspection", "uploadPhotos", "viewReports", "downloadReports", "signReports", "sendReports", "viewDashboard", "viewCalendar", "deleteTechnician"]	t	2025-08-16 23:42:54.349038	2025-09-11 18:36:53.449271
4	1	MURAT	AYDIN	dsad@kdsa.com	5528986800	$2b$10$ztwrAMxwTUJ8YCrlfcg3luMHgYNZigHBKqPNs.qFa5r.OS/EuJnV6	1705	["companyAdmin", "superAdmin", "createCustomer", "viewCustomers", "editCustomer", "viewEquipment", "createEquipment", "editEquipment", "sendOffer", "approveOffer", "createOffer", "editOffer", "viewOffers", "viewWorkOrders", "createWorkOrder", "editWorkOrder", "assignWorkOrder", "saveInspection", "updateWorkOrderStatus", "viewInspections", "editInspection", "downloadReports", "viewReports", "uploadPhotos", "completeInspection", "signReports", "sendReports", "viewDashboard", "viewCalendar", "editTechnician", "deleteTechnician", "viewTechnicians", "createTechnician"]	t	2025-09-10 00:44:43.587784	2025-09-20 17:39:45.377869
3	1	Ahmet	Yılmaz	ahmet@abc.com	+90 555 0003	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	123456	["viewInspections", "editInspection", "saveInspection", "completeInspection", "uploadPhotos", "viewReports", "downloadReports", "signReports", "viewCalendar", "viewWorkOrders", "viewMyInspections", "viewMyWorkOrders"]	t	2025-08-16 23:42:54.349038	2025-09-21 13:27:36.529469
\.


--
-- Data for Name: work_order_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_order_assignments (id, work_order_id, technician_id, assigned_at) FROM stdin;
1	2	3	2025-08-16 23:56:31.749559
2	19	3	2025-09-10 19:17:55.412466
4	18	3	2025-09-10 20:24:29.680598
5	20	3	2025-09-11 17:25:00.871964
8	22	1	2025-09-19 18:20:43.353761
9	22	2	2025-09-19 18:20:43.353761
14	23	4	2025-09-20 18:23:51.575939
15	23	2	2025-09-20 18:23:51.575939
\.


--
-- Data for Name: work_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_orders (id, company_id, work_order_number, customer_company_id, offer_id, status, scheduled_date, notes, created_by, created_at, updated_at) FROM stdin;
1	1	WO-379185827	1	\N	not_started	2025-08-20	Test iş emri oluşturulması	2	2025-08-16 23:49:39.185071	2025-08-16 23:49:39.185071
2	1	WO-769167706	1	1	not_started	2025-08-25	Teklif onaylandı, iş emri oluşturuldu	2	2025-08-16 23:56:09.166997	2025-08-16 23:56:09.166997
3	1	WO-284936958	3	3	sent	2025-09-03	Tekliften	2	2025-09-03 22:04:44.936477	2025-09-03 22:04:48.373931
8	1	WO-189655172	8	8	sent	2025-11-22	Tekliften	2	2025-09-03 23:59:49.655228	2025-09-03 23:59:53.836693
9	1	WO-527577495	9	9	sent	2025-09-11	Tekliften	2	2025-09-04 01:12:07.577137	2025-09-04 01:12:11.134704
10	1	WO-716508844	10	10	sent	2025-09-20	Tekliften	2	2025-09-04 01:15:16.50853	2025-09-04 01:15:20.883953
11	1	WO-951218008	11	11	sent	2025-11-14	Tekliften	2	2025-09-04 01:19:11.218108	2025-09-04 01:19:14.802643
12	1	WO-976718531	12	12	sent	2025-09-10	Tekliften	2	2025-09-04 01:19:36.718609	2025-09-04 01:19:39.780416
13	1	WO-992175701	13	13	sent	2025-09-26	Tekliften	2	2025-09-04 01:19:52.175795	2025-09-04 01:19:54.712514
14	1	WO-832678124	14	14	sent	2025-11-27	Tekliften	2	2025-09-05 23:23:52.678639	2025-09-05 23:23:56.881303
15	1	WO-826752081	15	15	sent	2025-12-01	Tekliften	2	2025-09-05 23:40:26.75272	2025-09-05 23:40:31.235444
17	1	WO-514050486	17	17	sent	2025-10-30	Tekliften	2	2025-09-05 23:51:54.049876	2025-09-05 23:51:59.204509
19	1	WO-701193426	18	18	not_started	2025-08-09	mdsads	2	2025-09-10 19:11:41.19331	2025-09-10 19:11:41.19331
18	1	WO-517226702	18	18	sent	2025-11-03	Tekliften	2	2025-09-06 22:21:57.226292	2025-09-10 20:24:28.616996
20	1	WO-700872010	17	\N	not_started	2024-01-30	örnek	2	2025-09-11 17:25:00.871964	2025-09-11 17:25:00.871964
22	1	WO-043354217	18	\N	not_started	\N	örnek!!!!	2	2025-09-19 18:20:43.353761	2025-09-19 18:20:43.353761
7	1	WO-380928031	7	7	in_progress	2025-10-24	Tekliften	2	2025-09-03 22:56:20.928039	2025-09-20 18:27:18.315939
23	1	WO-047692502	1	\N	not_started	2025-05-05	küçük(sıkıştırılmmış)	2	2025-09-20 12:24:07.692088	2025-09-20 20:44:07.127678
\.


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: customer_companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_companies_id_seq', 19, true);


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipment_id_seq', 30, true);


--
-- Name: inspections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inspections_id_seq', 24, true);


--
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_id_seq', 18, true);


--
-- Name: report_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_jobs_id_seq', 28, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_id_seq', 17, true);


--
-- Name: technicians_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.technicians_id_seq', 4, true);


--
-- Name: work_order_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_order_assignments_id_seq', 15, true);


--
-- Name: work_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_orders_id_seq', 23, true);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: companies companies_tax_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_tax_number_key UNIQUE (tax_number);


--
-- Name: customer_companies customer_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_companies
    ADD CONSTRAINT customer_companies_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: inspections inspections_inspection_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_inspection_number_key UNIQUE (inspection_number);


--
-- Name: inspections inspections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_pkey PRIMARY KEY (id);


--
-- Name: offers offers_offer_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_offer_number_key UNIQUE (offer_number);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: offers offers_tracking_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_tracking_token_key UNIQUE (tracking_token);


--
-- Name: report_jobs report_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_jobs
    ADD CONSTRAINT report_jobs_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reports reports_qr_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_qr_token_key UNIQUE (qr_token);


--
-- Name: technicians technicians_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_email_key UNIQUE (email);


--
-- Name: technicians technicians_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_pkey PRIMARY KEY (id);


--
-- Name: inspections unique_time_slot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT unique_time_slot UNIQUE (technician_id, inspection_date, start_time, end_time);


--
-- Name: work_order_assignments work_order_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_order_assignments
    ADD CONSTRAINT work_order_assignments_pkey PRIMARY KEY (id);


--
-- Name: work_order_assignments work_order_assignments_work_order_id_technician_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_order_assignments
    ADD CONSTRAINT work_order_assignments_work_order_id_technician_id_key UNIQUE (work_order_id, technician_id);


--
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (id);


--
-- Name: work_orders work_orders_work_order_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_work_order_number_key UNIQUE (work_order_number);


--
-- Name: idx_customer_companies_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_companies_company_id ON public.customer_companies USING btree (company_id);


--
-- Name: idx_equipment_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_equipment_company_id ON public.equipment USING btree (company_id);


--
-- Name: idx_inspections_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspections_date ON public.inspections USING btree (inspection_date);


--
-- Name: idx_inspections_technician_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspections_technician_id ON public.inspections USING btree (technician_id);


--
-- Name: idx_inspections_work_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspections_work_order_id ON public.inspections USING btree (work_order_id);


--
-- Name: idx_offers_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offers_company_id ON public.offers USING btree (company_id);


--
-- Name: idx_offers_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offers_status ON public.offers USING btree (status);


--
-- Name: idx_report_jobs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_report_jobs_created_at ON public.report_jobs USING btree (created_at);


--
-- Name: idx_report_jobs_report_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_report_jobs_report_id ON public.report_jobs USING btree (report_id);


--
-- Name: idx_report_jobs_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_report_jobs_status ON public.report_jobs USING btree (status);


--
-- Name: idx_reports_inspection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_inspection_id ON public.reports USING btree (inspection_id);


--
-- Name: idx_reports_qr_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_qr_token ON public.reports USING btree (qr_token);


--
-- Name: idx_technicians_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_technicians_company_id ON public.technicians USING btree (company_id);


--
-- Name: idx_technicians_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_technicians_email ON public.technicians USING btree (email);


--
-- Name: idx_work_orders_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_work_orders_company_id ON public.work_orders USING btree (company_id);


--
-- Name: idx_work_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_work_orders_status ON public.work_orders USING btree (status);


--
-- Name: uniq_report_jobs_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uniq_report_jobs_active ON public.report_jobs USING btree (report_id) WHERE ((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('processing'::character varying)::text]));


--
-- Name: companies update_companies_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON public.companies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: customer_companies update_customer_companies_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_customer_companies_updated_at BEFORE UPDATE ON public.customer_companies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: equipment update_equipment_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_equipment_updated_at BEFORE UPDATE ON public.equipment FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: inspections update_inspections_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_inspections_updated_at BEFORE UPDATE ON public.inspections FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: offers update_offers_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_offers_updated_at BEFORE UPDATE ON public.offers FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: report_jobs update_report_jobs_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_report_jobs_updated_at BEFORE UPDATE ON public.report_jobs FOR EACH ROW EXECUTE FUNCTION public.update_report_jobs_updated_at();


--
-- Name: reports update_reports_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_reports_updated_at BEFORE UPDATE ON public.reports FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: technicians update_technicians_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_technicians_updated_at BEFORE UPDATE ON public.technicians FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: work_orders update_work_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_work_orders_updated_at BEFORE UPDATE ON public.work_orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: customer_companies customer_companies_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_companies
    ADD CONSTRAINT customer_companies_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: equipment equipment_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: inspections inspections_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(id);


--
-- Name: inspections inspections_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(id);


--
-- Name: inspections inspections_work_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_work_order_id_fkey FOREIGN KEY (work_order_id) REFERENCES public.work_orders(id) ON DELETE CASCADE;


--
-- Name: offers offers_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.technicians(id);


--
-- Name: offers offers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: offers offers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.technicians(id);


--
-- Name: offers offers_customer_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_customer_company_id_fkey FOREIGN KEY (customer_company_id) REFERENCES public.customer_companies(id);


--
-- Name: report_jobs report_jobs_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_jobs
    ADD CONSTRAINT report_jobs_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.reports(id) ON DELETE CASCADE;


--
-- Name: reports reports_inspection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_inspection_id_fkey FOREIGN KEY (inspection_id) REFERENCES public.inspections(id) ON DELETE CASCADE;


--
-- Name: reports reports_signed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_signed_by_fkey FOREIGN KEY (signed_by) REFERENCES public.technicians(id);


--
-- Name: technicians technicians_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: work_order_assignments work_order_assignments_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_order_assignments
    ADD CONSTRAINT work_order_assignments_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(id);


--
-- Name: work_order_assignments work_order_assignments_work_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_order_assignments
    ADD CONSTRAINT work_order_assignments_work_order_id_fkey FOREIGN KEY (work_order_id) REFERENCES public.work_orders(id) ON DELETE CASCADE;


--
-- Name: work_orders work_orders_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: work_orders work_orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.technicians(id);


--
-- Name: work_orders work_orders_customer_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_customer_company_id_fkey FOREIGN KEY (customer_company_id) REFERENCES public.customer_companies(id);


--
-- Name: work_orders work_orders_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: damn
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO damn;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE companies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.companies TO damn;


--
-- Name: SEQUENCE companies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.companies_id_seq TO damn;


--
-- Name: TABLE customer_companies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_companies TO damn;


--
-- Name: SEQUENCE customer_companies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.customer_companies_id_seq TO damn;


--
-- Name: TABLE equipment; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.equipment TO damn;


--
-- Name: SEQUENCE equipment_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.equipment_id_seq TO damn;


--
-- Name: TABLE inspections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.inspections TO damn;


--
-- Name: SEQUENCE inspections_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.inspections_id_seq TO damn;


--
-- Name: TABLE offers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.offers TO damn;


--
-- Name: SEQUENCE offers_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.offers_id_seq TO damn;


--
-- Name: TABLE report_jobs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.report_jobs TO damn;


--
-- Name: SEQUENCE report_jobs_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.report_jobs_id_seq TO damn;


--
-- Name: TABLE reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reports TO damn;


--
-- Name: SEQUENCE reports_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reports_id_seq TO damn;


--
-- Name: TABLE technicians; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.technicians TO damn;


--
-- Name: SEQUENCE technicians_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.technicians_id_seq TO damn;


--
-- Name: TABLE work_order_assignments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.work_order_assignments TO damn;


--
-- Name: SEQUENCE work_order_assignments_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.work_order_assignments_id_seq TO damn;


--
-- Name: TABLE work_orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.work_orders TO damn;


--
-- Name: SEQUENCE work_orders_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.work_orders_id_seq TO damn;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO damn;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO damn;


--
-- PostgreSQL database dump complete
--

-- \unrestrict aung1UuRK21TBpWHVn867OcHSsVpVNAqZYm3RSsXemzENrs4wYhKUi01KPR3bnB

