--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 16.0

-- Started on 2024-04-17 14:13:39

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
-- TOC entry 1254 (class 1259 OID 20947)
-- Name: allocations; Type: TABLE; Schema: public; Owner: agilysys
--

CREATE TABLE public.allocations (
    id text NOT NULL,
    allocation_type text,
    create_time timestamp without time zone,
    end_time time without time zone,
    reference_id text,
    property_id text,
    tenant_id text,
    update_time timestamp without time zone,
    blocked_by text,
    blocked_on timestamp without time zone,
    cleared_by text,
    cleared_on timestamp without time zone,
    start_date date,
    end_date date,
    reason text,
    room_id text,
    inventory_block_type text,
    inventory_expiry_time time without time zone,
    inventory_block_reason text,
    maintenance_services text[]
);


ALTER TABLE public.allocations OWNER TO agilysys;

--
-- TOC entry 6119 (class 2606 OID 20954)
-- Name: allocations allocations_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.allocations
    ADD CONSTRAINT allocations_pkey PRIMARY KEY (id);


--
-- TOC entry 6120 (class 1259 OID 4167956)
-- Name: idx_allocations_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_allocations_tid_pid_id ON public.allocations USING btree (tenant_id, property_id, id);


--
-- TOC entry 6121 (class 1259 OID 160345259)
-- Name: idx_allocations_tid_pid_roomid_allocationtype; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_allocations_tid_pid_roomid_allocationtype ON public.allocations USING btree (tenant_id, property_id, room_id, allocation_type);


--
-- TOC entry 6246 (class 0 OID 20947)
-- Dependencies: 1254
-- Name: allocations; Type: ROW SECURITY; Schema: public; Owner: agilysys
--

ALTER TABLE public.allocations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6261 (class 3256 OID 74958)
-- Name: allocations waper$0$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$0$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$0$stay_prod" USING ((tenant_id = '0'::text));


--
-- TOC entry 6262 (class 3256 OID 74979)
-- Name: allocations waper$100$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$100$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$100$stay_prod" USING ((tenant_id = '100'::text));


--
-- TOC entry 6271 (class 3256 OID 75169)
-- Name: allocations waper$101$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$101$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$101$stay_prod" USING ((tenant_id = '101'::text));


--
-- TOC entry 6272 (class 3256 OID 75190)
-- Name: allocations waper$102$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$102$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$102$stay_prod" USING ((tenant_id = '102'::text));


--
-- TOC entry 6300 (class 3256 OID 75778)
-- Name: allocations waper$1021$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1021$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1021$stay_prod" USING ((tenant_id = '1021'::text));


--
-- TOC entry 6305 (class 3256 OID 75883)
-- Name: allocations waper$1022$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1022$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1022$stay_prod" USING ((tenant_id = '1022'::text));


--
-- TOC entry 6286 (class 3256 OID 75484)
-- Name: allocations waper$1023$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1023$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1023$stay_prod" USING ((tenant_id = '1023'::text));


--
-- TOC entry 6308 (class 3256 OID 75946)
-- Name: allocations waper$1024$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1024$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1024$stay_prod" USING ((tenant_id = '1024'::text));


--
-- TOC entry 6418 (class 3256 OID 62482416)
-- Name: allocations waper$1025$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1025$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1025$stay_prod" USING ((tenant_id = '1025'::text));


--
-- TOC entry 6301 (class 3256 OID 75799)
-- Name: allocations waper$103$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$103$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$103$stay_prod" USING ((tenant_id = '103'::text));


--
-- TOC entry 6280 (class 3256 OID 75358)
-- Name: allocations waper$1036$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1036$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1036$stay_prod" USING ((tenant_id = '1036'::text));


--
-- TOC entry 6336 (class 3256 OID 2457920)
-- Name: allocations waper$1038$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1038$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1038$stay_prod" USING ((tenant_id = '1038'::text));


--
-- TOC entry 6309 (class 3256 OID 81203)
-- Name: allocations waper$1039$346$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$346$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1039$346$stay_prod" USING (((tenant_id = '1039'::text) AND (property_id = '346'::text)));


--
-- TOC entry 6264 (class 3256 OID 75021)
-- Name: allocations waper$1039$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1039$stay_prod" USING ((tenant_id = '1039'::text));


--
-- TOC entry 6256 (class 3256 OID 74853)
-- Name: allocations waper$104$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$104$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$104$stay_prod" USING ((tenant_id = '104'::text));


--
-- TOC entry 6281 (class 3256 OID 75379)
-- Name: allocations waper$105$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$105$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$105$stay_prod" USING ((tenant_id = '105'::text));


--
-- TOC entry 6254 (class 3256 OID 74811)
-- Name: allocations waper$1055$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1055$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1055$stay_prod" USING ((tenant_id = '1055'::text));


--
-- TOC entry 6265 (class 3256 OID 75042)
-- Name: allocations waper$1058$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1058$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1058$stay_prod" USING ((tenant_id = '1058'::text));


--
-- TOC entry 6248 (class 3256 OID 74685)
-- Name: allocations waper$106$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$106$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$106$stay_prod" USING ((tenant_id = '106'::text));


--
-- TOC entry 6381 (class 3256 OID 34722552)
-- Name: allocations waper$1060$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1060$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1060$stay_prod" USING ((tenant_id = '1060'::text));


--
-- TOC entry 6296 (class 3256 OID 75694)
-- Name: allocations waper$1061$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1061$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1061$stay_prod" USING ((tenant_id = '1061'::text));


--
-- TOC entry 6251 (class 3256 OID 74748)
-- Name: allocations waper$108$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$108$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$108$stay_prod" USING ((tenant_id = '108'::text));


--
-- TOC entry 6253 (class 3256 OID 74790)
-- Name: allocations waper$109$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$109$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$109$stay_prod" USING ((tenant_id = '109'::text));


--
-- TOC entry 6255 (class 3256 OID 74832)
-- Name: allocations waper$1092$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1092$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1092$stay_prod" USING ((tenant_id = '1092'::text));


--
-- TOC entry 6276 (class 3256 OID 75274)
-- Name: allocations waper$110$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$110$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$110$stay_prod" USING ((tenant_id = '110'::text));


--
-- TOC entry 6458 (class 3256 OID 85490290)
-- Name: allocations waper$1107$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1107$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1107$stay_prod" USING ((tenant_id = '1107'::text));


--
-- TOC entry 6293 (class 3256 OID 75631)
-- Name: allocations waper$1116$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1116$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1116$stay_prod" USING ((tenant_id = '1116'::text));


--
-- TOC entry 6259 (class 3256 OID 74916)
-- Name: allocations waper$1132$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1132$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1132$stay_prod" USING ((tenant_id = '1132'::text));


--
-- TOC entry 6277 (class 3256 OID 75295)
-- Name: allocations waper$1166$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1166$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1166$stay_prod" USING ((tenant_id = '1166'::text));


--
-- TOC entry 6288 (class 3256 OID 75526)
-- Name: allocations waper$1167$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1167$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1167$stay_prod" USING ((tenant_id = '1167'::text));


--
-- TOC entry 6396 (class 3256 OID 50618118)
-- Name: allocations waper$1180$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1180$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1180$stay_prod" USING ((tenant_id = '1180'::text));


--
-- TOC entry 6310 (class 3256 OID 142462)
-- Name: allocations waper$1181$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1181$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1181$stay_prod" USING ((tenant_id = '1181'::text));


--
-- TOC entry 6311 (class 3256 OID 142488)
-- Name: allocations waper$1184$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1184$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1184$stay_prod" USING ((tenant_id = '1184'::text));


--
-- TOC entry 6327 (class 3256 OID 1893289)
-- Name: allocations waper$1188$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1188$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1188$stay_prod" USING ((tenant_id = '1188'::text));


--
-- TOC entry 6313 (class 3256 OID 175391)
-- Name: allocations waper$1189$388$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$388$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1189$388$stay_prod" USING (((tenant_id = '1189'::text) AND (property_id = '388'::text)));


--
-- TOC entry 6312 (class 3256 OID 142533)
-- Name: allocations waper$1189$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1189$stay_prod" USING ((tenant_id = '1189'::text));


--
-- TOC entry 6475 (class 3256 OID 170364454)
-- Name: allocations waper$1207$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1207$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1207$stay_prod" USING ((tenant_id = '1207'::text));


--
-- TOC entry 6361 (class 3256 OID 4193359)
-- Name: allocations waper$1209$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1209$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1209$stay_prod" USING ((tenant_id = '1209'::text));


--
-- TOC entry 6314 (class 3256 OID 240083)
-- Name: allocations waper$1211$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1211$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1211$stay_prod" USING ((tenant_id = '1211'::text));


--
-- TOC entry 6329 (class 3256 OID 1893291)
-- Name: allocations waper$1212$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1212$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1212$stay_prod" USING ((tenant_id = '1212'::text));


--
-- TOC entry 6406 (class 3256 OID 57224753)
-- Name: allocations waper$1213$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1213$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1213$stay_prod" USING ((tenant_id = '1213'::text));


--
-- TOC entry 6315 (class 3256 OID 240129)
-- Name: allocations waper$1218$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1218$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1218$stay_prod" USING ((tenant_id = '1218'::text));


--
-- TOC entry 6285 (class 3256 OID 75463)
-- Name: allocations waper$122$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$122$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$122$stay_prod" USING ((tenant_id = '122'::text));


--
-- TOC entry 6322 (class 3256 OID 1893284)
-- Name: allocations waper$1227$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1227$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1227$stay_prod" USING ((tenant_id = '1227'::text));


--
-- TOC entry 6323 (class 3256 OID 1893285)
-- Name: allocations waper$1228$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1228$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1228$stay_prod" USING ((tenant_id = '1228'::text));


--
-- TOC entry 6333 (class 3256 OID 1893295)
-- Name: allocations waper$1231$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1231$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1231$stay_prod" USING ((tenant_id = '1231'::text));


--
-- TOC entry 6466 (class 3256 OID 125071345)
-- Name: allocations waper$1232$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1232$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1232$stay_prod" USING ((tenant_id = '1232'::text));


--
-- TOC entry 6317 (class 3256 OID 561720)
-- Name: allocations waper$1236$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1236$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1236$stay_prod" USING ((tenant_id = '1236'::text));


--
-- TOC entry 6318 (class 3256 OID 561768)
-- Name: allocations waper$1253$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1253$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1253$stay_prod" USING ((tenant_id = '1253'::text));


--
-- TOC entry 6424 (class 3256 OID 67059200)
-- Name: allocations waper$1293$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1293$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1293$stay_prod" USING ((tenant_id = '1293'::text));


--
-- TOC entry 6389 (class 3256 OID 37886666)
-- Name: allocations waper$1298$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1298$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1298$stay_prod" USING ((tenant_id = '1298'::text));


--
-- TOC entry 6374 (class 3256 OID 26948078)
-- Name: allocations waper$1305$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1305$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1305$stay_prod" USING ((tenant_id = '1305'::text));


--
-- TOC entry 6324 (class 3256 OID 1893286)
-- Name: allocations waper$1318$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1318$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1318$stay_prod" USING ((tenant_id = '1318'::text));


--
-- TOC entry 6425 (class 3256 OID 67059201)
-- Name: allocations waper$1321$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1321$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1321$stay_prod" USING ((tenant_id = '1321'::text));


--
-- TOC entry 6331 (class 3256 OID 1893293)
-- Name: allocations waper$1330$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1330$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1330$stay_prod" USING ((tenant_id = '1330'::text));


--
-- TOC entry 6349 (class 3256 OID 2620891)
-- Name: allocations waper$1336$440$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$440$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1336$440$stay_prod" USING (((tenant_id = '1336'::text) AND (property_id = '440'::text)));


--
-- TOC entry 6332 (class 3256 OID 1893294)
-- Name: allocations waper$1336$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1336$stay_prod" USING ((tenant_id = '1336'::text));


--
-- TOC entry 6325 (class 3256 OID 1893287)
-- Name: allocations waper$1337$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1337$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1337$stay_prod" USING ((tenant_id = '1337'::text));


--
-- TOC entry 6330 (class 3256 OID 1893292)
-- Name: allocations waper$1339$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1339$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1339$stay_prod" USING ((tenant_id = '1339'::text));


--
-- TOC entry 6326 (class 3256 OID 1893288)
-- Name: allocations waper$1344$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1344$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1344$stay_prod" USING ((tenant_id = '1344'::text));


--
-- TOC entry 6319 (class 3256 OID 2125287)
-- Name: allocations waper$1373$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1373$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1373$stay_prod" USING ((tenant_id = '1373'::text));


--
-- TOC entry 6267 (class 3256 OID 75084)
-- Name: allocations waper$140$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$140$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$140$stay_prod" USING ((tenant_id = '140'::text));


--
-- TOC entry 6284 (class 3256 OID 75442)
-- Name: allocations waper$143$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$143$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$143$stay_prod" USING ((tenant_id = '143'::text));


--
-- TOC entry 6321 (class 3256 OID 2125289)
-- Name: allocations waper$1438$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1438$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1438$stay_prod" USING ((tenant_id = '1438'::text));


--
-- TOC entry 6320 (class 3256 OID 2125288)
-- Name: allocations waper$1439$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1439$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1439$stay_prod" USING ((tenant_id = '1439'::text));


--
-- TOC entry 6339 (class 3256 OID 2483458)
-- Name: allocations waper$1474$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1474$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1474$stay_prod" USING ((tenant_id = '1474'::text));


--
-- TOC entry 6338 (class 3256 OID 2483457)
-- Name: allocations waper$1480$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1480$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1480$stay_prod" USING ((tenant_id = '1480'::text));


--
-- TOC entry 6337 (class 3256 OID 2483456)
-- Name: allocations waper$1481$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1481$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1481$stay_prod" USING ((tenant_id = '1481'::text));


--
-- TOC entry 6345 (class 3256 OID 2567948)
-- Name: allocations waper$1483$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1483$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1483$stay_prod" USING ((tenant_id = '1483'::text));


--
-- TOC entry 6343 (class 3256 OID 2545574)
-- Name: allocations waper$1485$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1485$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1485$stay_prod" USING ((tenant_id = '1485'::text));


--
-- TOC entry 6344 (class 3256 OID 2564637)
-- Name: allocations waper$1487$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1487$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1487$stay_prod" USING ((tenant_id = '1487'::text));


--
-- TOC entry 6348 (class 3256 OID 2620890)
-- Name: allocations waper$1532$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1532$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1532$stay_prod" USING ((tenant_id = '1532'::text));


--
-- TOC entry 6347 (class 3256 OID 2620889)
-- Name: allocations waper$1533$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1533$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1533$stay_prod" USING ((tenant_id = '1533'::text));


--
-- TOC entry 6350 (class 3256 OID 2679372)
-- Name: allocations waper$1548$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1548$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1548$stay_prod" USING ((tenant_id = '1548'::text));


--
-- TOC entry 6352 (class 3256 OID 2690226)
-- Name: allocations waper$1551$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1551$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1551$stay_prod" USING ((tenant_id = '1551'::text));


--
-- TOC entry 6351 (class 3256 OID 2690225)
-- Name: allocations waper$1553$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1553$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1553$stay_prod" USING ((tenant_id = '1553'::text));


--
-- TOC entry 6342 (class 3256 OID 2820758)
-- Name: allocations waper$1565$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1565$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1565$stay_prod" USING ((tenant_id = '1565'::text));


--
-- TOC entry 6341 (class 3256 OID 2820757)
-- Name: allocations waper$1566$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1566$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1566$stay_prod" USING ((tenant_id = '1566'::text));


--
-- TOC entry 6340 (class 3256 OID 2805764)
-- Name: allocations waper$1568$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1568$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1568$stay_prod" USING ((tenant_id = '1568'::text));


--
-- TOC entry 6346 (class 3256 OID 2890250)
-- Name: allocations waper$1585$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1585$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1585$stay_prod" USING ((tenant_id = '1585'::text));


--
-- TOC entry 6353 (class 3256 OID 2892540)
-- Name: allocations waper$1586$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1586$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1586$stay_prod" USING ((tenant_id = '1586'::text));


--
-- TOC entry 6356 (class 3256 OID 2965765)
-- Name: allocations waper$1593$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1593$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1593$stay_prod" USING ((tenant_id = '1593'::text));


--
-- TOC entry 6355 (class 3256 OID 2965764)
-- Name: allocations waper$1595$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1595$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1595$stay_prod" USING ((tenant_id = '1595'::text));


--
-- TOC entry 6379 (class 3256 OID 31543634)
-- Name: allocations waper$1598$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1598$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1598$stay_prod" USING ((tenant_id = '1598'::text));


--
-- TOC entry 6354 (class 3256 OID 2965763)
-- Name: allocations waper$1599$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1599$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1599$stay_prod" USING ((tenant_id = '1599'::text));


--
-- TOC entry 6357 (class 3256 OID 3022582)
-- Name: allocations waper$1612$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1612$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1612$stay_prod" USING ((tenant_id = '1612'::text));


--
-- TOC entry 6334 (class 3256 OID 18313185)
-- Name: allocations waper$1613$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1613$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1613$stay_prod" USING ((tenant_id = '1613'::text));


--
-- TOC entry 6358 (class 3256 OID 3046343)
-- Name: allocations waper$1614$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1614$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1614$stay_prod" USING ((tenant_id = '1614'::text));


--
-- TOC entry 6359 (class 3256 OID 3078262)
-- Name: allocations waper$1615$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1615$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1615$stay_prod" USING ((tenant_id = '1615'::text));


--
-- TOC entry 6360 (class 3256 OID 3177021)
-- Name: allocations waper$1633$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1633$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1633$stay_prod" USING ((tenant_id = '1633'::text));


--
-- TOC entry 6362 (class 3256 OID 4193360)
-- Name: allocations waper$1673$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1673$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1673$stay_prod" USING ((tenant_id = '1673'::text));


--
-- TOC entry 6364 (class 3256 OID 4638305)
-- Name: allocations waper$1676$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1676$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1676$stay_prod" USING ((tenant_id = '1676'::text));


--
-- TOC entry 6289 (class 3256 OID 75547)
-- Name: allocations waper$171$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$171$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$171$stay_prod" USING ((tenant_id = '171'::text));


--
-- TOC entry 6366 (class 3256 OID 12238188)
-- Name: allocations waper$1730$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1730$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1730$stay_prod" USING ((tenant_id = '1730'::text));


--
-- TOC entry 6465 (class 3256 OID 101326917)
-- Name: allocations waper$1735$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1735$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1735$stay_prod" USING ((tenant_id = '1735'::text));


--
-- TOC entry 6365 (class 3256 OID 12238187)
-- Name: allocations waper$1738$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1738$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1738$stay_prod" USING ((tenant_id = '1738'::text));


--
-- TOC entry 6328 (class 3256 OID 1893290)
-- Name: allocations waper$177$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$177$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$177$stay_prod" USING ((tenant_id = '177'::text));


--
-- TOC entry 6371 (class 3256 OID 21984616)
-- Name: allocations waper$1791$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1791$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1791$stay_prod" USING ((tenant_id = '1791'::text));


--
-- TOC entry 6370 (class 3256 OID 21984615)
-- Name: allocations waper$1794$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1794$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1794$stay_prod" USING ((tenant_id = '1794'::text));


--
-- TOC entry 6434 (class 3256 OID 72906752)
-- Name: allocations waper$1805$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1805$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1805$stay_prod" USING ((tenant_id = '1805'::text));


--
-- TOC entry 6372 (class 3256 OID 26948076)
-- Name: allocations waper$1810$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1810$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1810$stay_prod" USING ((tenant_id = '1810'::text));


--
-- TOC entry 6373 (class 3256 OID 26948077)
-- Name: allocations waper$1815$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1815$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1815$stay_prod" USING ((tenant_id = '1815'::text));


--
-- TOC entry 6375 (class 3256 OID 27293565)
-- Name: allocations waper$1816$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1816$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1816$stay_prod" USING ((tenant_id = '1816'::text));


--
-- TOC entry 6410 (class 3256 OID 58058388)
-- Name: allocations waper$1832$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1832$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1832$stay_prod" USING ((tenant_id = '1832'::text));


--
-- TOC entry 6378 (class 3256 OID 31543633)
-- Name: allocations waper$1837$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1837$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1837$stay_prod" USING ((tenant_id = '1837'::text));


--
-- TOC entry 6382 (class 3256 OID 34722553)
-- Name: allocations waper$1838$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1838$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1838$stay_prod" USING ((tenant_id = '1838'::text));


--
-- TOC entry 6369 (class 3256 OID 32983146)
-- Name: allocations waper$1839$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1839$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1839$stay_prod" USING ((tenant_id = '1839'::text));


--
-- TOC entry 6368 (class 3256 OID 32983145)
-- Name: allocations waper$1841$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1841$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1841$stay_prod" USING ((tenant_id = '1841'::text));


--
-- TOC entry 6390 (class 3256 OID 37886667)
-- Name: allocations waper$1845$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1845$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1845$stay_prod" USING ((tenant_id = '1845'::text));


--
-- TOC entry 6380 (class 3256 OID 34722551)
-- Name: allocations waper$1846$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1846$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1846$stay_prod" USING ((tenant_id = '1846'::text));


--
-- TOC entry 6383 (class 3256 OID 36083771)
-- Name: allocations waper$1847$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1847$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1847$stay_prod" USING ((tenant_id = '1847'::text));


--
-- TOC entry 6386 (class 3256 OID 37886663)
-- Name: allocations waper$1851$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1851$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1851$stay_prod" USING ((tenant_id = '1851'::text));


--
-- TOC entry 6391 (class 3256 OID 37886668)
-- Name: allocations waper$1852$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1852$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1852$stay_prod" USING ((tenant_id = '1852'::text));


--
-- TOC entry 6388 (class 3256 OID 37886665)
-- Name: allocations waper$1854$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1854$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1854$stay_prod" USING ((tenant_id = '1854'::text));


--
-- TOC entry 6392 (class 3256 OID 37886669)
-- Name: allocations waper$1855$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1855$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1855$stay_prod" USING ((tenant_id = '1855'::text));


--
-- TOC entry 6385 (class 3256 OID 37886662)
-- Name: allocations waper$1856$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1856$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1856$stay_prod" USING ((tenant_id = '1856'::text));


--
-- TOC entry 6299 (class 3256 OID 75757)
-- Name: allocations waper$186$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$186$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$186$stay_prod" USING ((tenant_id = '186'::text));


--
-- TOC entry 6384 (class 3256 OID 37886661)
-- Name: allocations waper$1861$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1861$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1861$stay_prod" USING ((tenant_id = '1861'::text));


--
-- TOC entry 6394 (class 3256 OID 39891555)
-- Name: allocations waper$1864$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1864$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1864$stay_prod" USING ((tenant_id = '1864'::text));


--
-- TOC entry 6393 (class 3256 OID 39891554)
-- Name: allocations waper$1865$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1865$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1865$stay_prod" USING ((tenant_id = '1865'::text));


--
-- TOC entry 6400 (class 3256 OID 50618122)
-- Name: allocations waper$1891$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1891$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1891$stay_prod" USING ((tenant_id = '1891'::text));


--
-- TOC entry 6402 (class 3256 OID 50618124)
-- Name: allocations waper$1892$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1892$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1892$stay_prod" USING ((tenant_id = '1892'::text));


--
-- TOC entry 6397 (class 3256 OID 50618119)
-- Name: allocations waper$1906$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1906$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1906$stay_prod" USING ((tenant_id = '1906'::text));


--
-- TOC entry 6399 (class 3256 OID 50618121)
-- Name: allocations waper$1907$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1907$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1907$stay_prod" USING ((tenant_id = '1907'::text));


--
-- TOC entry 6435 (class 3256 OID 72906753)
-- Name: allocations waper$1910$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1910$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1910$stay_prod" USING ((tenant_id = '1910'::text));


--
-- TOC entry 6437 (class 3256 OID 72906755)
-- Name: allocations waper$1911$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1911$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1911$stay_prod" USING ((tenant_id = '1911'::text));


--
-- TOC entry 6401 (class 3256 OID 50618123)
-- Name: allocations waper$1917$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1917$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1917$stay_prod" USING ((tenant_id = '1917'::text));


--
-- TOC entry 6395 (class 3256 OID 50618117)
-- Name: allocations waper$1918$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1918$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1918$stay_prod" USING ((tenant_id = '1918'::text));


--
-- TOC entry 6433 (class 3256 OID 71866819)
-- Name: allocations waper$1919$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1919$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1919$stay_prod" USING ((tenant_id = '1919'::text));


--
-- TOC entry 6427 (class 3256 OID 68920636)
-- Name: allocations waper$1920$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1920$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1920$stay_prod" USING ((tenant_id = '1920'::text));


--
-- TOC entry 6420 (class 3256 OID 64532586)
-- Name: allocations waper$1930$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1930$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1930$stay_prod" USING ((tenant_id = '1930'::text));


--
-- TOC entry 6405 (class 3256 OID 54184341)
-- Name: allocations waper$1935$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1935$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1935$stay_prod" USING ((tenant_id = '1935'::text));


--
-- TOC entry 6414 (class 3256 OID 59518313)
-- Name: allocations waper$1936$623$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$623$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$623$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '623'::text)));


--
-- TOC entry 6448 (class 3256 OID 76022267)
-- Name: allocations waper$1936$682$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$682$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$682$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '682'::text)));


--
-- TOC entry 6445 (class 3256 OID 75783715)
-- Name: allocations waper$1936$683$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$683$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$683$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '683'::text)));


--
-- TOC entry 6446 (class 3256 OID 76022265)
-- Name: allocations waper$1936$684$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$684$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$684$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '684'::text)));


--
-- TOC entry 6436 (class 3256 OID 72906754)
-- Name: allocations waper$1936$703$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$703$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$703$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '703'::text)));


--
-- TOC entry 6438 (class 3256 OID 73780122)
-- Name: allocations waper$1936$713$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$713$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$713$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '713'::text)));


--
-- TOC entry 6441 (class 3256 OID 74872610)
-- Name: allocations waper$1936$715$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$715$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$715$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '715'::text)));


--
-- TOC entry 6444 (class 3256 OID 74872613)
-- Name: allocations waper$1936$716$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$716$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$716$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '716'::text)));


--
-- TOC entry 6443 (class 3256 OID 74872612)
-- Name: allocations waper$1936$717$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$717$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$717$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '717'::text)));


--
-- TOC entry 6442 (class 3256 OID 74872611)
-- Name: allocations waper$1936$718$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$718$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$718$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '718'::text)));


--
-- TOC entry 6449 (class 3256 OID 76022268)
-- Name: allocations waper$1936$722$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$722$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$722$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '722'::text)));


--
-- TOC entry 6447 (class 3256 OID 76022266)
-- Name: allocations waper$1936$725$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$725$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$725$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '725'::text)));


--
-- TOC entry 6451 (class 3256 OID 76022270)
-- Name: allocations waper$1936$726$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$726$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$726$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '726'::text)));


--
-- TOC entry 6408 (class 3256 OID 57224755)
-- Name: allocations waper$1936$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1936$stay_prod" USING ((tenant_id = '1936'::text));


--
-- TOC entry 6415 (class 3256 OID 60968289)
-- Name: allocations waper$1937$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1937$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1937$stay_prod" USING ((tenant_id = '1937'::text));


--
-- TOC entry 6412 (class 3256 OID 59504622)
-- Name: allocations waper$1938$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1938$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1938$stay_prod" USING ((tenant_id = '1938'::text));


--
-- TOC entry 6472 (class 3256 OID 151312703)
-- Name: allocations waper$1939$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1939$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1939$stay_prod" USING ((tenant_id = '1939'::text));


--
-- TOC entry 6474 (class 3256 OID 151312705)
-- Name: allocations waper$1942$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1942$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1942$stay_prod" USING ((tenant_id = '1942'::text));


--
-- TOC entry 6421 (class 3256 OID 67059197)
-- Name: allocations waper$1955$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1955$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1955$stay_prod" USING ((tenant_id = '1955'::text));


--
-- TOC entry 6422 (class 3256 OID 67059198)
-- Name: allocations waper$1956$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1956$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1956$stay_prod" USING ((tenant_id = '1956'::text));


--
-- TOC entry 6411 (class 3256 OID 59504621)
-- Name: allocations waper$1958$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1958$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1958$stay_prod" USING ((tenant_id = '1958'::text));


--
-- TOC entry 6454 (class 3256 OID 78083234)
-- Name: allocations waper$1961$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1961$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1961$stay_prod" USING ((tenant_id = '1961'::text));


--
-- TOC entry 6409 (class 3256 OID 57224756)
-- Name: allocations waper$1962$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1962$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1962$stay_prod" USING ((tenant_id = '1962'::text));


--
-- TOC entry 6407 (class 3256 OID 57224754)
-- Name: allocations waper$1966$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1966$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1966$stay_prod" USING ((tenant_id = '1966'::text));


--
-- TOC entry 6423 (class 3256 OID 67059199)
-- Name: allocations waper$1990$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1990$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1990$stay_prod" USING ((tenant_id = '1990'::text));


--
-- TOC entry 6426 (class 3256 OID 67059202)
-- Name: allocations waper$1991$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1991$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$1991$stay_prod" USING ((tenant_id = '1991'::text));


--
-- TOC entry 6430 (class 3256 OID 71866816)
-- Name: allocations waper$2001$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2001$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2001$stay_prod" USING ((tenant_id = '2001'::text));


--
-- TOC entry 6471 (class 3256 OID 151312702)
-- Name: allocations waper$2004$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2004$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2004$stay_prod" USING ((tenant_id = '2004'::text));


--
-- TOC entry 6439 (class 3256 OID 74869611)
-- Name: allocations waper$2025$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2025$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2025$stay_prod" USING ((tenant_id = '2025'::text));


--
-- TOC entry 6440 (class 3256 OID 74869612)
-- Name: allocations waper$2031$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2031$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2031$stay_prod" USING ((tenant_id = '2031'::text));


--
-- TOC entry 6431 (class 3256 OID 71866817)
-- Name: allocations waper$2038$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2038$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2038$stay_prod" USING ((tenant_id = '2038'::text));


--
-- TOC entry 6455 (class 3256 OID 78678919)
-- Name: allocations waper$2051$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2051$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2051$stay_prod" USING ((tenant_id = '2051'::text));


--
-- TOC entry 6460 (class 3256 OID 85490292)
-- Name: allocations waper$2062$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2062$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2062$stay_prod" USING ((tenant_id = '2062'::text));


--
-- TOC entry 6459 (class 3256 OID 85490291)
-- Name: allocations waper$2065$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2065$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2065$stay_prod" USING ((tenant_id = '2065'::text));


--
-- TOC entry 6453 (class 3256 OID 78083233)
-- Name: allocations waper$2068$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2068$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2068$stay_prod" USING ((tenant_id = '2068'::text));


--
-- TOC entry 6452 (class 3256 OID 78083232)
-- Name: allocations waper$2069$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2069$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2069$stay_prod" USING ((tenant_id = '2069'::text));


--
-- TOC entry 6467 (class 3256 OID 125071346)
-- Name: allocations waper$2078$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2078$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2078$stay_prod" USING ((tenant_id = '2078'::text));


--
-- TOC entry 6457 (class 3256 OID 85490289)
-- Name: allocations waper$2090$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2090$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2090$stay_prod" USING ((tenant_id = '2090'::text));


--
-- TOC entry 6456 (class 3256 OID 85490288)
-- Name: allocations waper$2091$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2091$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2091$stay_prod" USING ((tenant_id = '2091'::text));


--
-- TOC entry 6462 (class 3256 OID 92730855)
-- Name: allocations waper$2093$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2093$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2093$stay_prod" USING ((tenant_id = '2093'::text));


--
-- TOC entry 6461 (class 3256 OID 91133810)
-- Name: allocations waper$2094$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2094$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2094$stay_prod" USING ((tenant_id = '2094'::text));


--
-- TOC entry 6464 (class 3256 OID 94763310)
-- Name: allocations waper$2117$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2117$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2117$stay_prod" USING ((tenant_id = '2117'::text));


--
-- TOC entry 6468 (class 3256 OID 125071347)
-- Name: allocations waper$2145$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2145$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2145$stay_prod" USING ((tenant_id = '2145'::text));


--
-- TOC entry 6470 (class 3256 OID 151312701)
-- Name: allocations waper$2190$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2190$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$2190$stay_prod" USING ((tenant_id = '2190'::text));


--
-- TOC entry 6266 (class 3256 OID 75063)
-- Name: allocations waper$227$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$227$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$227$stay_prod" USING ((tenant_id = '227'::text));


--
-- TOC entry 6290 (class 3256 OID 75568)
-- Name: allocations waper$253$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$253$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$253$stay_prod" USING ((tenant_id = '253'::text));


--
-- TOC entry 6249 (class 3256 OID 74706)
-- Name: allocations waper$299$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$299$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$299$stay_prod" USING ((tenant_id = '299'::text));


--
-- TOC entry 6279 (class 3256 OID 75337)
-- Name: allocations waper$410$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$410$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$410$stay_prod" USING ((tenant_id = '410'::text));


--
-- TOC entry 6404 (class 3256 OID 54184340)
-- Name: allocations waper$458$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$458$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$458$stay_prod" USING ((tenant_id = '458'::text));


--
-- TOC entry 6306 (class 3256 OID 75904)
-- Name: allocations waper$460$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$460$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$460$stay_prod" USING ((tenant_id = '460'::text));


--
-- TOC entry 6416 (class 3256 OID 61743146)
-- Name: allocations waper$478$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$478$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$478$stay_prod" USING ((tenant_id = '478'::text));


--
-- TOC entry 6258 (class 3256 OID 74895)
-- Name: allocations waper$481$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$481$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$481$stay_prod" USING ((tenant_id = '481'::text));


--
-- TOC entry 6428 (class 3256 OID 68920637)
-- Name: allocations waper$490$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$490$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$490$stay_prod" USING ((tenant_id = '490'::text));


--
-- TOC entry 6304 (class 3256 OID 75862)
-- Name: allocations waper$494$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$494$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$494$stay_prod" USING ((tenant_id = '494'::text));


--
-- TOC entry 6283 (class 3256 OID 75421)
-- Name: allocations waper$518$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$518$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$518$stay_prod" USING ((tenant_id = '518'::text));


--
-- TOC entry 6316 (class 3256 OID 355339)
-- Name: allocations waper$529$287$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$287$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$529$287$stay_prod" USING (((tenant_id = '529'::text) AND (property_id = '287'::text)));


--
-- TOC entry 6250 (class 3256 OID 74727)
-- Name: allocations waper$529$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$529$stay_prod" USING ((tenant_id = '529'::text));


--
-- TOC entry 6367 (class 3256 OID 14545953)
-- Name: allocations waper$537$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$537$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$537$stay_prod" USING ((tenant_id = '537'::text));


--
-- TOC entry 6260 (class 3256 OID 74937)
-- Name: allocations waper$554$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$554$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$554$stay_prod" USING ((tenant_id = '554'::text));


--
-- TOC entry 6473 (class 3256 OID 151312704)
-- Name: allocations waper$588$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$588$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$588$stay_prod" USING ((tenant_id = '588'::text));


--
-- TOC entry 6282 (class 3256 OID 75400)
-- Name: allocations waper$590$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$590$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$590$stay_prod" USING ((tenant_id = '590'::text));


--
-- TOC entry 6307 (class 3256 OID 75925)
-- Name: allocations waper$592$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$592$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$592$stay_prod" USING ((tenant_id = '592'::text));


--
-- TOC entry 6429 (class 3256 OID 68920638)
-- Name: allocations waper$616$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$616$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$616$stay_prod" USING ((tenant_id = '616'::text));


--
-- TOC entry 6476 (class 3256 OID 172314436)
-- Name: allocations waper$648$643$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$643$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$648$643$stay_prod" USING (((tenant_id = '648'::text) AND (property_id = '643'::text)));


--
-- TOC entry 6413 (class 3256 OID 59504623)
-- Name: allocations waper$648$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$648$stay_prod" USING ((tenant_id = '648'::text));


--
-- TOC entry 6335 (class 3256 OID 18313186)
-- Name: allocations waper$657$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$657$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$657$stay_prod" USING ((tenant_id = '657'::text));


--
-- TOC entry 6403 (class 3256 OID 55373904)
-- Name: allocations waper$663$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$663$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$663$stay_prod" USING ((tenant_id = '663'::text));


--
-- TOC entry 6419 (class 3256 OID 64532585)
-- Name: allocations waper$686$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$686$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$686$stay_prod" USING ((tenant_id = '686'::text));


--
-- TOC entry 6398 (class 3256 OID 50618120)
-- Name: allocations waper$688$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$688$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$688$stay_prod" USING ((tenant_id = '688'::text));


--
-- TOC entry 6247 (class 3256 OID 74664)
-- Name: allocations waper$690$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$690$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$690$stay_prod" USING ((tenant_id = '690'::text));


--
-- TOC entry 6387 (class 3256 OID 37886664)
-- Name: allocations waper$710$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$710$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$710$stay_prod" USING ((tenant_id = '710'::text));


--
-- TOC entry 6450 (class 3256 OID 76022269)
-- Name: allocations waper$734$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$734$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$734$stay_prod" USING ((tenant_id = '734'::text));


--
-- TOC entry 6417 (class 3256 OID 61743147)
-- Name: allocations waper$761$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$761$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$761$stay_prod" USING ((tenant_id = '761'::text));


--
-- TOC entry 6298 (class 3256 OID 75736)
-- Name: allocations waper$764$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$764$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$764$stay_prod" USING ((tenant_id = '764'::text));


--
-- TOC entry 6278 (class 3256 OID 75316)
-- Name: allocations waper$766$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$766$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$766$stay_prod" USING ((tenant_id = '766'::text));


--
-- TOC entry 6376 (class 3256 OID 28319297)
-- Name: allocations waper$818$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$818$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$818$stay_prod" USING ((tenant_id = '818'::text));


--
-- TOC entry 6302 (class 3256 OID 75820)
-- Name: allocations waper$871$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$871$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$871$stay_prod" USING ((tenant_id = '871'::text));


--
-- TOC entry 6273 (class 3256 OID 75211)
-- Name: allocations waper$872$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$872$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$872$stay_prod" USING ((tenant_id = '872'::text));


--
-- TOC entry 6287 (class 3256 OID 75505)
-- Name: allocations waper$874$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$874$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$874$stay_prod" USING ((tenant_id = '874'::text));


--
-- TOC entry 6270 (class 3256 OID 75148)
-- Name: allocations waper$883$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$883$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$883$stay_prod" USING ((tenant_id = '883'::text));


--
-- TOC entry 6269 (class 3256 OID 75127)
-- Name: allocations waper$884$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$884$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$884$stay_prod" USING ((tenant_id = '884'::text));


--
-- TOC entry 6268 (class 3256 OID 75105)
-- Name: allocations waper$885$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$885$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$885$stay_prod" USING ((tenant_id = '885'::text));


--
-- TOC entry 6274 (class 3256 OID 75232)
-- Name: allocations waper$901$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$901$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$901$stay_prod" USING ((tenant_id = '901'::text));


--
-- TOC entry 6463 (class 3256 OID 94763309)
-- Name: allocations waper$908$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$908$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$908$stay_prod" USING ((tenant_id = '908'::text));


--
-- TOC entry 6363 (class 3256 OID 4638304)
-- Name: allocations waper$923$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$923$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$923$stay_prod" USING ((tenant_id = '923'::text));


--
-- TOC entry 6297 (class 3256 OID 75715)
-- Name: allocations waper$924$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$924$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$924$stay_prod" USING ((tenant_id = '924'::text));


--
-- TOC entry 6294 (class 3256 OID 75652)
-- Name: allocations waper$930$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$930$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$930$stay_prod" USING ((tenant_id = '930'::text));


--
-- TOC entry 6291 (class 3256 OID 75589)
-- Name: allocations waper$932$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$932$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$932$stay_prod" USING ((tenant_id = '932'::text));


--
-- TOC entry 6257 (class 3256 OID 74874)
-- Name: allocations waper$933$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$933$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$933$stay_prod" USING ((tenant_id = '933'::text));


--
-- TOC entry 6263 (class 3256 OID 75000)
-- Name: allocations waper$934$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$934$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$934$stay_prod" USING ((tenant_id = '934'::text));


--
-- TOC entry 6292 (class 3256 OID 75610)
-- Name: allocations waper$936$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$936$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$936$stay_prod" USING ((tenant_id = '936'::text));


--
-- TOC entry 6303 (class 3256 OID 75841)
-- Name: allocations waper$937$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$937$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$937$stay_prod" USING ((tenant_id = '937'::text));


--
-- TOC entry 6252 (class 3256 OID 74769)
-- Name: allocations waper$939$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$939$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$939$stay_prod" USING ((tenant_id = '939'::text));


--
-- TOC entry 6295 (class 3256 OID 75673)
-- Name: allocations waper$940$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$940$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$940$stay_prod" USING ((tenant_id = '940'::text));


--
-- TOC entry 6377 (class 3256 OID 29003993)
-- Name: allocations waper$950$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$950$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$950$stay_prod" USING ((tenant_id = '950'::text));


--
-- TOC entry 6432 (class 3256 OID 71866818)
-- Name: allocations waper$974$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$974$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$974$stay_prod" USING ((tenant_id = '974'::text));


--
-- TOC entry 6469 (class 3256 OID 134516166)
-- Name: allocations waper$999$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$999$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$999$stay_prod" USING ((tenant_id = '999'::text));


--
-- TOC entry 6275 (class 3256 OID 75253)
-- Name: allocations waper$victors$stay_prod$allocations; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$victors$stay_prod$allocations" ON public.allocations FOR SELECT TO "waper$Victors$stay_prod" USING ((tenant_id = 'Victors'::text));


--
-- TOC entry 6482 (class 0 OID 0)
-- Dependencies: 1442
-- Name: FUNCTION pg_buffercache_pages(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_buffercache_pages() TO PUBLIC;


--
-- TOC entry 6483 (class 0 OID 0)
-- Dependencies: 1440
-- Name: FUNCTION pg_stat_statements_reset(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_stat_statements_reset() TO PUBLIC;


--
-- TOC entry 6484 (class 0 OID 0)
-- Dependencies: 1254
-- Name: TABLE allocations; Type: ACL; Schema: public; Owner: agilysys
--

GRANT SELECT ON TABLE public.allocations TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.allocations TO agilysys_rillingp;
GRANT SELECT ON TABLE public.allocations TO stayrouser;
GRANT SELECT ON TABLE public.allocations TO stayreprouser;
GRANT SELECT ON TABLE public.allocations TO stayreaderuser;


--
-- TOC entry 6485 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TABLE pg_buffercache; Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT SELECT ON TABLE public.pg_buffercache TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_buffercache TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_buffercache TO stayrouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreprouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreaderuser;


--
-- TOC entry 6486 (class 0 OID 0)
-- Dependencies: 1242
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: public; Owner: azure_superuser
--

REVOKE SELECT ON TABLE public.pg_stat_statements FROM PUBLIC;
GRANT SELECT ON TABLE public.pg_stat_statements TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayrouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreprouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreaderuser;


-- Completed on 2024-04-17 14:13:48

--
-- PostgreSQL database dump complete
--

