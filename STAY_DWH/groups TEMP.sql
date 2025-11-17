--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 16.0

-- Started on 2024-04-17 14:05:18

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

--
-- TOC entry 1260 (class 1259 OID 21019)
-- Name: groups; Type: TABLE; Schema: public; Owner: agilysys
--

CREATE TABLE public.groups (
    id text NOT NULL,
    account_id text,
    adults_included integer,
    allocation_id text,
    booking_status text,
    cancellation_policy_id text,
    children_included integer,
    create_time timestamp without time zone,
    deposit_policy_id text,
    end_date date,
    extra_adult_charge numeric(19,2),
    extra_children_charge numeric(19,2),
    group_code text,
    group_name text,
    rate_plan_id text,
    guest_type_id text,
    market_segment_id text,
    profile_id text,
    property_id text,
    shoulder_end_date date,
    shoulder_start_date date,
    source_of_business_id text,
    start_date date,
    tax_exempt boolean,
    tenant_id text,
    update_time timestamp without time zone,
    confirmation_code text,
    released boolean DEFAULT false,
    profile_type text,
    description text,
    rolling_release_enabled boolean,
    auto_release_enabled boolean,
    cut_off_date date,
    departure_date date,
    wholesaler boolean,
    overridden_arc_rule_id text,
    room_blocks_for_shoulder_dates boolean,
    allocate_blocks_for_shoulder_dates boolean,
    housing_restricted boolean,
    transaction_item_id text
);


ALTER TABLE public.groups OWNER TO agilysys;

--
-- TOC entry 6120 (class 2606 OID 21026)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 6121 (class 1259 OID 150099262)
-- Name: idx_groups_aid; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_groups_aid ON public.groups USING btree (account_id);


--
-- TOC entry 6122 (class 1259 OID 68987141)
-- Name: idx_groups_pid; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_groups_pid ON public.groups USING btree (profile_id);


--
-- TOC entry 6123 (class 1259 OID 114724)
-- Name: idx_groups_tenant_id_property_id_start_date_end_date; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_groups_tenant_id_property_id_start_date_end_date ON public.groups USING btree (tenant_id, property_id, start_date, end_date);


--
-- TOC entry 6124 (class 1259 OID 2958948)
-- Name: idx_groups_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_groups_tid_pid_id ON public.groups USING btree (tenant_id, property_id, id);


--
-- TOC entry 6125 (class 2620 OID 2158233)
-- Name: groups flash_groups_stale; Type: TRIGGER; Schema: public; Owner: agilysys
--

CREATE TRIGGER flash_groups_stale AFTER INSERT OR UPDATE ON public.groups FOR EACH ROW EXECUTE PROCEDURE public.flash_groups_stale();


--
-- TOC entry 6126 (class 2620 OID 2158238)
-- Name: groups marketsegment_groups_stale; Type: TRIGGER; Schema: public; Owner: agilysys
--

CREATE TRIGGER marketsegment_groups_stale AFTER INSERT OR UPDATE ON public.groups FOR EACH ROW EXECUTE PROCEDURE public.marketsegment_groups_stale();


--
-- TOC entry 6251 (class 0 OID 21019)
-- Dependencies: 1260
-- Name: groups; Type: ROW SECURITY; Schema: public; Owner: agilysys
--

ALTER TABLE public.groups ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6266 (class 3256 OID 74961)
-- Name: groups waper$0$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$0$stay_prod$groups" ON public.groups FOR SELECT TO "waper$0$stay_prod" USING ((tenant_id = '0'::text));


--
-- TOC entry 6267 (class 3256 OID 74982)
-- Name: groups waper$100$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$100$stay_prod$groups" ON public.groups FOR SELECT TO "waper$100$stay_prod" USING ((tenant_id = '100'::text));


--
-- TOC entry 6276 (class 3256 OID 75172)
-- Name: groups waper$101$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$101$stay_prod$groups" ON public.groups FOR SELECT TO "waper$101$stay_prod" USING ((tenant_id = '101'::text));


--
-- TOC entry 6277 (class 3256 OID 75193)
-- Name: groups waper$102$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$102$stay_prod$groups" ON public.groups FOR SELECT TO "waper$102$stay_prod" USING ((tenant_id = '102'::text));


--
-- TOC entry 6305 (class 3256 OID 75781)
-- Name: groups waper$1021$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1021$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1021$stay_prod" USING ((tenant_id = '1021'::text));


--
-- TOC entry 6310 (class 3256 OID 75886)
-- Name: groups waper$1022$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1022$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1022$stay_prod" USING ((tenant_id = '1022'::text));


--
-- TOC entry 6291 (class 3256 OID 75487)
-- Name: groups waper$1023$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1023$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1023$stay_prod" USING ((tenant_id = '1023'::text));


--
-- TOC entry 6313 (class 3256 OID 75949)
-- Name: groups waper$1024$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1024$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1024$stay_prod" USING ((tenant_id = '1024'::text));


--
-- TOC entry 6423 (class 3256 OID 62482465)
-- Name: groups waper$1025$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1025$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1025$stay_prod" USING ((tenant_id = '1025'::text));


--
-- TOC entry 6306 (class 3256 OID 75802)
-- Name: groups waper$103$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$103$stay_prod$groups" ON public.groups FOR SELECT TO "waper$103$stay_prod" USING ((tenant_id = '103'::text));


--
-- TOC entry 6285 (class 3256 OID 75361)
-- Name: groups waper$1036$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1036$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1036$stay_prod" USING ((tenant_id = '1036'::text));


--
-- TOC entry 6341 (class 3256 OID 2457899)
-- Name: groups waper$1038$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1038$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1038$stay_prod" USING ((tenant_id = '1038'::text));


--
-- TOC entry 6314 (class 3256 OID 81190)
-- Name: groups waper$1039$346$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$346$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1039$346$stay_prod" USING (((tenant_id = '1039'::text) AND (property_id = '346'::text)));


--
-- TOC entry 6269 (class 3256 OID 75024)
-- Name: groups waper$1039$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1039$stay_prod" USING ((tenant_id = '1039'::text));


--
-- TOC entry 6261 (class 3256 OID 74856)
-- Name: groups waper$104$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$104$stay_prod$groups" ON public.groups FOR SELECT TO "waper$104$stay_prod" USING ((tenant_id = '104'::text));


--
-- TOC entry 6286 (class 3256 OID 75382)
-- Name: groups waper$105$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$105$stay_prod$groups" ON public.groups FOR SELECT TO "waper$105$stay_prod" USING ((tenant_id = '105'::text));


--
-- TOC entry 6259 (class 3256 OID 74814)
-- Name: groups waper$1055$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1055$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1055$stay_prod" USING ((tenant_id = '1055'::text));


--
-- TOC entry 6270 (class 3256 OID 75045)
-- Name: groups waper$1058$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1058$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1058$stay_prod" USING ((tenant_id = '1058'::text));


--
-- TOC entry 6253 (class 3256 OID 74688)
-- Name: groups waper$106$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$106$stay_prod$groups" ON public.groups FOR SELECT TO "waper$106$stay_prod" USING ((tenant_id = '106'::text));


--
-- TOC entry 6386 (class 3256 OID 34722573)
-- Name: groups waper$1060$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1060$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1060$stay_prod" USING ((tenant_id = '1060'::text));


--
-- TOC entry 6301 (class 3256 OID 75697)
-- Name: groups waper$1061$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1061$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1061$stay_prod" USING ((tenant_id = '1061'::text));


--
-- TOC entry 6256 (class 3256 OID 74751)
-- Name: groups waper$108$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$108$stay_prod$groups" ON public.groups FOR SELECT TO "waper$108$stay_prod" USING ((tenant_id = '108'::text));


--
-- TOC entry 6258 (class 3256 OID 74793)
-- Name: groups waper$109$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$109$stay_prod$groups" ON public.groups FOR SELECT TO "waper$109$stay_prod" USING ((tenant_id = '109'::text));


--
-- TOC entry 6260 (class 3256 OID 74835)
-- Name: groups waper$1092$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1092$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1092$stay_prod" USING ((tenant_id = '1092'::text));


--
-- TOC entry 6281 (class 3256 OID 75277)
-- Name: groups waper$110$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$110$stay_prod$groups" ON public.groups FOR SELECT TO "waper$110$stay_prod" USING ((tenant_id = '110'::text));


--
-- TOC entry 6463 (class 3256 OID 85493768)
-- Name: groups waper$1107$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1107$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1107$stay_prod" USING ((tenant_id = '1107'::text));


--
-- TOC entry 6298 (class 3256 OID 75634)
-- Name: groups waper$1116$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1116$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1116$stay_prod" USING ((tenant_id = '1116'::text));


--
-- TOC entry 6264 (class 3256 OID 74919)
-- Name: groups waper$1132$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1132$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1132$stay_prod" USING ((tenant_id = '1132'::text));


--
-- TOC entry 6282 (class 3256 OID 75298)
-- Name: groups waper$1166$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1166$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1166$stay_prod" USING ((tenant_id = '1166'::text));


--
-- TOC entry 6293 (class 3256 OID 75529)
-- Name: groups waper$1167$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1167$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1167$stay_prod" USING ((tenant_id = '1167'::text));


--
-- TOC entry 6401 (class 3256 OID 50618180)
-- Name: groups waper$1180$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1180$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1180$stay_prod" USING ((tenant_id = '1180'::text));


--
-- TOC entry 6315 (class 3256 OID 142453)
-- Name: groups waper$1181$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1181$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1181$stay_prod" USING ((tenant_id = '1181'::text));


--
-- TOC entry 6316 (class 3256 OID 142479)
-- Name: groups waper$1184$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1184$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1184$stay_prod" USING ((tenant_id = '1184'::text));


--
-- TOC entry 6329 (class 3256 OID 1893512)
-- Name: groups waper$1188$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1188$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1188$stay_prod" USING ((tenant_id = '1188'::text));


--
-- TOC entry 6318 (class 3256 OID 175381)
-- Name: groups waper$1189$388$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$388$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1189$388$stay_prod" USING (((tenant_id = '1189'::text) AND (property_id = '388'::text)));


--
-- TOC entry 6317 (class 3256 OID 142524)
-- Name: groups waper$1189$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1189$stay_prod" USING ((tenant_id = '1189'::text));


--
-- TOC entry 6480 (class 3256 OID 170364466)
-- Name: groups waper$1207$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1207$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1207$stay_prod" USING ((tenant_id = '1207'::text));


--
-- TOC entry 6366 (class 3256 OID 4193369)
-- Name: groups waper$1209$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1209$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1209$stay_prod" USING ((tenant_id = '1209'::text));


--
-- TOC entry 6319 (class 3256 OID 240065)
-- Name: groups waper$1211$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1211$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1211$stay_prod" USING ((tenant_id = '1211'::text));


--
-- TOC entry 6331 (class 3256 OID 1893514)
-- Name: groups waper$1212$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1212$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1212$stay_prod" USING ((tenant_id = '1212'::text));


--
-- TOC entry 6411 (class 3256 OID 57224799)
-- Name: groups waper$1213$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1213$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1213$stay_prod" USING ((tenant_id = '1213'::text));


--
-- TOC entry 6320 (class 3256 OID 240111)
-- Name: groups waper$1218$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1218$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1218$stay_prod" USING ((tenant_id = '1218'::text));


--
-- TOC entry 6290 (class 3256 OID 75466)
-- Name: groups waper$122$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$122$stay_prod$groups" ON public.groups FOR SELECT TO "waper$122$stay_prod" USING ((tenant_id = '122'::text));


--
-- TOC entry 6324 (class 3256 OID 1893507)
-- Name: groups waper$1227$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1227$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1227$stay_prod" USING ((tenant_id = '1227'::text));


--
-- TOC entry 6325 (class 3256 OID 1893508)
-- Name: groups waper$1228$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1228$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1228$stay_prod" USING ((tenant_id = '1228'::text));


--
-- TOC entry 6335 (class 3256 OID 1893518)
-- Name: groups waper$1231$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1231$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1231$stay_prod" USING ((tenant_id = '1231'::text));


--
-- TOC entry 6471 (class 3256 OID 125071378)
-- Name: groups waper$1232$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1232$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1232$stay_prod" USING ((tenant_id = '1232'::text));


--
-- TOC entry 6322 (class 3256 OID 561719)
-- Name: groups waper$1236$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1236$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1236$stay_prod" USING ((tenant_id = '1236'::text));


--
-- TOC entry 6323 (class 3256 OID 561767)
-- Name: groups waper$1253$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1253$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1253$stay_prod" USING ((tenant_id = '1253'::text));


--
-- TOC entry 6429 (class 3256 OID 67059723)
-- Name: groups waper$1293$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1293$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1293$stay_prod" USING ((tenant_id = '1293'::text));


--
-- TOC entry 6394 (class 3256 OID 37886729)
-- Name: groups waper$1298$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1298$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1298$stay_prod" USING ((tenant_id = '1298'::text));


--
-- TOC entry 6379 (class 3256 OID 26948099)
-- Name: groups waper$1305$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1305$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1305$stay_prod" USING ((tenant_id = '1305'::text));


--
-- TOC entry 6326 (class 3256 OID 1893509)
-- Name: groups waper$1318$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1318$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1318$stay_prod" USING ((tenant_id = '1318'::text));


--
-- TOC entry 6430 (class 3256 OID 67059724)
-- Name: groups waper$1321$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1321$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1321$stay_prod" USING ((tenant_id = '1321'::text));


--
-- TOC entry 6333 (class 3256 OID 1893516)
-- Name: groups waper$1330$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1330$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1330$stay_prod" USING ((tenant_id = '1330'::text));


--
-- TOC entry 6354 (class 3256 OID 2620944)
-- Name: groups waper$1336$440$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$440$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1336$440$stay_prod" USING (((tenant_id = '1336'::text) AND (property_id = '440'::text)));


--
-- TOC entry 6334 (class 3256 OID 1893517)
-- Name: groups waper$1336$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1336$stay_prod" USING ((tenant_id = '1336'::text));


--
-- TOC entry 6327 (class 3256 OID 1893510)
-- Name: groups waper$1337$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1337$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1337$stay_prod" USING ((tenant_id = '1337'::text));


--
-- TOC entry 6332 (class 3256 OID 1893515)
-- Name: groups waper$1339$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1339$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1339$stay_prod" USING ((tenant_id = '1339'::text));


--
-- TOC entry 6328 (class 3256 OID 1893511)
-- Name: groups waper$1344$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1344$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1344$stay_prod" USING ((tenant_id = '1344'::text));


--
-- TOC entry 6338 (class 3256 OID 2125524)
-- Name: groups waper$1373$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1373$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1373$stay_prod" USING ((tenant_id = '1373'::text));


--
-- TOC entry 6272 (class 3256 OID 75087)
-- Name: groups waper$140$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$140$stay_prod$groups" ON public.groups FOR SELECT TO "waper$140$stay_prod" USING ((tenant_id = '140'::text));


--
-- TOC entry 6289 (class 3256 OID 75445)
-- Name: groups waper$143$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$143$stay_prod$groups" ON public.groups FOR SELECT TO "waper$143$stay_prod" USING ((tenant_id = '143'::text));


--
-- TOC entry 6340 (class 3256 OID 2125526)
-- Name: groups waper$1438$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1438$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1438$stay_prod" USING ((tenant_id = '1438'::text));


--
-- TOC entry 6339 (class 3256 OID 2125525)
-- Name: groups waper$1439$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1439$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1439$stay_prod" USING ((tenant_id = '1439'::text));


--
-- TOC entry 6344 (class 3256 OID 2483698)
-- Name: groups waper$1474$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1474$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1474$stay_prod" USING ((tenant_id = '1474'::text));


--
-- TOC entry 6343 (class 3256 OID 2483697)
-- Name: groups waper$1480$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1480$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1480$stay_prod" USING ((tenant_id = '1480'::text));


--
-- TOC entry 6342 (class 3256 OID 2483696)
-- Name: groups waper$1481$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1481$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1481$stay_prod" USING ((tenant_id = '1481'::text));


--
-- TOC entry 6350 (class 3256 OID 2568035)
-- Name: groups waper$1483$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1483$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1483$stay_prod" USING ((tenant_id = '1483'::text));


--
-- TOC entry 6348 (class 3256 OID 2545596)
-- Name: groups waper$1485$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1485$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1485$stay_prod" USING ((tenant_id = '1485'::text));


--
-- TOC entry 6349 (class 3256 OID 2564697)
-- Name: groups waper$1487$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1487$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1487$stay_prod" USING ((tenant_id = '1487'::text));


--
-- TOC entry 6353 (class 3256 OID 2620943)
-- Name: groups waper$1532$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1532$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1532$stay_prod" USING ((tenant_id = '1532'::text));


--
-- TOC entry 6352 (class 3256 OID 2620942)
-- Name: groups waper$1533$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1533$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1533$stay_prod" USING ((tenant_id = '1533'::text));


--
-- TOC entry 6355 (class 3256 OID 2679391)
-- Name: groups waper$1548$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1548$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1548$stay_prod" USING ((tenant_id = '1548'::text));


--
-- TOC entry 6357 (class 3256 OID 2690262)
-- Name: groups waper$1551$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1551$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1551$stay_prod" USING ((tenant_id = '1551'::text));


--
-- TOC entry 6356 (class 3256 OID 2690261)
-- Name: groups waper$1553$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1553$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1553$stay_prod" USING ((tenant_id = '1553'::text));


--
-- TOC entry 6347 (class 3256 OID 2820794)
-- Name: groups waper$1565$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1565$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1565$stay_prod" USING ((tenant_id = '1565'::text));


--
-- TOC entry 6346 (class 3256 OID 2820793)
-- Name: groups waper$1566$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1566$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1566$stay_prod" USING ((tenant_id = '1566'::text));


--
-- TOC entry 6345 (class 3256 OID 2805735)
-- Name: groups waper$1568$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1568$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1568$stay_prod" USING ((tenant_id = '1568'::text));


--
-- TOC entry 6351 (class 3256 OID 2890269)
-- Name: groups waper$1585$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1585$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1585$stay_prod" USING ((tenant_id = '1585'::text));


--
-- TOC entry 6358 (class 3256 OID 2892557)
-- Name: groups waper$1586$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1586$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1586$stay_prod" USING ((tenant_id = '1586'::text));


--
-- TOC entry 6361 (class 3256 OID 2965829)
-- Name: groups waper$1593$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1593$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1593$stay_prod" USING ((tenant_id = '1593'::text));


--
-- TOC entry 6360 (class 3256 OID 2965828)
-- Name: groups waper$1595$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1595$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1595$stay_prod" USING ((tenant_id = '1595'::text));


--
-- TOC entry 6384 (class 3256 OID 31543652)
-- Name: groups waper$1598$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1598$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1598$stay_prod" USING ((tenant_id = '1598'::text));


--
-- TOC entry 6359 (class 3256 OID 2965827)
-- Name: groups waper$1599$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1599$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1599$stay_prod" USING ((tenant_id = '1599'::text));


--
-- TOC entry 6362 (class 3256 OID 3022572)
-- Name: groups waper$1612$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1612$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1612$stay_prod" USING ((tenant_id = '1612'::text));


--
-- TOC entry 6336 (class 3256 OID 18313197)
-- Name: groups waper$1613$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1613$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1613$stay_prod" USING ((tenant_id = '1613'::text));


--
-- TOC entry 6363 (class 3256 OID 3046410)
-- Name: groups waper$1614$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1614$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1614$stay_prod" USING ((tenant_id = '1614'::text));


--
-- TOC entry 6364 (class 3256 OID 3078280)
-- Name: groups waper$1615$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1615$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1615$stay_prod" USING ((tenant_id = '1615'::text));


--
-- TOC entry 6365 (class 3256 OID 3177038)
-- Name: groups waper$1633$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1633$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1633$stay_prod" USING ((tenant_id = '1633'::text));


--
-- TOC entry 6367 (class 3256 OID 4193370)
-- Name: groups waper$1673$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1673$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1673$stay_prod" USING ((tenant_id = '1673'::text));


--
-- TOC entry 6369 (class 3256 OID 4638317)
-- Name: groups waper$1676$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1676$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1676$stay_prod" USING ((tenant_id = '1676'::text));


--
-- TOC entry 6294 (class 3256 OID 75550)
-- Name: groups waper$171$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$171$stay_prod$groups" ON public.groups FOR SELECT TO "waper$171$stay_prod" USING ((tenant_id = '171'::text));


--
-- TOC entry 6371 (class 3256 OID 12238198)
-- Name: groups waper$1730$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1730$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1730$stay_prod" USING ((tenant_id = '1730'::text));


--
-- TOC entry 6470 (class 3256 OID 101326934)
-- Name: groups waper$1735$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1735$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1735$stay_prod" USING ((tenant_id = '1735'::text));


--
-- TOC entry 6370 (class 3256 OID 12238197)
-- Name: groups waper$1738$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1738$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1738$stay_prod" USING ((tenant_id = '1738'::text));


--
-- TOC entry 6330 (class 3256 OID 1893513)
-- Name: groups waper$177$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$177$stay_prod$groups" ON public.groups FOR SELECT TO "waper$177$stay_prod" USING ((tenant_id = '177'::text));


--
-- TOC entry 6376 (class 3256 OID 21984850)
-- Name: groups waper$1791$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1791$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1791$stay_prod" USING ((tenant_id = '1791'::text));


--
-- TOC entry 6375 (class 3256 OID 21984849)
-- Name: groups waper$1794$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1794$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1794$stay_prod" USING ((tenant_id = '1794'::text));


--
-- TOC entry 6439 (class 3256 OID 72906836)
-- Name: groups waper$1805$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1805$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1805$stay_prod" USING ((tenant_id = '1805'::text));


--
-- TOC entry 6377 (class 3256 OID 26948097)
-- Name: groups waper$1810$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1810$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1810$stay_prod" USING ((tenant_id = '1810'::text));


--
-- TOC entry 6378 (class 3256 OID 26948098)
-- Name: groups waper$1815$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1815$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1815$stay_prod" USING ((tenant_id = '1815'::text));


--
-- TOC entry 6380 (class 3256 OID 27293571)
-- Name: groups waper$1816$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1816$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1816$stay_prod" USING ((tenant_id = '1816'::text));


--
-- TOC entry 6415 (class 3256 OID 58058419)
-- Name: groups waper$1832$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1832$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1832$stay_prod" USING ((tenant_id = '1832'::text));


--
-- TOC entry 6383 (class 3256 OID 31543651)
-- Name: groups waper$1837$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1837$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1837$stay_prod" USING ((tenant_id = '1837'::text));


--
-- TOC entry 6387 (class 3256 OID 34722574)
-- Name: groups waper$1838$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1838$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1838$stay_prod" USING ((tenant_id = '1838'::text));


--
-- TOC entry 6374 (class 3256 OID 32983160)
-- Name: groups waper$1839$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1839$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1839$stay_prod" USING ((tenant_id = '1839'::text));


--
-- TOC entry 6373 (class 3256 OID 32983159)
-- Name: groups waper$1841$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1841$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1841$stay_prod" USING ((tenant_id = '1841'::text));


--
-- TOC entry 6395 (class 3256 OID 37886730)
-- Name: groups waper$1845$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1845$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1845$stay_prod" USING ((tenant_id = '1845'::text));


--
-- TOC entry 6385 (class 3256 OID 34722572)
-- Name: groups waper$1846$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1846$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1846$stay_prod" USING ((tenant_id = '1846'::text));


--
-- TOC entry 6388 (class 3256 OID 36083789)
-- Name: groups waper$1847$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1847$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1847$stay_prod" USING ((tenant_id = '1847'::text));


--
-- TOC entry 6391 (class 3256 OID 37886726)
-- Name: groups waper$1851$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1851$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1851$stay_prod" USING ((tenant_id = '1851'::text));


--
-- TOC entry 6396 (class 3256 OID 37886731)
-- Name: groups waper$1852$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1852$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1852$stay_prod" USING ((tenant_id = '1852'::text));


--
-- TOC entry 6393 (class 3256 OID 37886728)
-- Name: groups waper$1854$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1854$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1854$stay_prod" USING ((tenant_id = '1854'::text));


--
-- TOC entry 6397 (class 3256 OID 37886732)
-- Name: groups waper$1855$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1855$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1855$stay_prod" USING ((tenant_id = '1855'::text));


--
-- TOC entry 6390 (class 3256 OID 37886725)
-- Name: groups waper$1856$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1856$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1856$stay_prod" USING ((tenant_id = '1856'::text));


--
-- TOC entry 6304 (class 3256 OID 75760)
-- Name: groups waper$186$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$186$stay_prod$groups" ON public.groups FOR SELECT TO "waper$186$stay_prod" USING ((tenant_id = '186'::text));


--
-- TOC entry 6389 (class 3256 OID 37886724)
-- Name: groups waper$1861$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1861$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1861$stay_prod" USING ((tenant_id = '1861'::text));


--
-- TOC entry 6399 (class 3256 OID 39891797)
-- Name: groups waper$1864$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1864$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1864$stay_prod" USING ((tenant_id = '1864'::text));


--
-- TOC entry 6398 (class 3256 OID 39891796)
-- Name: groups waper$1865$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1865$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1865$stay_prod" USING ((tenant_id = '1865'::text));


--
-- TOC entry 6405 (class 3256 OID 50618184)
-- Name: groups waper$1891$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1891$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1891$stay_prod" USING ((tenant_id = '1891'::text));


--
-- TOC entry 6407 (class 3256 OID 50618186)
-- Name: groups waper$1892$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1892$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1892$stay_prod" USING ((tenant_id = '1892'::text));


--
-- TOC entry 6402 (class 3256 OID 50618181)
-- Name: groups waper$1906$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1906$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1906$stay_prod" USING ((tenant_id = '1906'::text));


--
-- TOC entry 6404 (class 3256 OID 50618183)
-- Name: groups waper$1907$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1907$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1907$stay_prod" USING ((tenant_id = '1907'::text));


--
-- TOC entry 6440 (class 3256 OID 72906837)
-- Name: groups waper$1910$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1910$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1910$stay_prod" USING ((tenant_id = '1910'::text));


--
-- TOC entry 6442 (class 3256 OID 72906839)
-- Name: groups waper$1911$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1911$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1911$stay_prod" USING ((tenant_id = '1911'::text));


--
-- TOC entry 6406 (class 3256 OID 50618185)
-- Name: groups waper$1917$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1917$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1917$stay_prod" USING ((tenant_id = '1917'::text));


--
-- TOC entry 6400 (class 3256 OID 50618179)
-- Name: groups waper$1918$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1918$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1918$stay_prod" USING ((tenant_id = '1918'::text));


--
-- TOC entry 6438 (class 3256 OID 71867271)
-- Name: groups waper$1919$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1919$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1919$stay_prod" USING ((tenant_id = '1919'::text));


--
-- TOC entry 6432 (class 3256 OID 68920672)
-- Name: groups waper$1920$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1920$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1920$stay_prod" USING ((tenant_id = '1920'::text));


--
-- TOC entry 6425 (class 3256 OID 64532792)
-- Name: groups waper$1930$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1930$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1930$stay_prod" USING ((tenant_id = '1930'::text));


--
-- TOC entry 6410 (class 3256 OID 54184355)
-- Name: groups waper$1935$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1935$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1935$stay_prod" USING ((tenant_id = '1935'::text));


--
-- TOC entry 6419 (class 3256 OID 59518338)
-- Name: groups waper$1936$623$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$623$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$623$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '623'::text)));


--
-- TOC entry 6453 (class 3256 OID 76022831)
-- Name: groups waper$1936$682$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$682$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$682$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '682'::text)));


--
-- TOC entry 6450 (class 3256 OID 75783924)
-- Name: groups waper$1936$683$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$683$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$683$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '683'::text)));


--
-- TOC entry 6451 (class 3256 OID 76022829)
-- Name: groups waper$1936$684$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$684$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$684$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '684'::text)));


--
-- TOC entry 6441 (class 3256 OID 72906838)
-- Name: groups waper$1936$703$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$703$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$703$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '703'::text)));


--
-- TOC entry 6443 (class 3256 OID 73780162)
-- Name: groups waper$1936$713$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$713$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$713$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '713'::text)));


--
-- TOC entry 6446 (class 3256 OID 74872704)
-- Name: groups waper$1936$715$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$715$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$715$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '715'::text)));


--
-- TOC entry 6449 (class 3256 OID 74872707)
-- Name: groups waper$1936$716$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$716$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$716$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '716'::text)));


--
-- TOC entry 6448 (class 3256 OID 74872706)
-- Name: groups waper$1936$717$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$717$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$717$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '717'::text)));


--
-- TOC entry 6447 (class 3256 OID 74872705)
-- Name: groups waper$1936$718$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$718$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$718$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '718'::text)));


--
-- TOC entry 6454 (class 3256 OID 76022832)
-- Name: groups waper$1936$722$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$722$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$722$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '722'::text)));


--
-- TOC entry 6452 (class 3256 OID 76022830)
-- Name: groups waper$1936$725$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$725$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$725$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '725'::text)));


--
-- TOC entry 6456 (class 3256 OID 76022834)
-- Name: groups waper$1936$726$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$726$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$726$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '726'::text)));


--
-- TOC entry 6413 (class 3256 OID 57224801)
-- Name: groups waper$1936$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1936$stay_prod" USING ((tenant_id = '1936'::text));


--
-- TOC entry 6420 (class 3256 OID 60968812)
-- Name: groups waper$1937$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1937$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1937$stay_prod" USING ((tenant_id = '1937'::text));


--
-- TOC entry 6417 (class 3256 OID 59504655)
-- Name: groups waper$1938$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1938$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1938$stay_prod" USING ((tenant_id = '1938'::text));


--
-- TOC entry 6477 (class 3256 OID 151313447)
-- Name: groups waper$1939$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1939$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1939$stay_prod" USING ((tenant_id = '1939'::text));


--
-- TOC entry 6479 (class 3256 OID 151313449)
-- Name: groups waper$1942$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1942$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1942$stay_prod" USING ((tenant_id = '1942'::text));


--
-- TOC entry 6426 (class 3256 OID 67059720)
-- Name: groups waper$1955$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1955$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1955$stay_prod" USING ((tenant_id = '1955'::text));


--
-- TOC entry 6427 (class 3256 OID 67059721)
-- Name: groups waper$1956$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1956$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1956$stay_prod" USING ((tenant_id = '1956'::text));


--
-- TOC entry 6416 (class 3256 OID 59504654)
-- Name: groups waper$1958$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1958$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1958$stay_prod" USING ((tenant_id = '1958'::text));


--
-- TOC entry 6459 (class 3256 OID 78083640)
-- Name: groups waper$1961$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1961$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1961$stay_prod" USING ((tenant_id = '1961'::text));


--
-- TOC entry 6414 (class 3256 OID 57224802)
-- Name: groups waper$1962$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1962$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1962$stay_prod" USING ((tenant_id = '1962'::text));


--
-- TOC entry 6412 (class 3256 OID 57224800)
-- Name: groups waper$1966$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1966$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1966$stay_prod" USING ((tenant_id = '1966'::text));


--
-- TOC entry 6428 (class 3256 OID 67059722)
-- Name: groups waper$1990$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1990$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1990$stay_prod" USING ((tenant_id = '1990'::text));


--
-- TOC entry 6431 (class 3256 OID 67059725)
-- Name: groups waper$1991$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1991$stay_prod$groups" ON public.groups FOR SELECT TO "waper$1991$stay_prod" USING ((tenant_id = '1991'::text));


--
-- TOC entry 6435 (class 3256 OID 71867268)
-- Name: groups waper$2001$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2001$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2001$stay_prod" USING ((tenant_id = '2001'::text));


--
-- TOC entry 6476 (class 3256 OID 151313446)
-- Name: groups waper$2004$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2004$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2004$stay_prod" USING ((tenant_id = '2004'::text));


--
-- TOC entry 6444 (class 3256 OID 74870273)
-- Name: groups waper$2025$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2025$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2025$stay_prod" USING ((tenant_id = '2025'::text));


--
-- TOC entry 6445 (class 3256 OID 74870274)
-- Name: groups waper$2031$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2031$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2031$stay_prod" USING ((tenant_id = '2031'::text));


--
-- TOC entry 6436 (class 3256 OID 71867269)
-- Name: groups waper$2038$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2038$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2038$stay_prod" USING ((tenant_id = '2038'::text));


--
-- TOC entry 6460 (class 3256 OID 78678936)
-- Name: groups waper$2051$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2051$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2051$stay_prod" USING ((tenant_id = '2051'::text));


--
-- TOC entry 6465 (class 3256 OID 85493770)
-- Name: groups waper$2062$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2062$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2062$stay_prod" USING ((tenant_id = '2062'::text));


--
-- TOC entry 6464 (class 3256 OID 85493769)
-- Name: groups waper$2065$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2065$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2065$stay_prod" USING ((tenant_id = '2065'::text));


--
-- TOC entry 6458 (class 3256 OID 78083639)
-- Name: groups waper$2068$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2068$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2068$stay_prod" USING ((tenant_id = '2068'::text));


--
-- TOC entry 6457 (class 3256 OID 78083638)
-- Name: groups waper$2069$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2069$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2069$stay_prod" USING ((tenant_id = '2069'::text));


--
-- TOC entry 6472 (class 3256 OID 125071379)
-- Name: groups waper$2078$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2078$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2078$stay_prod" USING ((tenant_id = '2078'::text));


--
-- TOC entry 6462 (class 3256 OID 85493767)
-- Name: groups waper$2090$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2090$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2090$stay_prod" USING ((tenant_id = '2090'::text));


--
-- TOC entry 6461 (class 3256 OID 85493766)
-- Name: groups waper$2091$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2091$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2091$stay_prod" USING ((tenant_id = '2091'::text));


--
-- TOC entry 6467 (class 3256 OID 92731106)
-- Name: groups waper$2093$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2093$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2093$stay_prod" USING ((tenant_id = '2093'::text));


--
-- TOC entry 6466 (class 3256 OID 91133821)
-- Name: groups waper$2094$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2094$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2094$stay_prod" USING ((tenant_id = '2094'::text));


--
-- TOC entry 6469 (class 3256 OID 94763332)
-- Name: groups waper$2117$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2117$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2117$stay_prod" USING ((tenant_id = '2117'::text));


--
-- TOC entry 6473 (class 3256 OID 125071380)
-- Name: groups waper$2145$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2145$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2145$stay_prod" USING ((tenant_id = '2145'::text));


--
-- TOC entry 6475 (class 3256 OID 151313445)
-- Name: groups waper$2190$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2190$stay_prod$groups" ON public.groups FOR SELECT TO "waper$2190$stay_prod" USING ((tenant_id = '2190'::text));


--
-- TOC entry 6271 (class 3256 OID 75066)
-- Name: groups waper$227$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$227$stay_prod$groups" ON public.groups FOR SELECT TO "waper$227$stay_prod" USING ((tenant_id = '227'::text));


--
-- TOC entry 6295 (class 3256 OID 75571)
-- Name: groups waper$253$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$253$stay_prod$groups" ON public.groups FOR SELECT TO "waper$253$stay_prod" USING ((tenant_id = '253'::text));


--
-- TOC entry 6254 (class 3256 OID 74709)
-- Name: groups waper$299$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$299$stay_prod$groups" ON public.groups FOR SELECT TO "waper$299$stay_prod" USING ((tenant_id = '299'::text));


--
-- TOC entry 6284 (class 3256 OID 75340)
-- Name: groups waper$410$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$410$stay_prod$groups" ON public.groups FOR SELECT TO "waper$410$stay_prod" USING ((tenant_id = '410'::text));


--
-- TOC entry 6409 (class 3256 OID 54184354)
-- Name: groups waper$458$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$458$stay_prod$groups" ON public.groups FOR SELECT TO "waper$458$stay_prod" USING ((tenant_id = '458'::text));


--
-- TOC entry 6311 (class 3256 OID 75907)
-- Name: groups waper$460$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$460$stay_prod$groups" ON public.groups FOR SELECT TO "waper$460$stay_prod" USING ((tenant_id = '460'::text));


--
-- TOC entry 6421 (class 3256 OID 61743160)
-- Name: groups waper$478$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$478$stay_prod$groups" ON public.groups FOR SELECT TO "waper$478$stay_prod" USING ((tenant_id = '478'::text));


--
-- TOC entry 6263 (class 3256 OID 74898)
-- Name: groups waper$481$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$481$stay_prod$groups" ON public.groups FOR SELECT TO "waper$481$stay_prod" USING ((tenant_id = '481'::text));


--
-- TOC entry 6433 (class 3256 OID 68920673)
-- Name: groups waper$490$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$490$stay_prod$groups" ON public.groups FOR SELECT TO "waper$490$stay_prod" USING ((tenant_id = '490'::text));


--
-- TOC entry 6309 (class 3256 OID 75865)
-- Name: groups waper$494$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$494$stay_prod$groups" ON public.groups FOR SELECT TO "waper$494$stay_prod" USING ((tenant_id = '494'::text));


--
-- TOC entry 6288 (class 3256 OID 75424)
-- Name: groups waper$518$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$518$stay_prod$groups" ON public.groups FOR SELECT TO "waper$518$stay_prod" USING ((tenant_id = '518'::text));


--
-- TOC entry 6321 (class 3256 OID 355319)
-- Name: groups waper$529$287$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$287$stay_prod$groups" ON public.groups FOR SELECT TO "waper$529$287$stay_prod" USING (((tenant_id = '529'::text) AND (property_id = '287'::text)));


--
-- TOC entry 6255 (class 3256 OID 74730)
-- Name: groups waper$529$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$stay_prod$groups" ON public.groups FOR SELECT TO "waper$529$stay_prod" USING ((tenant_id = '529'::text));


--
-- TOC entry 6372 (class 3256 OID 14546094)
-- Name: groups waper$537$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$537$stay_prod$groups" ON public.groups FOR SELECT TO "waper$537$stay_prod" USING ((tenant_id = '537'::text));


--
-- TOC entry 6265 (class 3256 OID 74940)
-- Name: groups waper$554$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$554$stay_prod$groups" ON public.groups FOR SELECT TO "waper$554$stay_prod" USING ((tenant_id = '554'::text));


--
-- TOC entry 6478 (class 3256 OID 151313448)
-- Name: groups waper$588$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$588$stay_prod$groups" ON public.groups FOR SELECT TO "waper$588$stay_prod" USING ((tenant_id = '588'::text));


--
-- TOC entry 6287 (class 3256 OID 75403)
-- Name: groups waper$590$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$590$stay_prod$groups" ON public.groups FOR SELECT TO "waper$590$stay_prod" USING ((tenant_id = '590'::text));


--
-- TOC entry 6312 (class 3256 OID 75928)
-- Name: groups waper$592$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$592$stay_prod$groups" ON public.groups FOR SELECT TO "waper$592$stay_prod" USING ((tenant_id = '592'::text));


--
-- TOC entry 6434 (class 3256 OID 68920674)
-- Name: groups waper$616$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$616$stay_prod$groups" ON public.groups FOR SELECT TO "waper$616$stay_prod" USING ((tenant_id = '616'::text));


--
-- TOC entry 6481 (class 3256 OID 172314448)
-- Name: groups waper$648$643$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$643$stay_prod$groups" ON public.groups FOR SELECT TO "waper$648$643$stay_prod" USING (((tenant_id = '648'::text) AND (property_id = '643'::text)));


--
-- TOC entry 6418 (class 3256 OID 59504656)
-- Name: groups waper$648$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$stay_prod$groups" ON public.groups FOR SELECT TO "waper$648$stay_prod" USING ((tenant_id = '648'::text));


--
-- TOC entry 6337 (class 3256 OID 18313198)
-- Name: groups waper$657$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$657$stay_prod$groups" ON public.groups FOR SELECT TO "waper$657$stay_prod" USING ((tenant_id = '657'::text));


--
-- TOC entry 6408 (class 3256 OID 55374291)
-- Name: groups waper$663$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$663$stay_prod$groups" ON public.groups FOR SELECT TO "waper$663$stay_prod" USING ((tenant_id = '663'::text));


--
-- TOC entry 6424 (class 3256 OID 64532791)
-- Name: groups waper$686$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$686$stay_prod$groups" ON public.groups FOR SELECT TO "waper$686$stay_prod" USING ((tenant_id = '686'::text));


--
-- TOC entry 6403 (class 3256 OID 50618182)
-- Name: groups waper$688$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$688$stay_prod$groups" ON public.groups FOR SELECT TO "waper$688$stay_prod" USING ((tenant_id = '688'::text));


--
-- TOC entry 6252 (class 3256 OID 74667)
-- Name: groups waper$690$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$690$stay_prod$groups" ON public.groups FOR SELECT TO "waper$690$stay_prod" USING ((tenant_id = '690'::text));


--
-- TOC entry 6392 (class 3256 OID 37886727)
-- Name: groups waper$710$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$710$stay_prod$groups" ON public.groups FOR SELECT TO "waper$710$stay_prod" USING ((tenant_id = '710'::text));


--
-- TOC entry 6455 (class 3256 OID 76022833)
-- Name: groups waper$734$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$734$stay_prod$groups" ON public.groups FOR SELECT TO "waper$734$stay_prod" USING ((tenant_id = '734'::text));


--
-- TOC entry 6422 (class 3256 OID 61743161)
-- Name: groups waper$761$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$761$stay_prod$groups" ON public.groups FOR SELECT TO "waper$761$stay_prod" USING ((tenant_id = '761'::text));


--
-- TOC entry 6303 (class 3256 OID 75739)
-- Name: groups waper$764$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$764$stay_prod$groups" ON public.groups FOR SELECT TO "waper$764$stay_prod" USING ((tenant_id = '764'::text));


--
-- TOC entry 6283 (class 3256 OID 75319)
-- Name: groups waper$766$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$766$stay_prod$groups" ON public.groups FOR SELECT TO "waper$766$stay_prod" USING ((tenant_id = '766'::text));


--
-- TOC entry 6381 (class 3256 OID 28319303)
-- Name: groups waper$818$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$818$stay_prod$groups" ON public.groups FOR SELECT TO "waper$818$stay_prod" USING ((tenant_id = '818'::text));


--
-- TOC entry 6307 (class 3256 OID 75823)
-- Name: groups waper$871$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$871$stay_prod$groups" ON public.groups FOR SELECT TO "waper$871$stay_prod" USING ((tenant_id = '871'::text));


--
-- TOC entry 6278 (class 3256 OID 75214)
-- Name: groups waper$872$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$872$stay_prod$groups" ON public.groups FOR SELECT TO "waper$872$stay_prod" USING ((tenant_id = '872'::text));


--
-- TOC entry 6292 (class 3256 OID 75508)
-- Name: groups waper$874$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$874$stay_prod$groups" ON public.groups FOR SELECT TO "waper$874$stay_prod" USING ((tenant_id = '874'::text));


--
-- TOC entry 6275 (class 3256 OID 75151)
-- Name: groups waper$883$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$883$stay_prod$groups" ON public.groups FOR SELECT TO "waper$883$stay_prod" USING ((tenant_id = '883'::text));


--
-- TOC entry 6274 (class 3256 OID 75130)
-- Name: groups waper$884$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$884$stay_prod$groups" ON public.groups FOR SELECT TO "waper$884$stay_prod" USING ((tenant_id = '884'::text));


--
-- TOC entry 6273 (class 3256 OID 75108)
-- Name: groups waper$885$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$885$stay_prod$groups" ON public.groups FOR SELECT TO "waper$885$stay_prod" USING ((tenant_id = '885'::text));


--
-- TOC entry 6279 (class 3256 OID 75235)
-- Name: groups waper$901$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$901$stay_prod$groups" ON public.groups FOR SELECT TO "waper$901$stay_prod" USING ((tenant_id = '901'::text));


--
-- TOC entry 6468 (class 3256 OID 94763331)
-- Name: groups waper$908$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$908$stay_prod$groups" ON public.groups FOR SELECT TO "waper$908$stay_prod" USING ((tenant_id = '908'::text));


--
-- TOC entry 6368 (class 3256 OID 4638316)
-- Name: groups waper$923$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$923$stay_prod$groups" ON public.groups FOR SELECT TO "waper$923$stay_prod" USING ((tenant_id = '923'::text));


--
-- TOC entry 6302 (class 3256 OID 75718)
-- Name: groups waper$924$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$924$stay_prod$groups" ON public.groups FOR SELECT TO "waper$924$stay_prod" USING ((tenant_id = '924'::text));


--
-- TOC entry 6299 (class 3256 OID 75655)
-- Name: groups waper$930$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$930$stay_prod$groups" ON public.groups FOR SELECT TO "waper$930$stay_prod" USING ((tenant_id = '930'::text));


--
-- TOC entry 6296 (class 3256 OID 75592)
-- Name: groups waper$932$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$932$stay_prod$groups" ON public.groups FOR SELECT TO "waper$932$stay_prod" USING ((tenant_id = '932'::text));


--
-- TOC entry 6262 (class 3256 OID 74877)
-- Name: groups waper$933$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$933$stay_prod$groups" ON public.groups FOR SELECT TO "waper$933$stay_prod" USING ((tenant_id = '933'::text));


--
-- TOC entry 6268 (class 3256 OID 75003)
-- Name: groups waper$934$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$934$stay_prod$groups" ON public.groups FOR SELECT TO "waper$934$stay_prod" USING ((tenant_id = '934'::text));


--
-- TOC entry 6297 (class 3256 OID 75613)
-- Name: groups waper$936$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$936$stay_prod$groups" ON public.groups FOR SELECT TO "waper$936$stay_prod" USING ((tenant_id = '936'::text));


--
-- TOC entry 6308 (class 3256 OID 75844)
-- Name: groups waper$937$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$937$stay_prod$groups" ON public.groups FOR SELECT TO "waper$937$stay_prod" USING ((tenant_id = '937'::text));


--
-- TOC entry 6257 (class 3256 OID 74772)
-- Name: groups waper$939$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$939$stay_prod$groups" ON public.groups FOR SELECT TO "waper$939$stay_prod" USING ((tenant_id = '939'::text));


--
-- TOC entry 6300 (class 3256 OID 75676)
-- Name: groups waper$940$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$940$stay_prod$groups" ON public.groups FOR SELECT TO "waper$940$stay_prod" USING ((tenant_id = '940'::text));


--
-- TOC entry 6382 (class 3256 OID 29004000)
-- Name: groups waper$950$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$950$stay_prod$groups" ON public.groups FOR SELECT TO "waper$950$stay_prod" USING ((tenant_id = '950'::text));


--
-- TOC entry 6437 (class 3256 OID 71867270)
-- Name: groups waper$974$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$974$stay_prod$groups" ON public.groups FOR SELECT TO "waper$974$stay_prod" USING ((tenant_id = '974'::text));


--
-- TOC entry 6474 (class 3256 OID 134516891)
-- Name: groups waper$999$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$999$stay_prod$groups" ON public.groups FOR SELECT TO "waper$999$stay_prod" USING ((tenant_id = '999'::text));


--
-- TOC entry 6280 (class 3256 OID 75256)
-- Name: groups waper$victors$stay_prod$groups; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$victors$stay_prod$groups" ON public.groups FOR SELECT TO "waper$Victors$stay_prod" USING ((tenant_id = 'Victors'::text));


--
-- TOC entry 6487 (class 0 OID 0)
-- Dependencies: 1442
-- Name: FUNCTION pg_buffercache_pages(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_buffercache_pages() TO PUBLIC;


--
-- TOC entry 6488 (class 0 OID 0)
-- Dependencies: 1440
-- Name: FUNCTION pg_stat_statements_reset(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_stat_statements_reset() TO PUBLIC;


--
-- TOC entry 6489 (class 0 OID 0)
-- Dependencies: 1260
-- Name: TABLE groups; Type: ACL; Schema: public; Owner: agilysys
--

GRANT SELECT ON TABLE public.groups TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.groups TO agilysys_rillingp;
GRANT SELECT ON TABLE public.groups TO stayrouser;
GRANT SELECT ON TABLE public.groups TO stayreprouser;
GRANT SELECT ON TABLE public.groups TO stayreaderuser;


--
-- TOC entry 6490 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TABLE pg_buffercache; Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT SELECT ON TABLE public.pg_buffercache TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_buffercache TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_buffercache TO stayrouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreprouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreaderuser;


--
-- TOC entry 6491 (class 0 OID 0)
-- Dependencies: 1242
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: public; Owner: azure_superuser
--

REVOKE SELECT ON TABLE public.pg_stat_statements FROM PUBLIC;
GRANT SELECT ON TABLE public.pg_stat_statements TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayrouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreprouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreaderuser;


-- Completed on 2024-04-17 14:05:27

--
-- PostgreSQL database dump complete
--

