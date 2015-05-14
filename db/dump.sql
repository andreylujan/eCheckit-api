--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: action_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE action_types (
    id integer NOT NULL,
    description text,
    organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.action_types OWNER TO echeckit;

--
-- Name: action_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE action_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.action_types_id_seq OWNER TO echeckit;

--
-- Name: action_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE action_types_id_seq OWNED BY action_types.id;


--
-- Name: actions; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action_type_id integer,
    user_id integer,
    report_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.actions OWNER TO echeckit;

--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actions_id_seq OWNER TO echeckit;

--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    description text,
    phone_number text,
    venue_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contacts OWNER TO echeckit;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO echeckit;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: domains; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE domains (
    id integer NOT NULL,
    organization_id integer,
    domain text NOT NULL,
    default_email text NOT NULL,
    allow_automatic_registration boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.domains OWNER TO echeckit;

--
-- Name: domains_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domains_id_seq OWNER TO echeckit;

--
-- Name: domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE domains_id_seq OWNED BY domains.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE feedbacks (
    id integer NOT NULL,
    comment text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rating integer NOT NULL
);


ALTER TABLE public.feedbacks OWNER TO echeckit;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO echeckit;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE feedbacks_id_seq OWNED BY feedbacks.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying
);


ALTER TABLE public.oauth_access_grants OWNER TO echeckit;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_grants_id_seq OWNER TO echeckit;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_access_grants_id_seq OWNED BY oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying
);


ALTER TABLE public.oauth_access_tokens OWNER TO echeckit;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_tokens_id_seq OWNER TO echeckit;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_access_tokens_id_seq OWNED BY oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE oauth_applications (
    id integer NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.oauth_applications OWNER TO echeckit;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_applications_id_seq OWNER TO echeckit;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE oauth_applications_id_seq OWNED BY oauth_applications.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.organizations OWNER TO echeckit;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO echeckit;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: pictures; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE pictures (
    id integer NOT NULL,
    url text NOT NULL,
    report_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    comment text
);


ALTER TABLE public.pictures OWNER TO echeckit;

--
-- Name: pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pictures_id_seq OWNER TO echeckit;

--
-- Name: pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE pictures_id_seq OWNED BY pictures.id;


--
-- Name: report_field_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE report_field_types (
    id integer NOT NULL,
    name text,
    workspace_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    widget_id integer,
    translations json,
    data json
);


ALTER TABLE public.report_field_types OWNER TO echeckit;

--
-- Name: report_field_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE report_field_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_field_types_id_seq OWNER TO echeckit;

--
-- Name: report_field_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE report_field_types_id_seq OWNED BY report_field_types.id;


--
-- Name: report_fields; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE report_fields (
    id integer NOT NULL,
    report_id integer,
    report_field_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value json NOT NULL
);


ALTER TABLE public.report_fields OWNER TO echeckit;

--
-- Name: report_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE report_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_fields_id_seq OWNER TO echeckit;

--
-- Name: report_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE report_fields_id_seq OWNED BY report_fields.id;


--
-- Name: report_states; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE report_states (
    id integer NOT NULL,
    name text NOT NULL,
    workspace_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.report_states OWNER TO echeckit;

--
-- Name: report_states_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE report_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_states_id_seq OWNER TO echeckit;

--
-- Name: report_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE report_states_id_seq OWNED BY report_states.id;


--
-- Name: report_types; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE report_types (
    id integer NOT NULL,
    description text,
    organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.report_types OWNER TO echeckit;

--
-- Name: report_types_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE report_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_types_id_seq OWNER TO echeckit;

--
-- Name: report_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE report_types_id_seq OWNED BY report_types.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE reports (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    assigned_user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    report_state_id integer,
    workspace_id integer,
    venue_id integer,
    title text NOT NULL,
    address text,
    city text,
    region text,
    commune text,
    country text,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    reference text,
    comment text
);


ALTER TABLE public.reports OWNER TO echeckit;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO echeckit;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE reports_id_seq OWNED BY reports.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying,
    resource_id integer,
    resource_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.roles OWNER TO echeckit;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO echeckit;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO echeckit;

--
-- Name: users; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name text NOT NULL,
    last_name text,
    picture text,
    is_demo boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO echeckit;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO echeckit;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


ALTER TABLE public.users_roles OWNER TO echeckit;

--
-- Name: venues; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE venues (
    id integer NOT NULL,
    organization_id integer,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.venues OWNER TO echeckit;

--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venues_id_seq OWNER TO echeckit;

--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE widgets (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.widgets OWNER TO echeckit;

--
-- Name: widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE widgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.widgets_id_seq OWNER TO echeckit;

--
-- Name: widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE widgets_id_seq OWNED BY widgets.id;


--
-- Name: workspaces; Type: TABLE; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE TABLE workspaces (
    id integer NOT NULL,
    name text,
    organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_open boolean DEFAULT true NOT NULL
);


ALTER TABLE public.workspaces OWNER TO echeckit;

--
-- Name: workspaces_id_seq; Type: SEQUENCE; Schema: public; Owner: echeckit
--

CREATE SEQUENCE workspaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workspaces_id_seq OWNER TO echeckit;

--
-- Name: workspaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echeckit
--

ALTER SEQUENCE workspaces_id_seq OWNED BY workspaces.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY action_types ALTER COLUMN id SET DEFAULT nextval('action_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY domains ALTER COLUMN id SET DEFAULT nextval('domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY feedbacks ALTER COLUMN id SET DEFAULT nextval('feedbacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('oauth_access_grants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('oauth_access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY oauth_applications ALTER COLUMN id SET DEFAULT nextval('oauth_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY pictures ALTER COLUMN id SET DEFAULT nextval('pictures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_field_types ALTER COLUMN id SET DEFAULT nextval('report_field_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_fields ALTER COLUMN id SET DEFAULT nextval('report_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_states ALTER COLUMN id SET DEFAULT nextval('report_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_types ALTER COLUMN id SET DEFAULT nextval('report_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports ALTER COLUMN id SET DEFAULT nextval('reports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY widgets ALTER COLUMN id SET DEFAULT nextval('widgets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY workspaces ALTER COLUMN id SET DEFAULT nextval('workspaces_id_seq'::regclass);


--
-- Data for Name: action_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY action_types (id, description, organization_id, created_at, updated_at) FROM stdin;
1	Cobrar	1	2015-04-15 21:53:11.217335	2015-04-15 21:53:11.217335
\.


--
-- Name: action_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('action_types_id_seq', 1, true);


--
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY actions (id, action_type_id, user_id, report_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('actions_id_seq', 1, false);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY contacts (id, description, phone_number, venue_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('contacts_id_seq', 1, false);


--
-- Data for Name: domains; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY domains (id, organization_id, domain, default_email, allow_automatic_registration, created_at, updated_at) FROM stdin;
1	1	koandina.cl	admin	t	2015-04-21 22:39:37.575241	2015-04-21 22:39:37.575241
\.


--
-- Name: domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('domains_id_seq', 1, true);


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY feedbacks (id, comment, user_id, created_at, updated_at, rating) FROM stdin;
9	Jxkxnz	1	2015-04-23 19:24:03.689737	2015-04-23 19:24:03.689737	0
10	Nvhj	1	2015-04-23 19:37:35.427383	2015-04-23 19:37:35.427383	0
11	Genial	1	2015-04-23 19:41:12.084158	2015-04-23 19:41:12.084158	2
12	Katty	1	2015-04-23 19:44:54.941335	2015-04-23 19:44:54.941335	2
13	fff	22	2015-04-24 11:50:25.561758	2015-04-24 11:50:25.561758	2
14	Hjygg	1	2015-04-24 18:52:12.000817	2015-04-24 18:52:12.000817	2
15	me gusta\n	26	2015-04-25 00:39:04.384029	2015-04-25 00:39:04.384029	2
16	This rocks 	1	2015-04-26 17:51:09.774885	2015-04-26 17:51:09.774885	2
17	Bush 	1	2015-04-27 08:10:53.010779	2015-04-27 08:10:53.010779	2
18	Bkk	1	2015-04-27 18:30:39.43953	2015-04-27 18:30:39.43953	0
19	hdudhdidn	28	2015-05-11 13:39:57.605073	2015-05-11 13:39:57.605073	0
\.


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('feedbacks_id_seq', 19, true);


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_access_grants (id, resource_owner_id, application_id, token, expires_in, redirect_uri, created_at, revoked_at, scopes) FROM stdin;
\.


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_access_grants_id_seq', 1, false);


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_access_tokens (id, resource_owner_id, application_id, token, refresh_token, expires_in, revoked_at, created_at, scopes) FROM stdin;
1	1	1	a2a6c41c97f8ca05e2f1ca316a3a5330454be4c6d1ceb36ac5a5b93fe031c647	\N	\N	\N	2015-04-15 21:53:11.062477	\N
2	2	1	172ce63ec7de0884508e5f5902864ac08d4199c429dc21a7e2cfeff6876632e3	\N	\N	\N	2015-04-15 21:53:11.141493	\N
3	1	1	67e45ecc071e7b5cdea765be1137dcf5c2234781c0af446fd6b6cff6f5a55f94	\N	\N	\N	2015-04-15 21:53:29.724976	\N
4	1	1	998708ff70bb278c8fef049980a8c9ec3484acb619096e969d4b9fd5ed85f02b	\N	\N	\N	2015-04-15 23:08:29.914239	\N
5	1	1	35d1972a6ae4d33baeea4e3a4114a2b149db6d069884d451d9a83741a21b8d1b	\N	\N	\N	2015-04-15 23:47:11.764912	\N
6	1	1	ce0d496d9fdc819ab161ac0b37097eb1165cf0741aa65624927ba875d7a09f7a	\N	\N	\N	2015-04-16 20:23:19.471298	\N
7	1	1	4c6f38828c41d64d98fdc31c6b7865c557f3a06fd77c70a25de397c078ce5693	\N	\N	\N	2015-04-16 21:04:30.697148	\N
8	1	1	4028ed4df51e868177412829a54c80b76aab17591ff84f69211cfb5e2572fbc0	\N	\N	\N	2015-04-16 21:08:10.33644	\N
9	1	1	3e8f972a21aabba14945808bac0e8978549ccecb85f4a3aed9275f75a659eaf0	\N	\N	\N	2015-04-16 21:09:06.491232	\N
10	1	1	8035ee23545d6c9353d08381d88106b7ce8cf6a44d0ad68d2955ee208ef6d368	\N	\N	\N	2015-04-16 21:20:35.093188	\N
11	1	1	065085a3652ecaff7482924af8d73cd7baee082ee7a4d1dbbbbff4360e666fde	\N	\N	\N	2015-04-16 22:56:17.533222	\N
12	1	1	7046b79ff40921d21546a2f916125361ecbb56aacad997a53c33e0d605f0d438	\N	\N	\N	2015-04-17 04:17:54.525495	\N
13	1	1	22a7a2b86495c4155f3e7a654e0a8315a4075bd483ddff22ab92f82015b472f4	\N	\N	\N	2015-04-17 04:19:50.793119	\N
14	1	1	b4bc0a6e4f624e04e9b35eeff3a13bdd8be5260cfa503ca1bc79132af8eb1404	\N	\N	\N	2015-04-17 04:21:19.911715	\N
15	1	1	0b6e98a7076b178c12434fa242b548871f1fe949a45a76b1371d0d5696201a3f	\N	\N	\N	2015-04-17 04:22:26.704419	\N
16	1	1	b2d053abb0f69e7e06df0323c18f68281fba9151dabd47f8699689834e381984	\N	\N	\N	2015-04-17 04:23:05.554756	\N
17	1	1	7370a0290db361ee3da92cd2712c4cebcf61efe271e7fb593a4837ca386655f8	\N	\N	\N	2015-04-17 04:27:09.288753	\N
18	1	1	e95ba240de7ada164e2aa8be2f15141bb40c759ed1df297801c95fa4c9ec8db2	\N	\N	\N	2015-04-17 04:27:16.027973	\N
19	1	1	9ad070a99518c58c28bc9390548d2ecbecf505182da8e12e757f461bff54eb3c	\N	\N	\N	2015-04-17 04:30:18.930796	\N
20	1	1	d33b1d977adec674c7a496911d6033d1ade1a8b84fb92103b881dff9c8fade29	\N	\N	\N	2015-04-17 04:30:25.149697	\N
21	1	1	5a12a6e4091e4554dc5d1035488d5955ed293c578e2fa0f0b73ef0fc11de63f1	\N	\N	\N	2015-04-17 04:48:09.445576	\N
22	3	1	25933ffdec8c6a1fcaeeeda055a13fd9b7589ce1963b62dd200eb28f541d9d67	\N	\N	\N	2015-04-17 04:48:23.826809	\N
23	1	1	17dc780419542e104cd0a2a914b86beef3c2facbe7f548ed20d8cf1dd3cdb040	\N	\N	\N	2015-04-17 04:48:36.126215	\N
24	1	1	5ab63830a158aeadeae79c840323d3c07db8e8d690ea1f2520c6a329f56174ff	\N	\N	\N	2015-04-17 04:50:39.754495	\N
25	1	1	039a56026a6dbca0d58b3acd5428eacee3b1e98d1e459ab4f79377768212d265	\N	\N	\N	2015-04-17 04:55:24.859505	\N
26	1	1	0cd59c41d52fc04743186a8b70bbf536d107184c48a6e031900d01acb08214c9	\N	\N	\N	2015-04-17 05:14:56.956799	\N
27	1	1	46d686579da9ec3decfad4d963cba8f4295e7eed7cfead867f90e8f0cca77a5d	\N	\N	\N	2015-04-17 05:28:38.716863	\N
28	1	1	8f2dc73fc287adc2ed7c3e4543d3699b64a3a9272c55839c188c405759d2ad5b	\N	\N	\N	2015-04-17 05:34:14.861392	\N
29	1	1	e05ce00d29aadea78cb2963333fdb8531858277fdbb09ba17ddb081048583937	\N	\N	\N	2015-04-17 05:53:14.657475	\N
30	1	1	fb1110c68492f6b8a7091839a0bc3ff4de72dbcd4e7c299c5ffe91d48710ba1d	\N	\N	\N	2015-04-17 05:53:22.158044	\N
31	1	1	4b482573c40e9cb0b49588e457f1fcc1f83ccae70fb687d0c36bce5c0e1eab2e	\N	\N	\N	2015-04-17 05:54:18.450086	\N
32	1	1	3418d73a02f9db5ab1354f46a7b57771110b1afdd846c40a6234378610d6b9c1	\N	\N	\N	2015-04-17 05:59:09.938772	\N
33	1	1	89b18e9eddef20ecb6f646616821263a47d371362c1bbf5c54eafce6e2ea9406	\N	\N	\N	2015-04-17 07:41:27.49355	\N
34	1	1	9ccaabfbf6358c5f0cdb8c2264d6b4df79ee94f914f3a42ad538c7fef0fd589f	\N	\N	\N	2015-04-17 14:13:19.530561	\N
35	1	1	93e927282d79d59dd817fb4c4eeed5a121200c351c3686cf9970c24d5620a13e	\N	\N	\N	2015-04-17 16:37:20.242632	\N
36	1	1	1b3b63fa790cfb1e7376978ee359ed09ea103ab25bfd9860bae961d098bf6357	\N	\N	\N	2015-04-17 16:48:58.546624	\N
37	1	1	3c3ec19b09d893428de8b208ae8a1d492241cf9dba6a0f740ebe7cc3e38f7a2a	\N	\N	\N	2015-04-17 16:49:21.914732	\N
38	1	1	79d55e80492e175265f004e0b3f8ebb598f92fb6fe77c1f5c0e4c35fc3900697	\N	\N	\N	2015-04-17 16:50:41.305872	\N
39	1	1	561f80d08e080392eab3ed54ef51c21a16144fad2bbc6dd8fe79b639933cb6a4	\N	\N	\N	2015-04-17 16:50:52.709085	\N
40	1	1	bb2c7b64929555183453b78fada73a62825c8fcbc3178cc971200ae12ddb3896	\N	\N	\N	2015-04-17 16:52:29.926419	\N
41	1	1	f306739e1d4cc3c2010e2ef41280ee23fc8f5ece82bcef58353b13ba4eb76a2f	\N	\N	\N	2015-04-17 16:56:10.290175	\N
42	1	1	1d730ebf3b01ebc2422354ca3c3da00e867be157b20e02c2b42dcf1f1468df18	\N	\N	\N	2015-04-17 16:56:31.645324	\N
43	1	1	e085b18fd37aa53b38af1755ff067a806e5c12c4a764f088068c25b4ba022d78	\N	\N	\N	2015-04-17 17:01:09.562704	\N
44	1	1	14936978a81acc2719621217d8705b9cedba23a71d390867916ed860f858192c	\N	\N	\N	2015-04-17 17:31:19.577692	\N
45	1	1	826cc76b88821305ec7e9cfea96ba923894dcff39b8c8e49fbcb221ffba089ff	\N	\N	\N	2015-04-17 17:38:36.977758	\N
46	1	1	2afdcdd96ae0284646ac5ce41b78edfecc6f5dce02c1d0c8e12c3277d2061562	\N	\N	\N	2015-04-17 17:40:12.265367	\N
47	1	1	4dcf8859d54b4f5f29e2aeb25d5767e1b58d546f5626f7163a1c1068fc7507d1	\N	\N	\N	2015-04-17 17:42:32.352146	\N
48	1	1	bf4855dd41b497ee51f2fd96ff2ba98de4c4b609a4af3944b7437ce358ebab77	\N	\N	\N	2015-04-17 17:45:44.594477	\N
49	1	1	333dbfebc6bdb6d06704e74a348c6fcf5d1d562e5d3d2153442fcb4a1e0c48cf	\N	\N	\N	2015-04-17 17:52:43.219078	\N
50	1	1	cae38117642005d59b7827a881e51facde0a291bd2365baed22d6b7e248afa7c	\N	\N	\N	2015-04-17 19:20:42.990112	\N
51	1	1	3131c73316f9aa3b09bd1baf66972b1aecef2ffde25f597f2aa8439f4cb652e4	\N	\N	\N	2015-04-17 19:22:14.063317	\N
52	1	1	4bd9753bcb5a29b7886259445895927d58c7ac8ea091c7e7bc23d21381077f47	\N	\N	\N	2015-04-17 19:33:54.674688	\N
53	1	1	c4aee299f91a9793d024f63d8233b6c44c303e915ad8580a464a3d72048451f6	\N	\N	\N	2015-04-17 19:58:13.053316	\N
54	1	1	7ab885daada9cda42b3c7b40d0cc0cd804d515456c235c576b9f771dc0879ca8	\N	\N	\N	2015-04-17 20:05:45.948344	\N
55	4	1	5ea9ceaf7cc2408e414010e581bdb18ab1a09cd46f49e3cb22a26851b52c2987	\N	\N	\N	2015-04-17 20:08:04.686496	\N
56	1	1	95f6dab61aa5fab47eb7b522a71a704a4f3fc97a7207bbf2be1241b8d38e6379	\N	\N	\N	2015-04-17 20:24:41.137998	\N
57	1	1	968da03e6d3ea47a2aef0ab6f8d935696de708d390407ff064929c718972e85a	\N	\N	\N	2015-04-17 20:39:13.847823	\N
58	1	1	d3f31e0c3e9924dd2ebdac257e2430f4dcb5e3a6bf6066867ef1ee4bd49db76a	\N	\N	\N	2015-04-17 20:46:48.198758	\N
59	1	1	f7d73ed94dba67093a616bf8fe1cbba91c0739e5bdab65d957c1a4603808df96	\N	\N	\N	2015-04-17 20:46:55.058739	\N
60	1	1	f124e1ed0afb840d91c37806ec5a31ad311ef9bb3aca41c3722cc82e6d7cb5db	\N	\N	\N	2015-04-17 20:47:08.672548	\N
61	1	1	fe6635e03f76c10e75070f968798b33901d7127cea461fd9a5240a9862e604d3	\N	\N	\N	2015-04-17 20:47:21.664691	\N
62	1	1	8c0ff3edb4c65fb97fb0474f5e8a15ca1948e8d3f78716ac348a13e71fb0809f	\N	\N	\N	2015-04-17 20:50:31.513665	\N
63	5	1	4f7f8c1f4755b6c6c04764a861cac212f1babc4a98393c2a0f42bb982c33c507	\N	\N	\N	2015-04-17 20:51:21.710978	\N
64	1	1	967a821363e4485228a0b96dcf4493be82070eeac7b2cefe828e2ee156531e1c	\N	\N	\N	2015-04-17 20:52:20.270283	\N
65	1	1	14cf5c949403a97762c7356414d6de8da101235f6fea2bf2ab54fbd4f62876bc	\N	\N	\N	2015-04-17 21:01:02.586808	\N
66	1	1	e29b72a533d93a9cd0a9a1fd61c72ca9f2434b0a6750951e6a06fcb0cb04fcb9	\N	\N	\N	2015-04-17 21:05:42.787665	\N
67	1	1	ccbec462a3a1bc7a989fbc9beedd17abe9824505a058da4a35847f33fcb72fe4	\N	\N	\N	2015-04-17 21:10:23.258626	\N
68	1	1	b5b2c5ac349634849f992671bc636fe76f857095c5390a0af49a68ee311dc02f	\N	\N	\N	2015-04-17 21:11:43.42832	\N
69	1	1	2df7ddd28dd130b6f5af62c05b8da2503c32f5da4c32e863b65135786a69781f	\N	\N	\N	2015-04-17 21:17:30.805481	\N
70	1	1	23d79afb479330fd4c9f3e8b54896c03f298146a4a2451e3c28666018b806f0c	\N	\N	\N	2015-04-17 21:18:58.480987	\N
71	1	1	7e84d5ef1262cf5a504be8d05176b9924c61c4f0cd6a33b7babc37c074af9913	\N	\N	\N	2015-04-17 21:27:32.757658	\N
72	1	1	e55785a677958c750bd0190ffe4dbef3c0c42e337b3e3085de3614e6ad264773	\N	\N	\N	2015-04-17 21:36:23.373396	\N
73	1	1	cc4904077572e337729bc30058459dcb1cb2ef4c2ac04aae831a6aac6355fdb9	\N	\N	\N	2015-04-17 21:41:45.094693	\N
74	1	1	0018e2441a2907d014170ea1f6beefe5ee9b7e726af2325c582618658a4875dd	\N	\N	\N	2015-04-17 21:45:49.876638	\N
75	6	1	2f504b9ce00a4405659985ad81263ad2b7079fc36a96950a708a51acf5136237	\N	\N	\N	2015-04-18 00:35:10.124239	\N
76	1	1	e1928ffc4a1d5a841c50d8db098fa117d41e41d5fb9ef3ce85f826dd6db28c43	\N	\N	\N	2015-04-18 02:25:43.496524	\N
77	1	1	b3ef133f38a3b18aa0ce92325ca0dcfe419c2d8b28f380d829b516073fb65027	\N	\N	\N	2015-04-18 17:28:32.693959	\N
78	1	1	76fb567842bac5e6a05e6536a75c076e83a915de56e2d46a9131f4666497bab4	\N	\N	\N	2015-04-18 19:01:12.021458	\N
79	1	1	985b4ed79e87144d7770f5bcc10e0eca695cf07cff81ec366b8e9a57a375bf7e	\N	\N	\N	2015-04-18 19:11:36.042743	\N
80	1	1	c4b3b9533efa73db2cb2a048db3b5aa042cf7efa324604b5b752baaa7f9ad321	\N	\N	\N	2015-04-18 19:12:01.47023	\N
81	1	1	cce5a155dd1ff6be0abe941669e965cafae8ce9688937eff4bc46ddae5535250	\N	\N	\N	2015-04-18 19:16:47.967122	\N
82	1	1	da18d0e00435a9fb7c928d2cc757004a1e1d1a389a857229341fec02745572c8	\N	\N	\N	2015-04-18 19:16:59.249874	\N
83	1	1	a7f657ccb87ad17e93feed394f3aa29d2cde482377a3ce62ff916b30ec2323df	\N	\N	\N	2015-04-18 19:18:08.544122	\N
84	1	1	232623c9ff6149ca43524accc66ebfdd18d3092a74152b305303f2ca803a0b2b	\N	\N	\N	2015-04-18 19:18:58.546458	\N
85	1	1	4b76b7a54d833cb8a14e991a594eb74dd5234adda1912e964464d0e3c1bf22da	\N	\N	\N	2015-04-18 19:19:15.504912	\N
86	1	1	3131f24099d750be9a65f2e7c391dc3112e6f3d770e8535f826246be68fefd8f	\N	\N	\N	2015-04-18 19:20:44.768513	\N
87	1	1	b69d516d7c840f264b3ef35a6c5f2381f4cb481ea4e54809759b64e472acc0eb	\N	\N	\N	2015-04-18 19:20:50.180863	\N
88	1	1	165726d27f85a90cf55947650f7654c16ccb672806fb3774d8f471c33bea2f1a	\N	\N	\N	2015-04-18 19:23:08.351134	\N
89	1	1	edf239f8d22c9e527ce76d7c0afe84c8251795c58ae84e53bce3623f4815c9e5	\N	\N	\N	2015-04-18 19:26:42.143601	\N
90	7	1	0298bb074013892d40d0d9ac7413429faff997ebd8c13866581f069eb040ef98	\N	\N	\N	2015-04-18 19:26:51.772247	\N
91	1	1	1595ab3465f86847dfad9de9bfc14ed6bc6351aa5bd667ee6556bca6163f995f	\N	\N	\N	2015-04-18 21:36:38.300825	\N
92	1	1	545cd040f26616073bb1a3ab863d82fe2fb4628f1aad9c61096bd065db369718	\N	\N	\N	2015-04-18 22:15:13.170935	\N
93	1	1	db4b554ac59b0697b440532a7e444abad7190a80e8a0f42c83dbcdd9ba7461b5	\N	\N	\N	2015-04-18 23:02:25.829661	\N
94	1	1	ad94520cbfe3b2cdf31647ba45fca1b40031485bd89f12f35b93c92c11003a71	\N	\N	\N	2015-04-18 23:38:27.959895	\N
95	1	1	abfd304ea867a58b5cd3e11ab6a3ea0db22c9a3bfc5282480ec3466f98e621e7	\N	\N	\N	2015-04-18 23:43:06.554202	\N
96	1	1	0adeda13b0954a0664477c893402db0726c92723d51d3f8b921e62b55c37b33c	\N	\N	\N	2015-04-18 23:50:58.849481	\N
97	1	1	228df1fdd93e9e2803664690e96e194ccc6a1d1b0e0774c42c3a7b36604b02b3	\N	\N	\N	2015-04-19 02:35:05.647257	\N
98	1	1	9148e68f3ef93d24c095dc9d232e082870f69e92c5350ab4adc65e358078d111	\N	\N	\N	2015-04-19 02:40:00.195579	\N
99	1	1	de98f6f066388d0f4ace95eda46409a91e425ba3e85fbbc7a11bd2eed8b4d03b	\N	\N	\N	2015-04-19 08:46:18.033981	\N
100	1	1	3f1c4a4f261c788748d9bfc3a5fa99fed3ac6276c9ba364019c253571dbfd0f8	\N	\N	\N	2015-04-19 16:53:45.892417	\N
101	1	1	c9e0d511b68067a8897852e775b41ba3eb8c006411edaad4ae247b48b120a7b2	\N	\N	\N	2015-04-19 16:56:21.586583	\N
102	1	1	29bfe227bb489367ae8e205acf4c9fded8dc387d96be3aec901bea86254f98c2	\N	\N	\N	2015-04-19 16:56:47.387095	\N
103	1	1	fa9fd5b2095dc03f969e2d8f25bfd8793a1e43c7a96cd05e8b0794b147050bec	\N	\N	\N	2015-04-19 20:43:01.742214	\N
104	1	1	3418cde493a53a11bc8279b1613d282c340c68ebc62356ff431472a2918879b9	\N	\N	\N	2015-04-19 21:35:27.130217	\N
105	1	1	ed44d0c94853bed7b734e8c49a7917577cf3105ecfec90934dc613bb5fd9d744	\N	\N	\N	2015-04-20 01:04:44.9543	\N
106	1	1	81d46f52a6e56104b967c60e94b8f41aff1754e0aac2f86ead943ad74d73a462	\N	\N	\N	2015-04-20 01:07:43.433217	\N
107	1	1	296e9517fe68132864a38a4ba69bf299356295a51e5f455cca802992488f8084	\N	\N	\N	2015-04-20 01:32:30.16134	\N
108	1	1	3b45d9372793326758f06b4051937f1a71e3f97a29e2737aab4e270d6a4b5c26	\N	\N	\N	2015-04-20 01:40:54.09544	\N
109	1	1	1e21585ccba3414fb5e7a71717822c6fcda966595ee2346941700a17e1edfb70	\N	\N	\N	2015-04-20 03:31:52.824105	\N
110	1	1	5361b50770708c3aebff7e64ec4627c8b722d391f0bac4e4ad777ad6827e2238	\N	\N	\N	2015-04-20 04:12:54.881311	\N
111	1	1	85814b02c7620480e41ba6fd087f63792893a387ecba073f60eedfcaa12cb587	\N	\N	\N	2015-04-20 04:22:21.804952	\N
112	1	1	5e5708add5924e87c7440f536969f725e03201be21e60c239337371ad33285a9	\N	\N	\N	2015-04-20 04:39:22.532845	\N
113	1	1	69647813337b20b02b72c6755aae8af364ae8a184db161b339c59c8dc3c0d9d0	\N	\N	\N	2015-04-20 06:56:02.866689	\N
114	1	1	20526c79c3bf09e48571cdf8b23fe9be602e9b66609d0a8d8cd18af4ad2ff587	\N	\N	\N	2015-04-20 07:56:59.099218	\N
115	1	1	f0177832f7d29292d8f9334b3eab6c55cab054b1a125e31e11af823ea921bbb0	\N	\N	\N	2015-04-20 23:25:34.359489	\N
116	1	1	43ba8277c27ee8ce71e806c158e46347db23fa8f6826dc1a1feebcbc8aa1db2e	\N	\N	\N	2015-04-21 17:56:09.428647	\N
117	1	1	83c008f27ed7a184e537f6d51994d2ddb216554396131636db1093d3ea7587a1	\N	\N	\N	2015-04-21 18:40:35.178581	\N
118	1	1	1d4b7acbb61c9336a77314f79e46ba9a442e6f7451ce667f12f0c47fa8c14ebb	\N	\N	\N	2015-04-21 19:45:11.624734	\N
119	1	1	11159d334d571e43fd6265453c3d18172bf879cc2b950227e776f3746e5b1b8a	\N	\N	\N	2015-04-21 19:46:37.551038	\N
120	1	1	fa01164794b2a84a0746ba0f433f18d59ad2c08504c4ec39306367b076bae5dc	\N	\N	\N	2015-04-21 19:48:07.199315	\N
121	1	1	88a2c2b3225b0a65b86741112c0a316634c4c77f0518f2e894d1a867c62c5f87	\N	\N	\N	2015-04-21 19:53:33.304608	\N
122	1	1	5b4fdb5fabc8d2c9046ee50f7992b7ff3a869ba9f9d329c8bae931cb9404956d	\N	\N	\N	2015-04-21 19:59:24.822607	\N
123	1	1	24c9d5d1d91aebe6d6f32f348530a54459784a2d9d699bc8067816d30bdc0f94	\N	\N	\N	2015-04-21 20:20:02.510977	\N
124	1	1	45b9e029f938ddab9c4865103dd6f30cb81ef24703d3edea786e064573bc3aac	\N	\N	\N	2015-04-21 21:54:05.323849	\N
125	1	1	74e0e969dab3a6753e68a38f80487d4fb9ade872361ac723dcd97f3f13297075	\N	\N	\N	2015-04-21 22:00:13.389023	\N
126	8	1	70b5f721e8460287cee89e3d23813a2f2d832864afdf20a477e4770da6d10f91	\N	\N	\N	2015-04-21 22:38:26.177839	\N
127	9	1	ea7e0c920ca39f9cc41a76dc2f53c26c436a483f9ef43bc6e11dffd3dbe93734	\N	\N	\N	2015-04-21 22:39:56.11695	\N
128	1	1	447ba806958ba66e010dac96af7159554857ba613ea327a7edaf990d249bdaa1	\N	\N	\N	2015-04-21 22:40:30.426198	\N
129	10	1	acbe32078d06de99899de966e3b30dd755892931fd0c3f55404817805cd8a0b6	\N	\N	\N	2015-04-21 22:44:05.4778	\N
130	1	1	355b3b5501ada939add20a2aecb48536e6fa5b790afc4866e7aaabf2487598a3	\N	\N	\N	2015-04-21 22:46:49.770977	\N
131	1	1	4ecab0203ac455947b6274f3b8fb33540a6ab7ad613536bc43bbc95606bcc9c4	\N	\N	\N	2015-04-21 22:46:58.665428	\N
132	1	1	13fa1911b7497672bc4f21f4e220167327fe553f79f6e7e0562cad778e769099	\N	\N	\N	2015-04-21 23:19:17.196265	\N
133	1	1	f9769023402c9af9c39ba57f7d6c7f9db81c7dd882a0af6fef40cafe5a8217d6	\N	\N	\N	2015-04-21 23:20:28.52575	\N
134	1	1	9cc75434051542b91ccce6f162b6df097b236f5d3a25d45d370ac8be23c92955	\N	\N	\N	2015-04-21 23:24:51.144111	\N
135	11	1	6045cd54b641178e6e6efa486545cce0c58ed61b682e0f343ff2ea72d254a58a	\N	\N	\N	2015-04-21 23:29:50.368448	\N
136	1	1	05fbff8e45fd17c58f074a26d60a5a1f3b3edf223fbff6360befc1cc68c8e61f	\N	\N	\N	2015-04-21 23:30:49.924701	\N
137	11	1	7a5ab51d53e8c9732954f0df4372650c196fb68c21693768fa43791400146a97	\N	\N	\N	2015-04-21 23:31:09.163043	\N
138	1	1	c90a6aa9ed45ec242110be7b8db50fa7dbad01cc59e726c8910710648b7d0817	\N	\N	\N	2015-04-21 23:32:29.688789	\N
139	1	1	e8297a0f084c5b5c6039c557751f3a2adf6b4c076018b8fa24c1a35648bfed3d	\N	\N	\N	2015-04-22 04:34:38.318231	\N
140	1	1	9353565aed9be7926f6a07445891314c53310d1244915f86ab60d65b5f78104a	\N	\N	\N	2015-04-22 04:40:22.35951	\N
141	12	1	f3f6cb901c2816de6d81ea7d90032e456780326ced47635c825d403774a013a1	\N	\N	\N	2015-04-22 05:11:58.17038	\N
142	1	1	d04692f2fb46ce90fd9c4a4686baf122ce98685905721338f14ab26d9cf3acf4	\N	\N	\N	2015-04-22 05:14:28.037864	\N
143	13	1	aa808d9d86ecc165f4834adbbc11b7176f5b5ffcfdb62eceeae0be4e593b8523	\N	\N	\N	2015-04-22 06:57:57.784674	\N
144	1	1	f0abb5d9650b5fadec5e867ee3204b41e1af7c92dd83ec584739f79752b59450	\N	\N	\N	2015-04-22 07:09:06.207778	\N
145	1	1	0da889302a0a087f77fd313a69eec46c399638ce23901d54b0739785abd7126d	\N	\N	\N	2015-04-22 15:07:20.252957	\N
146	1	1	4c2675762e0001faf6609f1c027616f170372a9261ce34dd66439f8cf77066b4	\N	\N	\N	2015-04-22 15:37:08.929942	\N
147	1	1	167462441073467d46d27df9cf8f08ad255455583af18113c4d7a952e06da85c	\N	\N	\N	2015-04-22 15:39:02.012052	\N
148	1	1	bb9e12383c52c63f3c80d9779fc9d49dc026d57d7cd780b818d1b1259abbe258	\N	\N	\N	2015-04-22 15:39:57.101621	\N
149	1	1	b2d6aed0bba355cba8972b4e342588da7c08dc2f5a00e8dd3aa0257ab1be76ac	\N	\N	\N	2015-04-22 16:09:03.720689	\N
150	1	1	0814a7e65ada1eb62a93d43ccee4d744bd1f8dd113c271f3c64ed650b240fc0b	\N	\N	\N	2015-04-22 16:23:48.670319	\N
151	1	1	793f4815b9fb760ec53d1ca7d002fd58df18bfcb88aa51fec84426e8da27d284	\N	\N	\N	2015-04-22 16:44:41.97234	\N
152	14	1	ee4e8ea0ad2c465c8dcc30dbc42a98cf0f06bce410b9f8049faa0326eb725b5b	\N	\N	\N	2015-04-22 17:15:21.768539	\N
153	1	1	c1a8ba27aab5144d5f1c067d92e4af24726d65656ff29d5e355df640acd79a08	\N	\N	\N	2015-04-22 17:23:12.511883	\N
154	1	1	8bb1e845e9a2961ff48252bb20680ab9d9c4415e8d808263febc1b5c6a38adc2	\N	\N	\N	2015-04-22 17:54:17.296624	\N
155	1	1	a4f901f9332a9e961178d6fbe4863c4f029752bd643e72510c5994eb691312a9	\N	\N	\N	2015-04-22 19:53:27.217302	\N
156	1	1	bfce97fdf382293a8893f0c1584c30e4fc916fb8fa6bc242d27d28f6b74cb01d	\N	\N	\N	2015-04-22 21:34:08.209562	\N
157	1	1	3467a15f395fbf826ecf3edd281d8eea977f12eb3cee6fac95949eea22b82760	\N	\N	\N	2015-04-22 21:36:37.08407	\N
158	1	1	814560ddf07c2a6798636cda0894ca1016f93f9c94b7c3a4cb8f555f9a259bae	\N	\N	\N	2015-04-22 21:39:33.573718	\N
159	15	1	d687dbc6ef1f7f1dff9174d1b78f258129c2947ae6c59376026699712b4a9d5c	\N	\N	\N	2015-04-23 00:51:33.273474	\N
160	1	1	19f279ca5c317bb99e37f577232b5ab333f863fde97b2a41b1eee1a74d1a10dc	\N	\N	\N	2015-04-23 01:04:59.101659	\N
161	1	1	2e31519c33e8ec62bdf6f039156be54457a57c2f114b005af9d42f5b4a4c2b42	\N	\N	\N	2015-04-23 05:47:46.08497	\N
162	16	1	c9add0655ea02d4fccd5617cec09c88cbaa6c45ecd492ac1dc93c845862fecf0	\N	\N	\N	2015-04-23 06:32:48.515769	\N
163	1	1	b1f08c512cdfda57840485fd9558dad998abb32d3a7471eba01d3b1b749b9e73	\N	\N	\N	2015-04-23 14:48:10.086834	\N
164	17	1	f77da5b83aed0231a4d850bf6ed96b090e163b176b7920a5bf9090ec70a3c996	\N	\N	\N	2015-04-23 16:15:00.513399	\N
165	1	1	68b959c245e2241a118ee2ff93cd1021dce15a7f4e85ed572af5e09c7ec12f9f	\N	\N	\N	2015-04-23 16:23:45.405266	\N
166	1	1	5b86852e5b25c68dc9d4f72e86809b3738eb305489fd20489738baf52f7ab099	\N	\N	\N	2015-04-23 16:32:39.093389	\N
167	14	1	cee0e21bddf6040efe5232a4dc6ace33da7fa615d53c4bc8498cb8a91cd83529	\N	\N	\N	2015-04-23 16:33:34.180493	\N
168	1	1	0f0ddf7384941a376c04a72ac735772b745033e35837799b7e9d4fc13a8d6a81	\N	\N	\N	2015-04-23 16:37:06.232705	\N
169	1	1	f53a8c81baf696bf7c3c9f93f28f5339abdb18893b6aab8e46777f8ed6ad693a	\N	\N	\N	2015-04-23 16:37:48.816148	\N
170	18	1	06796a352a5b5acb5ba7e53ee5b930543afdc54f7c330475ef41ff541b4cd57f	\N	\N	\N	2015-04-23 16:47:51.929396	\N
171	1	1	f13c5a1dfdacaf65d1dc064a8c74eada5387964fbb45293e931c270aefdda3f9	\N	\N	\N	2015-04-23 16:48:10.267568	\N
172	1	1	af5615c3276763e19f9e9c4bd8ec2ef7d9e3598bc6656b96ed07a9b749a93c16	\N	\N	\N	2015-04-23 17:21:50.386709	\N
173	1	1	417ecf03556964da88c5f60f6705c8463cdd5b03e090f2646db62ca3fce7d564	\N	\N	\N	2015-04-23 17:23:08.669792	\N
174	1	1	81549e82d697e67ef21f062b5b307c79d8365571db79378ffee5cc7e32998b3f	\N	\N	\N	2015-04-23 17:24:10.746504	\N
175	1	1	7dceca93f3fb1d8d90fc0ae2f8874c7599bd23e0b095918a155135c17338ba07	\N	\N	\N	2015-04-23 17:27:28.203206	\N
176	1	1	cdf9be57084bc7c3d51d23e84b23334911e60df17f89b54374420c219cb77dc5	\N	\N	\N	2015-04-23 17:27:43.54242	\N
177	1	1	8b65d76edb11f205cd9f1f4cd20bc692fbb948213252947c223e249871b0ae09	\N	\N	\N	2015-04-23 17:33:31.618675	\N
178	1	1	dd98d11f4df915418b6c8358588d6ceeaf8ec6f7bef320ca6af0914f648f2b76	\N	\N	\N	2015-04-23 17:43:22.789245	\N
179	1	1	cea6f38be5738b8095b53975b1ebacf45f63f972bd1f60d23c8352ce742ed860	\N	\N	\N	2015-04-23 17:59:04.804283	\N
180	1	1	eb3392f604c43779a4b47bcf88d2052877fe78e141527b552d3177f2bcbc9276	\N	\N	\N	2015-04-23 18:33:01.705796	\N
181	1	1	614a81c64f65a444249b0ffcdc7060ce176f55d05b04e905cb9a29815ccc787d	\N	\N	\N	2015-04-23 20:49:44.129901	\N
182	1	1	38edbfb0159143001df9fe22eb5c6a9e7200174fa01b43b2b3e5ee7726153aa6	\N	\N	\N	2015-04-23 22:13:38.470445	\N
183	19	1	748d54fc35a51c8d663a3756bced052fdb0ee975e9fa52d1cb11a773add0596f	\N	\N	\N	2015-04-23 23:09:09.882306	\N
184	1	1	cd6d7253a3bbb5cf9d70b8daa892ec15efa40a71f70b1999c35b68e57eaaa90c	\N	\N	\N	2015-04-24 00:17:41.094505	\N
185	1	1	c916038a9ed727f035d4e0a1e2ffc1cd64c789f042fc54bbe766b81620537e6a	\N	\N	\N	2015-04-24 00:32:09.436189	\N
186	20	1	883c728ffcd1e621ec74dfa37a0a7a37958934ca054c7b7903415a2e659f8e6d	\N	\N	\N	2015-04-24 02:20:35.021988	\N
187	21	1	9fcf7868c5a120015cb7b16853dff1be1888f389146c71b83c84145e1c6cb39e	\N	\N	\N	2015-04-24 04:56:53.175368	\N
188	1	1	31c053662ca13f7391c83cf6f91586452699e88bc1407da3eb3b41e651f5a55b	\N	\N	\N	2015-04-24 06:02:12.079529	\N
189	1	1	61f70e0a487098817cab1474b81d710e23d0503e67ef27c9cfeaf0145af54047	\N	\N	\N	2015-04-24 06:21:44.391888	\N
190	1	1	94e80b3f955aa1091cf9df162eaa4a9b7ec2c122eec96a271f6de712045e6485	\N	\N	\N	2015-04-24 06:32:13.676221	\N
191	22	1	c03af25691bd8e38ca4def69ba657232cf6de97d55bd2bc0ade8f45b157009f4	\N	\N	\N	2015-04-24 11:15:36.164694	\N
192	22	1	df380955830dc106b69111b2672570246aa4bcee2aaa4437670b190dd2cf9df5	\N	\N	\N	2015-04-24 11:28:42.83471	\N
193	22	1	12d1d03679ae452886fe17ab10881639c05f1369bf791cf15a5a41143490c157	\N	\N	\N	2015-04-24 11:32:54.417861	\N
194	1	1	312749036b717cf7f5d11bf47a0c762ddfdd23e4aff4017e9117b8d173463a9b	\N	\N	\N	2015-04-24 16:51:33.700107	\N
195	22	1	888d3747eee2dbd156a98307274228a393f8fa46c915abd3cfb8680aefbc2111	\N	\N	\N	2015-04-24 17:07:42.099315	\N
196	1	1	a1f073c5fabe25ec5182641502784170a3110e04361573adda5653e2b77c6748	\N	\N	\N	2015-04-24 17:20:19.269344	\N
197	1	1	73755652974c3a1a061b48287ca64e0bc0534b0ec8b0f1a046a31c9fee7a1728	\N	\N	\N	2015-04-24 17:20:19.631893	\N
198	23	1	af532d96bdaf92ea70ee23be29d03e8883a29b192a872cbc2f1ba9442ac9e42c	\N	\N	\N	2015-04-24 18:37:34.04586	\N
199	24	1	68e94fd62574c188e6d435d9bfe15c4e0b80130ac8038a5bbec3dba6f65ad91a	\N	\N	\N	2015-04-24 18:43:04.649581	\N
200	1	1	3fdca6f2cb76593ffa3a0d8506940262dbcfe35198412cb09bbfa6cc366335e1	\N	\N	\N	2015-04-24 18:48:59.968662	\N
201	1	1	8103094479708c818dc8d92af453ead20ab194e0858657f8f36dde2d7efe8286	\N	\N	\N	2015-04-24 21:23:34.624364	\N
202	25	1	31861e95f973e4915e59e9891444281761f84b48ce0fe9fa4ddf7f4394393efb	\N	\N	\N	2015-04-24 21:30:41.180252	\N
203	1	1	f6b5478e31d0abcc75d5fc88b9de57b54c7a049a8993c3c7606e33a15edbbee1	\N	\N	\N	2015-04-24 21:55:26.068209	\N
204	1	1	e73b50df6a6e2c02122b48bfc51f16514aff276047f888b0b93b2ae533ed271a	\N	\N	\N	2015-04-25 00:03:19.291233	\N
205	26	1	12a888c13a0273b58734cad46b157c7ebaad7bc809f3508480f804c76e83abf5	\N	\N	\N	2015-04-25 00:37:12.663709	\N
206	26	1	bd7a6ca5b2af09b1f6529cf192ad83713fe24ccb8ede3e8ecd964ff655511a11	\N	\N	\N	2015-04-25 00:42:59.629926	\N
207	1	1	0b493c3cc22bb4e3a866bddfa850bc94c828da1f7b987a9ce0b2d9057266f1cd	\N	\N	\N	2015-04-25 02:44:54.05087	\N
208	1	1	65e84784d4fd1b48b29a988b4b6026071ccb29a1db95877cce8948e49f5ddfe0	\N	\N	\N	2015-04-25 03:06:38.332904	\N
209	27	1	b92033f36396cf7ab921802d6c4559fb6090eb2420aae3e03732f75c26e2da12	\N	\N	\N	2015-04-25 05:15:51.518605	\N
210	1	1	1be3555419e4ea1136112e3bc7cb3ccf4d794e5b1b4a12f7b2a9acc32ee795b5	\N	\N	\N	2015-04-25 06:06:24.653954	\N
211	1	1	9e5bcf16c3b8476ba9f1b284aa3e593bf94a19c0361df3518ca49b4837a13162	\N	\N	\N	2015-04-25 17:56:34.243916	\N
212	1	1	9fd6f9e7d79cf9fa4c1bc7ba67fc9b24c63c9ac4d2897fb56399c84d8e4d09f6	\N	\N	\N	2015-04-25 23:37:26.435213	\N
213	1	1	e7bb6a8ce84913bbd4973f10ceead1c4f6588d0a1c8743fffb54b9948cae5099	\N	\N	\N	2015-04-26 21:09:51.677927	\N
214	1	1	ee972e85b00c45be8fa6d5ab697e628be0a22183497dd6b72fb1af0a5f67c978	\N	\N	\N	2015-04-26 21:10:03.267423	\N
215	1	1	2139cbecea3381f18f91c663d5976503257cdaf9a4f10dd36d38e9d886afbeb4	\N	\N	\N	2015-04-27 07:12:23.459255	\N
216	1	1	210d758fadfe075d2ccc759f569697480d514e1c1eee7ab8202b2c02fba793d1	\N	\N	\N	2015-04-27 07:36:29.858724	\N
217	1	1	de2ca00b51975c1ab62a464e0cae7bafc5ca24789476902ea730680f325c98e7	\N	\N	\N	2015-04-27 07:38:01.753302	\N
218	1	1	1bf2a2c47aa862e7d6cef836c42b36541bc31cad6fe566d38812355fe79ebd3c	\N	\N	\N	2015-04-27 11:45:29.096135	\N
219	1	1	dc5bef09d4740e491b4076defd3a2944612e6f2aa32eece1cac725c31144ec90	\N	\N	\N	2015-04-27 15:39:35.655257	\N
220	1	1	43376b567d700dd80d31e8808d099fe3f559cd2274da03e6cd93823c2cb34b4c	\N	\N	\N	2015-04-27 15:44:31.559876	\N
221	1	1	e6988b7d6491fb686ff01fd607a397e994cc7128b1bebc6ea3394c734594391b	\N	\N	\N	2015-04-27 15:46:49.59876	\N
222	1	1	d3e5e0b74056800a652f94f8e5c7d6fa1f393aad19b90c87b4f8cb2df5fa75af	\N	\N	\N	2015-04-27 16:56:42.527666	\N
223	1	1	5758d949af4241830aac7cc094767cd832aa7533d2836ab328644466a561ad65	\N	\N	\N	2015-04-27 18:40:38.664874	\N
224	1	1	0462daf734f5ab6dff4124fa38c068652d7a39584d6929db25d4fe5f45163fda	\N	\N	\N	2015-04-27 19:29:57.815533	\N
225	1	1	42fc242e1d9d5f0d1ba80f337699d0d0a72b54dc0b4ad478d45735a892938d97	\N	\N	\N	2015-04-27 19:41:02.991488	\N
226	1	1	1dcfc73ef5a3cb45670fc5e0fc02cbce8052bb0ff8acd6226aa4f515e0419283	\N	\N	\N	2015-04-27 19:44:45.953332	\N
227	1	1	b7997176ba60ea8f65ca9ec0d36c2b7490e63709f99fb51efd0dfc34df81050c	\N	\N	\N	2015-04-27 19:47:48.543959	\N
228	1	1	28f5582cca54087437e2ffec74f50adcb4ee2c18ba3e21633ebca07b1d430b8b	\N	\N	\N	2015-04-27 20:00:25.404407	\N
229	1	1	e00fdfae2c28c26b8edc5b7cfa73a8ba473a9ceaedc84bc0eafc9a87ce9eb19b	\N	\N	\N	2015-04-27 20:37:47.624133	\N
230	1	1	b9daa78b177953a1997fb04074afadd4de313ed663cb236d69aef8ea9ec37cac	\N	\N	\N	2015-04-27 22:02:07.1985	\N
231	1	1	03f0febd02c65f293599baedffd8cd4eaf3fe0b52050c456e5a071ddcc9d35fe	\N	\N	\N	2015-04-27 23:07:04.88604	\N
232	1	1	cba70f29b25fbd6982529582966fa86c33772a73e3cb3a6fe2cacc966e7dc905	\N	\N	\N	2015-04-27 23:08:13.453168	\N
233	1	1	ca1e77bb4caa73584b3445a9e2c73d3735078bd2f73c53f92dd496482479e411	\N	\N	\N	2015-04-28 05:20:35.545816	\N
234	1	1	3c013f543f19bbb0a66744f29eae832e8663180b179848e4c38079b007abe569	\N	\N	\N	2015-04-28 15:31:24.81218	\N
235	1	1	ac09958af808679bf787ed4ad01a3d13aa74e78e54166426ec92ae140283339e	\N	\N	\N	2015-04-28 16:25:39.825805	\N
236	1	1	60318dde87a244133f76e7cd8006b97fcc48ea37e0408ea25d7b6cb55f944a34	\N	\N	\N	2015-04-28 16:38:48.029321	\N
237	1	1	3a6638daa0b06dde7a27472800398ef8610d3687e16b5829c2db325b51e5a967	\N	\N	\N	2015-04-28 16:42:16.732164	\N
238	1	1	c11e819eec322541a353e948234c14f337af4d7385cd8d9999e4592129c08491	\N	\N	\N	2015-04-28 16:45:07.417469	\N
239	1	1	11b86b9e5f09b9c8961c2981d54f4b5e4d84d7bf61b0f5a1471879dc77ce7db1	\N	\N	\N	2015-04-28 21:04:12.926739	\N
240	1	1	5c330f0a2cff3818e8080ea1df804b23b9eedbc5e44684a96e9144e7386713b4	\N	\N	\N	2015-04-29 15:59:49.530793	\N
241	1	1	206c6c4b7c1bdae29a895795074d3106a9ca1e054631bf9552e2a9e2236547de	\N	\N	\N	2015-04-29 16:40:19.509633	\N
242	1	1	6613b0574767368e7d271feb18cb3c92ae42e5b389bc600c4711dec472803ad8	\N	\N	\N	2015-04-29 19:16:40.317232	\N
243	22	1	d9adadabf35c8094c253ae292916b891f73ada34e6fc7782c7490068af3d9e85	\N	\N	\N	2015-04-29 19:19:37.441061	\N
244	1	1	7238897442b41cf40fddb05cbc46b5ccc279072a0eacf0ff6ef4482d0f340ff6	\N	\N	\N	2015-04-29 19:20:48.199448	\N
245	1	1	183f786243a0334aa4cf2b96d2af825539ea1b3e2e1ae2bbebcf7a9ea4ed07d8	\N	\N	\N	2015-04-30 01:49:22.361448	\N
246	1	1	9ca2e7eb2950a84d4220a1b746cf67c9d248e426d1eb9582b1115f37cade67e2	\N	\N	\N	2015-04-30 06:19:19.580616	\N
247	1	1	0559564af21988dbae5358bb977331cf6390234b9ea2d7a26e8ca9f0af63bdff	\N	\N	\N	2015-04-30 06:25:45.924438	\N
248	1	1	a3d29f65ce3e96258c4181c83f22008271d105eb56e7d1ed317c0ebbce3d2f54	\N	\N	\N	2015-04-30 06:47:01.901988	\N
249	1	1	8dac32562259e989c67f6c55d0dcad2113e9fe0e40ae6c390f4425c7d4f35762	\N	\N	\N	2015-04-30 14:53:34.5437	\N
250	1	1	1ffcdf8cb12806e8ccf0ca7ac8cd1707c600e7c58a64be618612141a8073513b	\N	\N	\N	2015-04-30 14:59:25.788908	\N
251	22	1	babcc768203a24a927085da09b8ca03f6710317cfb9a227e7f369bb92847028f	\N	\N	\N	2015-04-30 15:00:46.515123	\N
252	1	1	2af764f58c0d6d15cd2eec6fdd6199cbdb3e5d5ee2344669b32468cf9c4e6cc3	\N	\N	\N	2015-04-30 15:07:53.845459	\N
253	1	1	6e5295cbc909ff1dc3a58ed7f55368c00f3f66c60c11339c5994e903399d7802	\N	\N	\N	2015-04-30 22:04:04.42587	\N
254	1	1	6182ca6aa0cf3fc812d923e6f60413fd12b4fb732cb393fd55bb767f85ab187a	\N	\N	\N	2015-05-02 03:18:23.789	\N
255	1	1	cbde21a8be693021a5faed333c51a142dc95b49093d4cc5826bc13fb206ab6b5	\N	\N	\N	2015-05-05 16:13:00.872219	\N
256	1	1	3d583f044ec7e6b8e2c3bd27742ba79756e13c926bcba3c89f436ed08d83711e	\N	\N	\N	2015-05-05 18:28:10.765994	\N
257	1	1	db0acb6675bfe9866d806aa8505afc801b10dfbeb998e6e6721f854d3e067f09	\N	\N	\N	2015-05-07 05:45:04.29349	\N
258	1	1	061e457dab2a952c10cea1a988a8e6f98a1251e1333160ebb23660f1cc7597d4	\N	\N	\N	2015-05-07 13:22:21.351706	\N
259	1	1	3a4c309507aeb0f5da5f1db93b280ebf447fde72a6f2e55fb56c82162222b18e	\N	\N	\N	2015-05-07 15:50:38.947961	\N
260	1	1	f0b63eee51265d2ee9abdb6c19510b2dda47ee7361bf63a1e296d89a8c95e1ab	\N	\N	\N	2015-05-07 17:46:11.793254	\N
261	1	1	8ac53b6d7247636b57ec7f67340a74a3c08918319722ce0e38b4d92c4742afe9	\N	\N	\N	2015-05-08 16:54:55.14625	\N
262	28	1	835d42182c4944a51cadb900de202d60300f4833c246c8aece62124011416efc	\N	\N	\N	2015-05-08 20:42:51.323546	\N
263	1	1	1460ba265a633d2f8b7ee693502e8fbb855b9c129d3a7a24dfb2acafa665ea0e	\N	\N	\N	2015-05-10 01:03:52.854646	\N
264	28	1	eb0e3a566b2abc872a485a44dee78b846808556e838571eca3465548d6ff5ac0	\N	\N	\N	2015-05-12 18:27:08.838564	\N
265	1	1	f80a8cc05ac8de1ec46f4c7483c8ca58829ec3e25d18ee9514d52f71fb4fe275	\N	\N	\N	2015-05-13 17:41:38.868403	\N
266	1	1	b7ec35f933891156fa3c8b1bc6b0746966f0f7ae2e51289ab7208fd9aebec4e5	\N	\N	\N	2015-05-13 20:37:30.596732	\N
267	22	1	1e09971dd8c7b88930df591d47a075b880cdb3187c170b4f91eae6dcdc29e267	\N	\N	\N	2015-05-14 13:56:13.9942	\N
\.


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_access_tokens_id_seq', 267, true);


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY oauth_applications (id, name, uid, secret, redirect_uri, scopes, created_at, updated_at) FROM stdin;
1	echeckit	549f0dc1d9e2b8208297d45155166b87fdda27e8ec646dfc5d3706ec51d6c6c3	6472fc4eb0af0e26ddc60b85f6f37ee5b4d44cea63adba3512877ab97bb587d5	https://127.0.0.1		2015-04-15 21:53:10.922465	2015-04-15 21:53:10.922465
\.


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('oauth_applications_id_seq', 1, true);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY organizations (id, name, created_at, updated_at) FROM stdin;
12	eCheckit	2015-04-23 16:47:51.930971	2015-04-23 16:47:51.930971
13	eCheckit	2015-04-23 23:09:09.883785	2015-04-23 23:09:09.883785
14	eCheckit	2015-04-24 02:20:35.023793	2015-04-24 02:20:35.023793
15	eCheckit	2015-04-24 04:56:53.177096	2015-04-24 04:56:53.177096
16	eCheckit	2015-04-24 11:15:36.166442	2015-04-24 11:15:36.166442
17	eCheckit	2015-04-24 18:37:34.047292	2015-04-24 18:37:34.047292
18	eCheckit	2015-04-24 18:43:04.650921	2015-04-24 18:43:04.650921
19	eCheckit	2015-04-24 21:30:41.185737	2015-04-24 21:30:41.185737
20	eCheckit	2015-04-25 00:37:12.665028	2015-04-25 00:37:12.665028
21	eCheckit	2015-04-25 05:15:51.520264	2015-04-25 05:15:51.520264
22	eCheckit	2015-05-08 20:42:51.32487	2015-05-08 20:42:51.32487
1	Koandina	2015-04-15 21:53:10.935437	2015-04-15 21:53:10.935437
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('organizations_id_seq', 22, true);


--
-- Data for Name: pictures; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY pictures (id, url, report_id, created_at, updated_at, comment) FROM stdin;
189	http://d21zid65ggdxzg.cloudfront.net/fdc5edc5f684631722bec2a2d33c180a.jpg	124	2015-04-29 19:18:51.55465	2015-04-29 19:18:51.55465	Hello
64	http://d21zid65ggdxzg.cloudfront.net/970763d6-5832-4b92-94f2-90c66907f15f.jpg	35	2015-04-17 21:06:26.852655	2015-04-17 21:06:26.852655	\N
65	http://d21zid65ggdxzg.cloudfront.net/997677cf-23c1-4545-9c8e-e6ee7a080df0.jpg	35	2015-04-17 21:06:26.853853	2015-04-17 21:06:26.853853	\N
66	http://d21zid65ggdxzg.cloudfront.net/724e50b9-bf19-4fbf-bd87-2f69e55448c7.jpg	36	2015-04-17 21:07:18.887385	2015-04-17 21:07:18.887385	\N
67	http://d21zid65ggdxzg.cloudfront.net/408af0cb-58ec-4129-ba99-c543dc8c8b8d.jpg	36	2015-04-17 21:07:18.888603	2015-04-17 21:07:18.888603	\N
68	http://d21zid65ggdxzg.cloudfront.net/185d93c1-339a-4079-8987-e1def8755042.jpg	36	2015-04-17 21:07:18.889726	2015-04-17 21:07:18.889726	\N
69	http://d21zid65ggdxzg.cloudfront.net/53509370-9812-4508-8d29-f03586ad4397.jpg	37	2015-04-17 22:04:09.973218	2015-04-17 22:04:09.973218	\N
70	http://d21zid65ggdxzg.cloudfront.net/9b6bbe50-41ac-4b81-9cf3-3bc5cd8dfe46.jpg	37	2015-04-17 22:04:09.974361	2015-04-17 22:04:09.974361	\N
71	http://d21zid65ggdxzg.cloudfront.net/0ed603f6-8773-4e3c-8f5e-e0f0469cd8bb.jpg	37	2015-04-17 22:04:09.975437	2015-04-17 22:04:09.975437	\N
72	http://d21zid65ggdxzg.cloudfront.net/667651b4-e3a3-4701-bf4e-3661f04e415a.jpg	37	2015-04-17 22:04:09.976495	2015-04-17 22:04:09.976495	\N
190	http://d21zid65ggdxzg.cloudfront.net/eb8c30b813dd57aab8028635d0d97f3a.jpg	126	2015-04-30 00:41:05.565406	2015-04-30 00:41:05.565406	Mal estacionado
191	http://d21zid65ggdxzg.cloudfront.net/109fc0940b67d6f6da36c43dc6952293.jpg	127	2015-04-30 14:57:09.02479	2015-04-30 14:57:09.02479	Acá debe de estar el cooler
192	http://d21zid65ggdxzg.cloudfront.net/0ef82a93a63779b8c8bbba7a63a3678e.jpg	128	2015-05-05 05:14:54.661646	2015-05-05 05:14:54.661646	Teclado 
193	http://d21zid65ggdxzg.cloudfront.net/290dd6d62c62a0a01494bbd45143d235.jpg	130	2015-05-05 23:46:06.083542	2015-05-05 23:46:06.083542	Djjd
194	http://d21zid65ggdxzg.cloudfront.net/e3dcc3db4ed30530046fe0b6a5fb8da7.jpg	131	2015-05-11 13:42:02.219716	2015-05-11 13:42:02.219716	prueba! \nmuy buen equilibrio de productos\n
\.


--
-- Name: pictures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('pictures_id_seq', 194, true);


--
-- Data for Name: report_field_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY report_field_types (id, name, workspace_id, created_at, updated_at, widget_id, translations, data) FROM stdin;
1	reason	1	2015-04-25 18:13:16.765284	2015-04-26 20:32:16.795684	1	{"es":"Motivo","en":"Reason"}	{"hint":{"es":"Seleccione un motivo","en":"Select a reason"},"items":[{"image":"/images/reports/reason_congratulations.png","title":"Felicitaciones"},{"image":"/images/reports/reason_feedback.png","title":"Oportunidades de Mejora"},{"image":"/images/reports/reason_client.png","title":"Cliente Potencial"}]}
2	channel	1	2015-04-25 18:13:38.652849	2015-04-28 15:27:35.309337	1	{"es":"Canal","en":"Channel"}	{"hint":{"es":"Seleccione un canal","en":"Select a channel"},"items":[{"image":"/images/reports/channel_traditional.png","title":"Tradicional"},{"image":"/images/reports/channel_market.png","title":"Supermercado","subitems":["Lider","Jumbo","Unimarc","Santa Isabel"]},{"image":"/images/reports/channel_restaurant.png","title":"Restaurant"},{"image":"/images/reports/channel_others.png","title":"Otros"}]}
\.


--
-- Name: report_field_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('report_field_types_id_seq', 2, true);


--
-- Data for Name: report_fields; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY report_fields (id, report_id, report_field_type_id, created_at, updated_at, value) FROM stdin;
19	122	1	2015-04-28 16:45:21.147874	2015-04-28 16:45:21.147874	{"image":"/images/reports/reason_client.png","title":"Cliente Potencial","subitem":null}
20	122	2	2015-04-28 16:45:21.149426	2015-04-28 16:45:21.149426	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Jumbo"}
21	123	1	2015-04-29 16:02:14.411384	2015-04-29 16:02:14.411384	{"image":"/images/reports/reason_client.png","title":"Cliente Potencial","subitem":null}
22	123	2	2015-04-29 16:02:14.413216	2015-04-29 16:02:14.413216	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Unimarc"}
23	124	1	2015-04-29 19:18:51.556249	2015-04-29 19:18:51.556249	{"image":"/images/reports/reason_congratulations.png","title":"Felicitaciones","subitem":null}
24	124	2	2015-04-29 19:18:51.558049	2015-04-29 19:18:51.558049	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Unimarc"}
25	125	1	2015-04-29 19:25:13.06428	2015-04-29 19:25:13.06428	{"image":"/images/reports/reason_client.png","title":"Cliente Potencial","subitem":null}
26	125	2	2015-04-29 19:25:13.065691	2015-04-29 19:25:13.065691	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Unimarc"}
27	127	1	2015-04-30 14:57:09.026288	2015-04-30 14:57:09.026288	{"image":"/images/reports/reason_client.png","title":"Cliente Potencial","subitem":null}
28	127	2	2015-04-30 14:57:09.028155	2015-04-30 14:57:09.028155	{"image":"/images/reports/channel_traditional.png","title":"Tradicional","subitem":null}
29	128	1	2015-05-05 05:14:54.663256	2015-05-05 05:14:54.663256	{"image":"/images/reports/reason_feedback.png","title":"Oportunidades de Mejora","subitem":null}
30	128	2	2015-05-05 05:14:54.665067	2015-05-05 05:14:54.665067	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Jumbo"}
31	129	1	2015-05-05 16:15:34.022675	2015-05-05 16:15:34.022675	{"image":"/images/reports/reason_client.png","title":"Cliente Potencial","subitem":null}
32	129	2	2015-05-05 16:15:34.024244	2015-05-05 16:15:34.024244	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Jumbo"}
33	130	1	2015-05-05 23:46:06.0876	2015-05-05 23:46:06.0876	{"image":"/images/reports/reason_congratulations.png","title":"Felicitaciones","subitem":null}
34	130	2	2015-05-05 23:46:06.090109	2015-05-05 23:46:06.090109	{"image":"/images/reports/channel_market.png","title":"Supermercado","subitem":"Unimarc"}
\.


--
-- Name: report_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('report_fields_id_seq', 34, true);


--
-- Data for Name: report_states; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY report_states (id, name, workspace_id, created_at, updated_at) FROM stdin;
1	Creado	1	2015-04-15 21:53:11.203855	2015-04-15 21:53:11.203855
2	Asignado	1	2015-04-15 21:53:11.207853	2015-04-15 21:53:11.207853
3	Creado	12	2015-04-23 16:15:00.524484	2015-04-23 16:15:00.524484
4	Asignado	12	2015-04-23 16:15:00.526849	2015-04-23 16:15:00.526849
5	Creado	13	2015-04-23 16:47:51.936062	2015-04-23 16:47:51.936062
6	Asignado	13	2015-04-23 16:47:51.938177	2015-04-23 16:47:51.938177
7	Creado	14	2015-04-23 23:09:09.888928	2015-04-23 23:09:09.888928
8	Asignado	14	2015-04-23 23:09:09.891271	2015-04-23 23:09:09.891271
9	Creado	15	2015-04-24 02:20:35.028896	2015-04-24 02:20:35.028896
10	Asignado	15	2015-04-24 02:20:35.031224	2015-04-24 02:20:35.031224
11	Creado	16	2015-04-24 04:56:53.182197	2015-04-24 04:56:53.182197
12	Asignado	16	2015-04-24 04:56:53.184336	2015-04-24 04:56:53.184336
13	Creado	17	2015-04-24 11:15:36.171447	2015-04-24 11:15:36.171447
14	Asignado	17	2015-04-24 11:15:36.173649	2015-04-24 11:15:36.173649
15	Creado	18	2015-04-24 18:37:34.05233	2015-04-24 18:37:34.05233
16	Asignado	18	2015-04-24 18:37:34.054526	2015-04-24 18:37:34.054526
17	Creado	19	2015-04-24 18:43:04.654404	2015-04-24 18:43:04.654404
18	Asignado	19	2015-04-24 18:43:04.65631	2015-04-24 18:43:04.65631
19	Creado	20	2015-04-24 21:30:41.203908	2015-04-24 21:30:41.203908
20	Asignado	20	2015-04-24 21:30:41.206159	2015-04-24 21:30:41.206159
21	Creado	21	2015-04-25 00:37:12.670043	2015-04-25 00:37:12.670043
22	Asignado	21	2015-04-25 00:37:12.672362	2015-04-25 00:37:12.672362
23	Creado	22	2015-04-25 05:15:51.529855	2015-04-25 05:15:51.529855
24	Asignado	22	2015-04-25 05:15:51.532087	2015-04-25 05:15:51.532087
25	Creado	23	2015-05-08 20:42:51.332255	2015-05-08 20:42:51.332255
26	Asignado	23	2015-05-08 20:42:51.335582	2015-05-08 20:42:51.335582
\.


--
-- Name: report_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('report_states_id_seq', 26, true);


--
-- Data for Name: report_types; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY report_types (id, description, organization_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: report_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('report_types_id_seq', 1, false);


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY reports (id, creator_id, assigned_user_id, created_at, updated_at, report_state_id, workspace_id, venue_id, title, address, city, region, commune, country, longitude, latitude, reference, comment) FROM stdin;
36	1	1	2015-04-17 21:07:18.885095	2015-04-28 15:59:48.606107	1	1	\N	Lider	Luis Montaner 457	\N	Metropolitana	Providencia	\N	-70.6258677999999946	-33.4428000999999995	\N	
37	1	1	2015-04-17 22:04:09.970795	2015-04-28 15:59:54.557747	1	1	\N	irarrazaval	Santa Elena 1071	\N	Metropolitana	Santiago	\N	-70.6316680399999939	-33.4551311399999989	irarrazaval	No hay nada 
122	1	\N	2015-04-28 16:45:21.145268	2015-04-28 16:45:21.145268	1	1	\N	ns	Manuel Antonio Matta 201-241	\N	Metropolitana de Santiago	Santiago	\N	-70.6324831999999958	-33.455904799999999	\N	
123	1	\N	2015-04-29 16:02:14.407811	2015-04-29 16:02:14.407811	1	1	\N	cjvkk	Luis Montaner 451-541	\N	Metropolitana de Santiago	Providencia	\N	-70.6259395999999953	-33.4428454000000031	\N	
124	1	\N	2015-04-29 19:18:51.551039	2015-04-29 19:18:51.551039	1	1	\N	Ji	Luis Montaner 451-541	\N	Metropolitana de Santiago	Providencia	\N	-70.6258087158203125	-33.4428024291992188	\N	Hjkjk
125	1	\N	2015-04-29 19:25:13.061948	2015-04-29 19:25:13.061948	1	1	\N	Han	Italia 850-878	\N	Metropolitana de Santiago	Providencia	\N	-70.6259918212890625	-33.4426918029785156	\N	
126	19	\N	2015-04-30 00:41:05.560979	2015-04-30 00:41:05.560979	7	14	\N	Nada	La Ciénaga 12239-12335	\N	Metropolitana de Santiago	Lo Barnechea	\N	-70.5240097045898438	-33.3323554992675781	Esquina	Nada
127	1	\N	2015-04-30 14:57:09.021414	2015-04-30 14:57:09.021414	1	1	\N	Vender vendimatica	Italia 987-1291	\N	Metropolitana de Santiago	Providencia	\N	-70.6255645751953125	-33.4446563720703125	Es en la puerta negra	Hablar con Alejandra
128	1	\N	2015-05-05 05:14:54.658133	2015-05-05 05:14:54.658133	1	1	\N	hj	Manuel Antonio Matta 201-241	\N	Metropolitana de Santiago	Santiago	\N	-70.632470799999993	-33.4558912999999976	vv	Hjk
129	1	\N	2015-05-05 16:15:34.020229	2015-05-05 16:15:34.020229	1	1	\N	Freyre	Luis Montaner 451-541	\N	Metropolitana de Santiago	Providencia	\N	-70.6257848999999993	-33.4428297999999984	\N	Yorke
130	1	\N	2015-05-05 23:46:06.076653	2015-05-05 23:46:06.076653	1	1	\N	jfnd	Manuel Antonio Matta 201-241	\N	Metropolitana de Santiago	Santiago	\N	-70.6325982999999979	-33.4558925999999985	\N	
131	28	\N	2015-05-11 13:42:02.216258	2015-05-11 13:42:02.216258	25	23	\N	carlos valdovinos	Alcalde Carlos Valdovinos 500-556	\N	Metropolitana de Santiago	San Joaquín	\N	-70.6365263999999939	-33.4825538999999992	carloa valdovinos 560	jsbdkdn
35	1	1	2015-04-17 21:06:26.850106	2015-04-21 23:18:55.570264	1	1	\N	Italia	Luis Montaner 457	\N	Metropolitana	Providencia	\N	-70.6258942000000047	-33.4427907999999974	Italia	Comentario
\.


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('reports_id_seq', 131, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY roles (id, name, resource_id, resource_type, created_at, updated_at) FROM stdin;
1	user	1	Workspace	2015-04-15 21:53:11.151864	2015-04-15 21:53:11.151864
2	user	2	Workspace	2015-04-15 21:53:11.180228	2015-04-15 21:53:11.180228
3	user	3	Workspace	2015-04-21 22:38:26.198066	2015-04-21 22:38:26.198066
4	user	4	Workspace	2015-04-21 22:39:56.122178	2015-04-21 22:39:56.122178
5	user	5	Workspace	2015-04-21 22:44:05.483317	2015-04-21 22:44:05.483317
6	user	6	Workspace	2015-04-21 23:29:50.374618	2015-04-21 23:29:50.374618
7	user	7	Workspace	2015-04-22 05:11:58.175634	2015-04-22 05:11:58.175634
8	user	8	Workspace	2015-04-22 06:57:57.789857	2015-04-22 06:57:57.789857
9	user	9	Workspace	2015-04-22 17:15:21.774565	2015-04-22 17:15:21.774565
10	user	10	Workspace	2015-04-23 00:51:33.280175	2015-04-23 00:51:33.280175
11	user	11	Workspace	2015-04-23 06:32:48.520862	2015-04-23 06:32:48.520862
12	user	12	Workspace	2015-04-23 16:15:00.529853	2015-04-23 16:15:00.529853
13	user	13	Workspace	2015-04-23 16:47:51.941136	2015-04-23 16:47:51.941136
14	user	14	Workspace	2015-04-23 23:09:09.894131	2015-04-23 23:09:09.894131
15	user	15	Workspace	2015-04-24 02:20:35.033962	2015-04-24 02:20:35.033962
16	user	16	Workspace	2015-04-24 04:56:53.187133	2015-04-24 04:56:53.187133
17	user	17	Workspace	2015-04-24 11:15:36.17639	2015-04-24 11:15:36.17639
18	user	18	Workspace	2015-04-24 18:37:34.057281	2015-04-24 18:37:34.057281
19	user	19	Workspace	2015-04-24 18:43:04.658564	2015-04-24 18:43:04.658564
20	user	20	Workspace	2015-04-24 21:30:41.213614	2015-04-24 21:30:41.213614
21	user	21	Workspace	2015-04-25 00:37:12.675171	2015-04-25 00:37:12.675171
22	user	22	Workspace	2015-04-25 05:15:51.534783	2015-04-25 05:15:51.534783
23	user	23	Workspace	2015-05-08 20:42:51.338256	2015-05-08 20:42:51.338256
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('roles_id_seq', 23, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY schema_migrations (version) FROM stdin;
20150406190812
20150407193847
20150407194155
20150407210459
20150409000424
20150410162346
20150410162650
20150415203622
20150416000131
20150416002604
20150417204212
20150421210644
20150421220226
20150421220941
20150421223254
20150423190513
20150424064548
20150424212653
20150424212818
20150424213346
20150425180758
20150425183636
20150426201043
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, first_name, last_name, picture, is_demo) FROM stdin;
25	banoh@odoziw.io	$2a$10$LC0WuqXs6GykKtr3NdHgPOAxzlOXca39KDLYsh2b2pWpVUIsevC7K	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 21:30:41.161189	2015-04-24 21:30:41.161189	Wayne	Boone	http://d21zid65ggdxzg.cloudfront.net/f286cecba98a7c11a42d1b55d8a7fac9.jpg	t
18	goge@nuvjuppe.gov	$2a$10$9HElwtmY40aAFPF2Fh7fI.LceNbnAvu0UyU2qye33kFhfXjQIXt8.	\N	\N	\N	0	\N	\N	\N	\N	2015-04-23 16:47:51.919242	2015-04-23 16:47:51.919242	Pauline	McDaniel	\N	t
26	laura.guanco@gmail.com	$2a$10$Wl8cnWXSxxM5GfCXz1J6Ju12meLmd02h.qRLQqf9RWtcEUgMVqpFq	\N	\N	\N	0	\N	\N	\N	\N	2015-04-25 00:37:12.660636	2015-04-25 00:42:00.385149	Laura	G	http://d21zid65ggdxzg.cloudfront.net/f8aed7feaee4e142c5807249ecfd1e71.jpg	f
27	maawdi@befohto.edu	$2a$10$zwkgcNGNXo2NvD3cDzHpaeVdZJoJtOA.7DWA6aRPE8nZhU/KAFNA6	\N	\N	\N	0	\N	\N	\N	\N	2015-04-25 05:15:51.508413	2015-04-25 05:15:51.508413	Walter	Chavez	http://d21zid65ggdxzg.cloudfront.net/f286cecba98a7c11a42d1b55d8a7fac9.jpg	t
19	alepalmatorres@gmail.com	$2a$10$GI7k7ce5AOxiw6LF5B5YJ.A58.gY3MK7YzhMooaApLU1NE1.Tl..u	\N	\N	\N	0	\N	\N	\N	\N	2015-04-23 23:09:09.879098	2015-04-23 23:09:09.879098	Alejandro	Palma	\N	f
20	alujan@gmail.com	$2a$10$woymPGm/tszR0lAvTe2Mw.L60lSh5vMfbh7HVU3KVYgwLhfXoJ/mW	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 02:20:35.011782	2015-04-24 02:20:35.011782	Andrey	Lujan	\N	f
21	oke@tenelo.org	$2a$10$KTFsx220d.IdHlwnonJGdumuXuEBiDoDj3SspCwqLDpyycwAabRYa	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 04:56:53.164525	2015-04-24 04:57:10.058151	Lilly	Berry	http://d21zid65ggdxzg.cloudfront.net/cb52156948ed90e8777311d2319ccd3f.jpg	t
22	andreylujan@gmail.com	$2a$10$xPlx4yF18JrRmTjWAs8P1.r6Xb8gnDpjQMBmYbQhkbWW5Qp11vswi	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 11:15:36.154592	2015-04-24 11:16:45.126513	Andrey	Luján	http://d21zid65ggdxzg.cloudfront.net/c27bb223f09a73c88fdadc05e0869fb0.jpg	f
23	pablo.lluch@gmail.com	$2a$10$s0JOZiQKWV18ABowYdgcQ.C4YxGaJMtXI2HLnjqWJ0icHkzQVd8kq	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 18:37:34.042699	2015-04-24 18:37:34.042699	Pablo	Lluch	http://d21zid65ggdxzg.cloudfront.net/01f38a1aeffb6e6780c9563ca55f3f0e.jpg	f
24	fjana@koandina.com	$2a$10$P1Nbv370gWkvK3FUzTzac.rBCRdIYa9inqAyXymkkoLcQCurKG/zi	\N	\N	\N	0	\N	\N	\N	\N	2015-04-24 18:43:04.646563	2015-04-24 18:43:04.646563	Fernando	Jaña	\N	f
28	vmezas@koandina.com	$2a$10$wlm1OllJ8TmkNSvVLALNcu93Z8zkSCq6EyMWip.k3P/gQBt18ks3a	\N	\N	\N	0	\N	\N	\N	\N	2015-05-08 20:42:51.319238	2015-05-08 20:47:27.477551	Valentina	Meza	http://d21zid65ggdxzg.cloudfront.net/f8c7b6ddbaafc95b123300d4a199fa76.jpg	f
1	demo@ewin.cl	$2a$10$KvXMybqZNq53WVIqqPFpqewIN/z08CwFRP4aZj5QJuv3an6xqloLO	\N	\N	\N	0	\N	\N	\N	\N	2015-04-15 21:53:11.047739	2015-04-27 20:29:35.177494	Juan	Pérez	http://d21zid65ggdxzg.cloudfront.net/8057d0746903be1d0f9e3be06720e0ea.jpg	f
2	alvaro@gmail.com	$2a$10	\N	\N	\N	0	\N	\N	\N	\N	2015-05-14 21:53:11.047739	2015-05-14 21:53:11.047739	Alvaro	Troncoso	\N	f
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('users_id_seq', 28, true);


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY users_roles (user_id, role_id) FROM stdin;
18	13
19	14
20	15
21	16
22	17
23	18
24	19
25	20
26	21
27	22
28	23
1	1
2	1
\.


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY venues (id, organization_id, description, created_at, updated_at) FROM stdin;
\.


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('venues_id_seq', 1, false);


--
-- Data for Name: widgets; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY widgets (id, name, created_at, updated_at) FROM stdin;
1	picker	2015-04-24 21:37:54.204239	2015-04-24 21:37:54.204239
2	picket	2015-04-25 18:07:36.827037	2015-04-25 18:07:36.827037
\.


--
-- Name: widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('widgets_id_seq', 2, true);


--
-- Data for Name: workspaces; Type: TABLE DATA; Schema: public; Owner: echeckit
--

COPY workspaces (id, name, organization_id, created_at, updated_at, is_open) FROM stdin;
1	Embajadores	1	2015-04-15 21:53:10.950851	2015-04-15 21:53:10.950851	t
2	Despachadores	1	2015-04-15 21:53:10.954097	2015-04-15 21:53:10.954097	t
3	Demo	\N	2015-04-21 22:38:26.191705	2015-04-21 22:38:26.191705	t
4	Demo	\N	2015-04-21 22:39:56.119794	2015-04-21 22:39:56.119794	t
5	Demo	\N	2015-04-21 22:44:05.48073	2015-04-21 22:44:05.48073	t
6	Demo	\N	2015-04-21 23:29:50.371527	2015-04-21 23:29:50.371527	t
7	Demo	\N	2015-04-22 05:11:58.173218	2015-04-22 05:11:58.173218	t
8	Demo	\N	2015-04-22 06:57:57.787433	2015-04-22 06:57:57.787433	t
9	Demo	\N	2015-04-22 17:15:21.771493	2015-04-22 17:15:21.771493	t
10	Demo	\N	2015-04-23 00:51:33.276985	2015-04-23 00:51:33.276985	t
11	Demo	\N	2015-04-23 06:32:48.518434	2015-04-23 06:32:48.518434	t
12	Caleb Wong	\N	2015-04-23 16:15:00.516785	2015-04-23 16:15:00.516785	t
13	Pauline McDaniel	12	2015-04-23 16:47:51.932627	2015-04-23 16:47:51.932627	t
14	Alejandro Palma	13	2015-04-23 23:09:09.885579	2015-04-23 23:09:09.885579	t
15	Andrey Lujan	14	2015-04-24 02:20:35.025555	2015-04-24 02:20:35.025555	t
16	Lilly Berry	15	2015-04-24 04:56:53.178829	2015-04-24 04:56:53.178829	t
17	Andrey Luján	16	2015-04-24 11:15:36.168217	2015-04-24 11:15:36.168217	t
18	Pablo Lluch	17	2015-04-24 18:37:34.049015	2015-04-24 18:37:34.049015	t
19	Fernando Jaña	18	2015-04-24 18:43:04.652367	2015-04-24 18:43:04.652367	t
20	Wayne Boone	19	2015-04-24 21:30:41.196267	2015-04-24 21:30:41.196267	t
21	Laura G	20	2015-04-25 00:37:12.666713	2015-04-25 00:37:12.666713	t
22	Walter Chavez	21	2015-04-25 05:15:51.522045	2015-04-25 05:15:51.522045	t
23	Valentina Meza	22	2015-05-08 20:42:51.327637	2015-05-08 20:42:51.327637	t
\.


--
-- Name: workspaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echeckit
--

SELECT pg_catalog.setval('workspaces_id_seq', 23, true);


--
-- Name: action_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY action_types
    ADD CONSTRAINT action_types_pkey PRIMARY KEY (id);


--
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: domains_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id);


--
-- Name: report_field_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY report_field_types
    ADD CONSTRAINT report_field_types_pkey PRIMARY KEY (id);


--
-- Name: report_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY report_fields
    ADD CONSTRAINT report_fields_pkey PRIMARY KEY (id);


--
-- Name: report_states_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY report_states
    ADD CONSTRAINT report_states_pkey PRIMARY KEY (id);


--
-- Name: report_types_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY report_types
    ADD CONSTRAINT report_types_pkey PRIMARY KEY (id);


--
-- Name: reports_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venues_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: echeckit; Tablespace: 
--

ALTER TABLE ONLY workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);


--
-- Name: index_action_types_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_action_types_on_organization_id ON action_types USING btree (organization_id);


--
-- Name: index_actions_on_action_type_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_actions_on_action_type_id ON actions USING btree (action_type_id);


--
-- Name: index_actions_on_report_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_actions_on_report_id ON actions USING btree (report_id);


--
-- Name: index_actions_on_user_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_actions_on_user_id ON actions USING btree (user_id);


--
-- Name: index_contacts_on_venue_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_contacts_on_venue_id ON contacts USING btree (venue_id);


--
-- Name: index_domains_on_domain; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_domains_on_domain ON domains USING btree (domain);


--
-- Name: index_domains_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_domains_on_organization_id ON domains USING btree (organization_id);


--
-- Name: index_domains_on_organization_id_and_default_email; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_domains_on_organization_id_and_default_email ON domains USING btree (organization_id, default_email);


--
-- Name: index_feedbacks_on_rating; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_feedbacks_on_rating ON feedbacks USING btree (rating);


--
-- Name: index_feedbacks_on_user_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_feedbacks_on_user_id ON feedbacks USING btree (user_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON oauth_applications USING btree (uid);


--
-- Name: index_pictures_on_report_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_pictures_on_report_id ON pictures USING btree (report_id);


--
-- Name: index_report_field_types_on_widget_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_field_types_on_widget_id ON report_field_types USING btree (widget_id);


--
-- Name: index_report_field_types_on_workspace_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_field_types_on_workspace_id ON report_field_types USING btree (workspace_id);


--
-- Name: index_report_fields_on_report_field_type_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_fields_on_report_field_type_id ON report_fields USING btree (report_field_type_id);


--
-- Name: index_report_fields_on_report_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_fields_on_report_id ON report_fields USING btree (report_id);


--
-- Name: index_report_states_on_workspace_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_states_on_workspace_id ON report_states USING btree (workspace_id);


--
-- Name: index_report_states_on_workspace_id_and_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_report_states_on_workspace_id_and_name ON report_states USING btree (workspace_id, name);


--
-- Name: index_report_types_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_report_types_on_organization_id ON report_types USING btree (organization_id);


--
-- Name: index_reports_on_assigned_user_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_assigned_user_id ON reports USING btree (assigned_user_id);


--
-- Name: index_reports_on_creator_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_creator_id ON reports USING btree (creator_id);


--
-- Name: index_reports_on_report_state_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_report_state_id ON reports USING btree (report_state_id);


--
-- Name: index_reports_on_venue_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_venue_id ON reports USING btree (venue_id);


--
-- Name: index_reports_on_workspace_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_reports_on_workspace_id ON reports USING btree (workspace_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: index_venues_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_venues_on_organization_id ON venues USING btree (organization_id);


--
-- Name: index_workspaces_on_organization_id; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE INDEX index_workspaces_on_organization_id ON workspaces USING btree (organization_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: echeckit; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_1a4e822ce3; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_1a4e822ce3 FOREIGN KEY (report_id) REFERENCES reports(id);


--
-- Name: fk_rails_24a33c52ba; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_24a33c52ba FOREIGN KEY (venue_id) REFERENCES venues(id);


--
-- Name: fk_rails_2a0adb4eab; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_states
    ADD CONSTRAINT fk_rails_2a0adb4eab FOREIGN KEY (workspace_id) REFERENCES workspaces(id);


--
-- Name: fk_rails_2a9aee07e1; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_fields
    ADD CONSTRAINT fk_rails_2a9aee07e1 FOREIGN KEY (report_id) REFERENCES reports(id);


--
-- Name: fk_rails_382719c86d; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_382719c86d FOREIGN KEY (report_state_id) REFERENCES report_states(id);


--
-- Name: fk_rails_3e6d59991e; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY workspaces
    ADD CONSTRAINT fk_rails_3e6d59991e FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_5a37416919; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY action_types
    ADD CONSTRAINT fk_rails_5a37416919 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_71a2826ae7; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_field_types
    ADD CONSTRAINT fk_rails_71a2826ae7 FOREIGN KEY (widget_id) REFERENCES widgets(id);


--
-- Name: fk_rails_79fca9d9f4; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT fk_rails_79fca9d9f4 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_7f753a4f0d; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY pictures
    ADD CONSTRAINT fk_rails_7f753a4f0d FOREIGN KEY (report_id) REFERENCES reports(id);


--
-- Name: fk_rails_8c6b5c12eb; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_8c6b5c12eb FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_93725502cf; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_field_types
    ADD CONSTRAINT fk_rails_93725502cf FOREIGN KEY (workspace_id) REFERENCES workspaces(id);


--
-- Name: fk_rails_a80517076c; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY report_fields
    ADD CONSTRAINT fk_rails_a80517076c FOREIGN KEY (report_field_type_id) REFERENCES report_field_types(id);


--
-- Name: fk_rails_b493e55f53; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_b493e55f53 FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: fk_rails_b8a7abe7eb; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_b8a7abe7eb FOREIGN KEY (action_type_id) REFERENCES action_types(id);


--
-- Name: fk_rails_c57bb6cf28; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT fk_rails_c57bb6cf28 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_c92ae0ce41; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY domains
    ADD CONSTRAINT fk_rails_c92ae0ce41 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_cd1aa5513a; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_cd1aa5513a FOREIGN KEY (assigned_user_id) REFERENCES users(id);


--
-- Name: fk_rails_e3d3add3ce; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_rails_e3d3add3ce FOREIGN KEY (workspace_id) REFERENCES workspaces(id);


--
-- Name: fk_rails_e882f51387; Type: FK CONSTRAINT; Schema: public; Owner: echeckit
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT fk_rails_e882f51387 FOREIGN KEY (venue_id) REFERENCES venues(id);


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

