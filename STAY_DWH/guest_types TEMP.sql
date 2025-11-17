--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 16.0

-- Started on 2024-04-17 14:03:03

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
-- TOC entry 1274 (class 1259 OID 238430)
-- Name: guest_types; Type: TABLE; Schema: public; Owner: agilysys
--

CREATE TABLE public.guest_types (
    tenant_id text NOT NULL,
    property_id text NOT NULL,
    id text NOT NULL,
    name text,
    code text,
    gl_code text,
    active boolean
);


ALTER TABLE public.guest_types OWNER TO agilysys;

--
-- TOC entry 6119 (class 2606 OID 238437)
-- Name: guest_types guest_type_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.guest_types
    ADD CONSTRAINT guest_type_pkey PRIMARY KEY (tenant_id, property_id, id);


--
-- TOC entry 6244 (class 0 OID 238430)
-- Dependencies: 1274
-- Name: guest_types; Type: ROW SECURITY; Schema: public; Owner: agilysys
--

ALTER TABLE public.guest_types ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6259 (class 3256 OID 239680)
-- Name: guest_types waper$0$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$0$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$0$stay_prod" USING ((tenant_id = '0'::text));


--
-- TOC entry 6260 (class 3256 OID 239687)
-- Name: guest_types waper$100$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$100$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$100$stay_prod" USING ((tenant_id = '100'::text));


--
-- TOC entry 6269 (class 3256 OID 239750)
-- Name: guest_types waper$101$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$101$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$101$stay_prod" USING ((tenant_id = '101'::text));


--
-- TOC entry 6270 (class 3256 OID 239757)
-- Name: guest_types waper$102$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$102$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$102$stay_prod" USING ((tenant_id = '102'::text));


--
-- TOC entry 6298 (class 3256 OID 239953)
-- Name: guest_types waper$1021$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1021$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1021$stay_prod" USING ((tenant_id = '1021'::text));


--
-- TOC entry 6303 (class 3256 OID 239988)
-- Name: guest_types waper$1022$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1022$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1022$stay_prod" USING ((tenant_id = '1022'::text));


--
-- TOC entry 6284 (class 3256 OID 239855)
-- Name: guest_types waper$1023$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1023$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1023$stay_prod" USING ((tenant_id = '1023'::text));


--
-- TOC entry 6306 (class 3256 OID 240009)
-- Name: guest_types waper$1024$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1024$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1024$stay_prod" USING ((tenant_id = '1024'::text));


--
-- TOC entry 6418 (class 3256 OID 62482228)
-- Name: guest_types waper$1025$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1025$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1025$stay_prod" USING ((tenant_id = '1025'::text));


--
-- TOC entry 6299 (class 3256 OID 239960)
-- Name: guest_types waper$103$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$103$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$103$stay_prod" USING ((tenant_id = '103'::text));


--
-- TOC entry 6278 (class 3256 OID 239813)
-- Name: guest_types waper$1036$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1036$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1036$stay_prod" USING ((tenant_id = '1036'::text));


--
-- TOC entry 6334 (class 3256 OID 2457900)
-- Name: guest_types waper$1038$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1038$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1038$stay_prod" USING ((tenant_id = '1038'::text));


--
-- TOC entry 6307 (class 3256 OID 240016)
-- Name: guest_types waper$1039$346$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$346$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1039$346$stay_prod" USING (((tenant_id = '1039'::text) AND (property_id = '346'::text)));


--
-- TOC entry 6262 (class 3256 OID 239701)
-- Name: guest_types waper$1039$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1039$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1039$stay_prod" USING ((tenant_id = '1039'::text));


--
-- TOC entry 6254 (class 3256 OID 239645)
-- Name: guest_types waper$104$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$104$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$104$stay_prod" USING ((tenant_id = '104'::text));


--
-- TOC entry 6279 (class 3256 OID 239820)
-- Name: guest_types waper$105$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$105$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$105$stay_prod" USING ((tenant_id = '105'::text));


--
-- TOC entry 6252 (class 3256 OID 239631)
-- Name: guest_types waper$1055$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1055$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1055$stay_prod" USING ((tenant_id = '1055'::text));


--
-- TOC entry 6263 (class 3256 OID 239708)
-- Name: guest_types waper$1058$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1058$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1058$stay_prod" USING ((tenant_id = '1058'::text));


--
-- TOC entry 6246 (class 3256 OID 239589)
-- Name: guest_types waper$106$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$106$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$106$stay_prod" USING ((tenant_id = '106'::text));


--
-- TOC entry 6381 (class 3256 OID 34722468)
-- Name: guest_types waper$1060$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1060$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1060$stay_prod" USING ((tenant_id = '1060'::text));


--
-- TOC entry 6294 (class 3256 OID 239925)
-- Name: guest_types waper$1061$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1061$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1061$stay_prod" USING ((tenant_id = '1061'::text));


--
-- TOC entry 6249 (class 3256 OID 239610)
-- Name: guest_types waper$108$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$108$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$108$stay_prod" USING ((tenant_id = '108'::text));


--
-- TOC entry 6251 (class 3256 OID 239624)
-- Name: guest_types waper$109$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$109$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$109$stay_prod" USING ((tenant_id = '109'::text));


--
-- TOC entry 6253 (class 3256 OID 239638)
-- Name: guest_types waper$1092$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1092$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1092$stay_prod" USING ((tenant_id = '1092'::text));


--
-- TOC entry 6274 (class 3256 OID 239785)
-- Name: guest_types waper$110$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$110$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$110$stay_prod" USING ((tenant_id = '110'::text));


--
-- TOC entry 6456 (class 3256 OID 85489643)
-- Name: guest_types waper$1107$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1107$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1107$stay_prod" USING ((tenant_id = '1107'::text));


--
-- TOC entry 6291 (class 3256 OID 239904)
-- Name: guest_types waper$1116$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1116$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1116$stay_prod" USING ((tenant_id = '1116'::text));


--
-- TOC entry 6257 (class 3256 OID 239666)
-- Name: guest_types waper$1132$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1132$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1132$stay_prod" USING ((tenant_id = '1132'::text));


--
-- TOC entry 6275 (class 3256 OID 239792)
-- Name: guest_types waper$1166$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1166$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1166$stay_prod" USING ((tenant_id = '1166'::text));


--
-- TOC entry 6286 (class 3256 OID 239869)
-- Name: guest_types waper$1167$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1167$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1167$stay_prod" USING ((tenant_id = '1167'::text));


--
-- TOC entry 6397 (class 3256 OID 50617880)
-- Name: guest_types waper$1180$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1180$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1180$stay_prod" USING ((tenant_id = '1180'::text));


--
-- TOC entry 6308 (class 3256 OID 240023)
-- Name: guest_types waper$1181$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1181$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1181$stay_prod" USING ((tenant_id = '1181'::text));


--
-- TOC entry 6309 (class 3256 OID 240030)
-- Name: guest_types waper$1184$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1184$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1184$stay_prod" USING ((tenant_id = '1184'::text));


--
-- TOC entry 6310 (class 3256 OID 240037)
-- Name: guest_types waper$1188$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1188$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1188$stay_prod" USING ((tenant_id = '1188'::text));


--
-- TOC entry 6312 (class 3256 OID 240051)
-- Name: guest_types waper$1189$388$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$388$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1189$388$stay_prod" USING (((tenant_id = '1189'::text) AND (property_id = '388'::text)));


--
-- TOC entry 6311 (class 3256 OID 240044)
-- Name: guest_types waper$1189$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1189$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1189$stay_prod" USING ((tenant_id = '1189'::text));


--
-- TOC entry 6473 (class 3256 OID 170363950)
-- Name: guest_types waper$1207$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1207$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1207$stay_prod" USING ((tenant_id = '1207'::text));


--
-- TOC entry 6361 (class 3256 OID 4193191)
-- Name: guest_types waper$1209$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1209$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1209$stay_prod" USING ((tenant_id = '1209'::text));


--
-- TOC entry 6313 (class 3256 OID 240062)
-- Name: guest_types waper$1211$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1211$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1211$stay_prod" USING ((tenant_id = '1211'::text));


--
-- TOC entry 6327 (class 3256 OID 1892537)
-- Name: guest_types waper$1212$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1212$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1212$stay_prod" USING ((tenant_id = '1212'::text));


--
-- TOC entry 6406 (class 3256 OID 57224559)
-- Name: guest_types waper$1213$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1213$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1213$stay_prod" USING ((tenant_id = '1213'::text));


--
-- TOC entry 6314 (class 3256 OID 240108)
-- Name: guest_types waper$1218$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1218$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1218$stay_prod" USING ((tenant_id = '1218'::text));


--
-- TOC entry 6283 (class 3256 OID 239848)
-- Name: guest_types waper$122$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$122$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$122$stay_prod" USING ((tenant_id = '122'::text));


--
-- TOC entry 6321 (class 3256 OID 1892531)
-- Name: guest_types waper$1227$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1227$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1227$stay_prod" USING ((tenant_id = '1227'::text));


--
-- TOC entry 6322 (class 3256 OID 1892532)
-- Name: guest_types waper$1228$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1228$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1228$stay_prod" USING ((tenant_id = '1228'::text));


--
-- TOC entry 6331 (class 3256 OID 1892541)
-- Name: guest_types waper$1231$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1231$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1231$stay_prod" USING ((tenant_id = '1231'::text));


--
-- TOC entry 6464 (class 3256 OID 125070548)
-- Name: guest_types waper$1232$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1232$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1232$stay_prod" USING ((tenant_id = '1232'::text));


--
-- TOC entry 6319 (class 3256 OID 561731)
-- Name: guest_types waper$1236$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1236$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1236$stay_prod" USING ((tenant_id = '1236'::text));


--
-- TOC entry 6320 (class 3256 OID 561779)
-- Name: guest_types waper$1253$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1253$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1253$stay_prod" USING ((tenant_id = '1253'::text));


--
-- TOC entry 6422 (class 3256 OID 67058377)
-- Name: guest_types waper$1293$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1293$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1293$stay_prod" USING ((tenant_id = '1293'::text));


--
-- TOC entry 6389 (class 3256 OID 37885628)
-- Name: guest_types waper$1298$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1298$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1298$stay_prod" USING ((tenant_id = '1298'::text));


--
-- TOC entry 6374 (class 3256 OID 26947769)
-- Name: guest_types waper$1305$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1305$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1305$stay_prod" USING ((tenant_id = '1305'::text));


--
-- TOC entry 6323 (class 3256 OID 1892533)
-- Name: guest_types waper$1318$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1318$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1318$stay_prod" USING ((tenant_id = '1318'::text));


--
-- TOC entry 6423 (class 3256 OID 67058378)
-- Name: guest_types waper$1321$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1321$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1321$stay_prod" USING ((tenant_id = '1321'::text));


--
-- TOC entry 6329 (class 3256 OID 1892539)
-- Name: guest_types waper$1330$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1330$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1330$stay_prod" USING ((tenant_id = '1330'::text));


--
-- TOC entry 6349 (class 3256 OID 2620755)
-- Name: guest_types waper$1336$440$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$440$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1336$440$stay_prod" USING (((tenant_id = '1336'::text) AND (property_id = '440'::text)));


--
-- TOC entry 6330 (class 3256 OID 1892540)
-- Name: guest_types waper$1336$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1336$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1336$stay_prod" USING ((tenant_id = '1336'::text));


--
-- TOC entry 6324 (class 3256 OID 1892534)
-- Name: guest_types waper$1337$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1337$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1337$stay_prod" USING ((tenant_id = '1337'::text));


--
-- TOC entry 6328 (class 3256 OID 1892538)
-- Name: guest_types waper$1339$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1339$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1339$stay_prod" USING ((tenant_id = '1339'::text));


--
-- TOC entry 6325 (class 3256 OID 1892535)
-- Name: guest_types waper$1344$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1344$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1344$stay_prod" USING ((tenant_id = '1344'::text));


--
-- TOC entry 6316 (class 3256 OID 2125064)
-- Name: guest_types waper$1373$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1373$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1373$stay_prod" USING ((tenant_id = '1373'::text));


--
-- TOC entry 6265 (class 3256 OID 239722)
-- Name: guest_types waper$140$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$140$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$140$stay_prod" USING ((tenant_id = '140'::text));


--
-- TOC entry 6282 (class 3256 OID 239841)
-- Name: guest_types waper$143$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$143$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$143$stay_prod" USING ((tenant_id = '143'::text));


--
-- TOC entry 6318 (class 3256 OID 2125066)
-- Name: guest_types waper$1438$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1438$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1438$stay_prod" USING ((tenant_id = '1438'::text));


--
-- TOC entry 6317 (class 3256 OID 2125065)
-- Name: guest_types waper$1439$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1439$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1439$stay_prod" USING ((tenant_id = '1439'::text));


--
-- TOC entry 6337 (class 3256 OID 2483272)
-- Name: guest_types waper$1474$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1474$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1474$stay_prod" USING ((tenant_id = '1474'::text));


--
-- TOC entry 6336 (class 3256 OID 2483271)
-- Name: guest_types waper$1480$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1480$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1480$stay_prod" USING ((tenant_id = '1480'::text));


--
-- TOC entry 6335 (class 3256 OID 2483270)
-- Name: guest_types waper$1481$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1481$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1481$stay_prod" USING ((tenant_id = '1481'::text));


--
-- TOC entry 6345 (class 3256 OID 2567838)
-- Name: guest_types waper$1483$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1483$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1483$stay_prod" USING ((tenant_id = '1483'::text));


--
-- TOC entry 6343 (class 3256 OID 2544921)
-- Name: guest_types waper$1485$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1485$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1485$stay_prod" USING ((tenant_id = '1485'::text));


--
-- TOC entry 6344 (class 3256 OID 2564537)
-- Name: guest_types waper$1487$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1487$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1487$stay_prod" USING ((tenant_id = '1487'::text));


--
-- TOC entry 6348 (class 3256 OID 2620754)
-- Name: guest_types waper$1532$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1532$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1532$stay_prod" USING ((tenant_id = '1532'::text));


--
-- TOC entry 6347 (class 3256 OID 2620753)
-- Name: guest_types waper$1533$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1533$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1533$stay_prod" USING ((tenant_id = '1533'::text));


--
-- TOC entry 6350 (class 3256 OID 2679339)
-- Name: guest_types waper$1548$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1548$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1548$stay_prod" USING ((tenant_id = '1548'::text));


--
-- TOC entry 6353 (class 3256 OID 2690158)
-- Name: guest_types waper$1551$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1551$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1551$stay_prod" USING ((tenant_id = '1551'::text));


--
-- TOC entry 6352 (class 3256 OID 2690157)
-- Name: guest_types waper$1553$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1553$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1553$stay_prod" USING ((tenant_id = '1553'::text));


--
-- TOC entry 6342 (class 3256 OID 2820690)
-- Name: guest_types waper$1565$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1565$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1565$stay_prod" USING ((tenant_id = '1565'::text));


--
-- TOC entry 6341 (class 3256 OID 2820689)
-- Name: guest_types waper$1566$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1566$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1566$stay_prod" USING ((tenant_id = '1566'::text));


--
-- TOC entry 6340 (class 3256 OID 2805749)
-- Name: guest_types waper$1568$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1568$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1568$stay_prod" USING ((tenant_id = '1568'::text));


--
-- TOC entry 6346 (class 3256 OID 2890215)
-- Name: guest_types waper$1585$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1585$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1585$stay_prod" USING ((tenant_id = '1585'::text));


--
-- TOC entry 6351 (class 3256 OID 2892505)
-- Name: guest_types waper$1586$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1586$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1586$stay_prod" USING ((tenant_id = '1586'::text));


--
-- TOC entry 6356 (class 3256 OID 2965659)
-- Name: guest_types waper$1593$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1593$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1593$stay_prod" USING ((tenant_id = '1593'::text));


--
-- TOC entry 6355 (class 3256 OID 2965658)
-- Name: guest_types waper$1595$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1595$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1595$stay_prod" USING ((tenant_id = '1595'::text));


--
-- TOC entry 6379 (class 3256 OID 31543414)
-- Name: guest_types waper$1598$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1598$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1598$stay_prod" USING ((tenant_id = '1598'::text));


--
-- TOC entry 6354 (class 3256 OID 2965657)
-- Name: guest_types waper$1599$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1599$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1599$stay_prod" USING ((tenant_id = '1599'::text));


--
-- TOC entry 6357 (class 3256 OID 3022591)
-- Name: guest_types waper$1612$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1612$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1612$stay_prod" USING ((tenant_id = '1612'::text));


--
-- TOC entry 6332 (class 3256 OID 18313133)
-- Name: guest_types waper$1613$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1613$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1613$stay_prod" USING ((tenant_id = '1613'::text));


--
-- TOC entry 6358 (class 3256 OID 3046352)
-- Name: guest_types waper$1614$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1614$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1614$stay_prod" USING ((tenant_id = '1614'::text));


--
-- TOC entry 6359 (class 3256 OID 3078221)
-- Name: guest_types waper$1615$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1615$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1615$stay_prod" USING ((tenant_id = '1615'::text));


--
-- TOC entry 6360 (class 3256 OID 3176754)
-- Name: guest_types waper$1633$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1633$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1633$stay_prod" USING ((tenant_id = '1633'::text));


--
-- TOC entry 6362 (class 3256 OID 4193192)
-- Name: guest_types waper$1673$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1673$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1673$stay_prod" USING ((tenant_id = '1673'::text));


--
-- TOC entry 6364 (class 3256 OID 4638251)
-- Name: guest_types waper$1676$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1676$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1676$stay_prod" USING ((tenant_id = '1676'::text));


--
-- TOC entry 6287 (class 3256 OID 239876)
-- Name: guest_types waper$171$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$171$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$171$stay_prod" USING ((tenant_id = '171'::text));


--
-- TOC entry 6366 (class 3256 OID 12238128)
-- Name: guest_types waper$1730$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1730$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1730$stay_prod" USING ((tenant_id = '1730'::text));


--
-- TOC entry 6463 (class 3256 OID 101326880)
-- Name: guest_types waper$1735$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1735$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1735$stay_prod" USING ((tenant_id = '1735'::text));


--
-- TOC entry 6365 (class 3256 OID 12238127)
-- Name: guest_types waper$1738$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1738$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1738$stay_prod" USING ((tenant_id = '1738'::text));


--
-- TOC entry 6326 (class 3256 OID 1892536)
-- Name: guest_types waper$177$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$177$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$177$stay_prod" USING ((tenant_id = '177'::text));


--
-- TOC entry 6371 (class 3256 OID 21984431)
-- Name: guest_types waper$1791$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1791$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1791$stay_prod" USING ((tenant_id = '1791'::text));


--
-- TOC entry 6370 (class 3256 OID 21984430)
-- Name: guest_types waper$1794$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1794$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1794$stay_prod" USING ((tenant_id = '1794'::text));


--
-- TOC entry 6432 (class 3256 OID 72906600)
-- Name: guest_types waper$1805$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1805$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1805$stay_prod" USING ((tenant_id = '1805'::text));


--
-- TOC entry 6372 (class 3256 OID 26947767)
-- Name: guest_types waper$1810$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1810$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1810$stay_prod" USING ((tenant_id = '1810'::text));


--
-- TOC entry 6373 (class 3256 OID 26947768)
-- Name: guest_types waper$1815$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1815$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1815$stay_prod" USING ((tenant_id = '1815'::text));


--
-- TOC entry 6375 (class 3256 OID 27293531)
-- Name: guest_types waper$1816$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1816$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1816$stay_prod" USING ((tenant_id = '1816'::text));


--
-- TOC entry 6410 (class 3256 OID 58058350)
-- Name: guest_types waper$1832$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1832$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1832$stay_prod" USING ((tenant_id = '1832'::text));


--
-- TOC entry 6378 (class 3256 OID 31543413)
-- Name: guest_types waper$1837$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1837$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1837$stay_prod" USING ((tenant_id = '1837'::text));


--
-- TOC entry 6382 (class 3256 OID 34722469)
-- Name: guest_types waper$1838$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1838$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1838$stay_prod" USING ((tenant_id = '1838'::text));


--
-- TOC entry 6339 (class 3256 OID 32983090)
-- Name: guest_types waper$1839$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1839$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1839$stay_prod" USING ((tenant_id = '1839'::text));


--
-- TOC entry 6338 (class 3256 OID 32983089)
-- Name: guest_types waper$1841$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1841$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1841$stay_prod" USING ((tenant_id = '1841'::text));


--
-- TOC entry 6390 (class 3256 OID 37885629)
-- Name: guest_types waper$1845$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1845$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1845$stay_prod" USING ((tenant_id = '1845'::text));


--
-- TOC entry 6380 (class 3256 OID 34722467)
-- Name: guest_types waper$1846$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1846$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1846$stay_prod" USING ((tenant_id = '1846'::text));


--
-- TOC entry 6383 (class 3256 OID 36083016)
-- Name: guest_types waper$1847$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1847$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1847$stay_prod" USING ((tenant_id = '1847'::text));


--
-- TOC entry 6386 (class 3256 OID 37885625)
-- Name: guest_types waper$1851$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1851$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1851$stay_prod" USING ((tenant_id = '1851'::text));


--
-- TOC entry 6391 (class 3256 OID 37885630)
-- Name: guest_types waper$1852$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1852$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1852$stay_prod" USING ((tenant_id = '1852'::text));


--
-- TOC entry 6388 (class 3256 OID 37885627)
-- Name: guest_types waper$1854$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1854$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1854$stay_prod" USING ((tenant_id = '1854'::text));


--
-- TOC entry 6392 (class 3256 OID 37885631)
-- Name: guest_types waper$1855$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1855$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1855$stay_prod" USING ((tenant_id = '1855'::text));


--
-- TOC entry 6385 (class 3256 OID 37885624)
-- Name: guest_types waper$1856$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1856$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1856$stay_prod" USING ((tenant_id = '1856'::text));


--
-- TOC entry 6297 (class 3256 OID 239946)
-- Name: guest_types waper$186$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$186$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$186$stay_prod" USING ((tenant_id = '186'::text));


--
-- TOC entry 6384 (class 3256 OID 37885623)
-- Name: guest_types waper$1861$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1861$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1861$stay_prod" USING ((tenant_id = '1861'::text));


--
-- TOC entry 6395 (class 3256 OID 39890981)
-- Name: guest_types waper$1864$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1864$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1864$stay_prod" USING ((tenant_id = '1864'::text));


--
-- TOC entry 6394 (class 3256 OID 39890980)
-- Name: guest_types waper$1865$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1865$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1865$stay_prod" USING ((tenant_id = '1865'::text));


--
-- TOC entry 6401 (class 3256 OID 50617884)
-- Name: guest_types waper$1891$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1891$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1891$stay_prod" USING ((tenant_id = '1891'::text));


--
-- TOC entry 6403 (class 3256 OID 50617886)
-- Name: guest_types waper$1892$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1892$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1892$stay_prod" USING ((tenant_id = '1892'::text));


--
-- TOC entry 6398 (class 3256 OID 50617881)
-- Name: guest_types waper$1906$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1906$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1906$stay_prod" USING ((tenant_id = '1906'::text));


--
-- TOC entry 6400 (class 3256 OID 50617883)
-- Name: guest_types waper$1907$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1907$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1907$stay_prod" USING ((tenant_id = '1907'::text));


--
-- TOC entry 6433 (class 3256 OID 72906601)
-- Name: guest_types waper$1910$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1910$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1910$stay_prod" USING ((tenant_id = '1910'::text));


--
-- TOC entry 6435 (class 3256 OID 72906603)
-- Name: guest_types waper$1911$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1911$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1911$stay_prod" USING ((tenant_id = '1911'::text));


--
-- TOC entry 6402 (class 3256 OID 50617885)
-- Name: guest_types waper$1917$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1917$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1917$stay_prod" USING ((tenant_id = '1917'::text));


--
-- TOC entry 6396 (class 3256 OID 50617879)
-- Name: guest_types waper$1918$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1918$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1918$stay_prod" USING ((tenant_id = '1918'::text));


--
-- TOC entry 6431 (class 3256 OID 71865529)
-- Name: guest_types waper$1919$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1919$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1919$stay_prod" USING ((tenant_id = '1919'::text));


--
-- TOC entry 6425 (class 3256 OID 68920330)
-- Name: guest_types waper$1920$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1920$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1920$stay_prod" USING ((tenant_id = '1920'::text));


--
-- TOC entry 6369 (class 3256 OID 64532336)
-- Name: guest_types waper$1930$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1930$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1930$stay_prod" USING ((tenant_id = '1930'::text));


--
-- TOC entry 6405 (class 3256 OID 54184277)
-- Name: guest_types waper$1935$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1935$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1935$stay_prod" USING ((tenant_id = '1935'::text));


--
-- TOC entry 6414 (class 3256 OID 59518275)
-- Name: guest_types waper$1936$623$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$623$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$623$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '623'::text)));


--
-- TOC entry 6446 (class 3256 OID 76021266)
-- Name: guest_types waper$1936$682$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$682$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$682$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '682'::text)));


--
-- TOC entry 6443 (class 3256 OID 75783543)
-- Name: guest_types waper$1936$683$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$683$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$683$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '683'::text)));


--
-- TOC entry 6444 (class 3256 OID 76021264)
-- Name: guest_types waper$1936$684$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$684$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$684$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '684'::text)));


--
-- TOC entry 6434 (class 3256 OID 72906602)
-- Name: guest_types waper$1936$703$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$703$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$703$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '703'::text)));


--
-- TOC entry 6436 (class 3256 OID 73780073)
-- Name: guest_types waper$1936$713$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$713$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$713$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '713'::text)));


--
-- TOC entry 6439 (class 3256 OID 74872456)
-- Name: guest_types waper$1936$715$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$715$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$715$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '715'::text)));


--
-- TOC entry 6442 (class 3256 OID 74872459)
-- Name: guest_types waper$1936$716$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$716$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$716$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '716'::text)));


--
-- TOC entry 6441 (class 3256 OID 74872458)
-- Name: guest_types waper$1936$717$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$717$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$717$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '717'::text)));


--
-- TOC entry 6440 (class 3256 OID 74872457)
-- Name: guest_types waper$1936$718$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$718$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$718$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '718'::text)));


--
-- TOC entry 6447 (class 3256 OID 76021267)
-- Name: guest_types waper$1936$722$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$722$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$722$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '722'::text)));


--
-- TOC entry 6445 (class 3256 OID 76021265)
-- Name: guest_types waper$1936$725$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$725$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$725$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '725'::text)));


--
-- TOC entry 6449 (class 3256 OID 76021269)
-- Name: guest_types waper$1936$726$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$726$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$726$stay_prod" USING (((tenant_id = '1936'::text) AND (property_id = '726'::text)));


--
-- TOC entry 6408 (class 3256 OID 57224561)
-- Name: guest_types waper$1936$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1936$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1936$stay_prod" USING ((tenant_id = '1936'::text));


--
-- TOC entry 6415 (class 3256 OID 60968245)
-- Name: guest_types waper$1937$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1937$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1937$stay_prod" USING ((tenant_id = '1937'::text));


--
-- TOC entry 6412 (class 3256 OID 59504520)
-- Name: guest_types waper$1938$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1938$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1938$stay_prod" USING ((tenant_id = '1938'::text));


--
-- TOC entry 6470 (class 3256 OID 151311584)
-- Name: guest_types waper$1939$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1939$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1939$stay_prod" USING ((tenant_id = '1939'::text));


--
-- TOC entry 6472 (class 3256 OID 151311586)
-- Name: guest_types waper$1942$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1942$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1942$stay_prod" USING ((tenant_id = '1942'::text));


--
-- TOC entry 6419 (class 3256 OID 67058374)
-- Name: guest_types waper$1955$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1955$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1955$stay_prod" USING ((tenant_id = '1955'::text));


--
-- TOC entry 6420 (class 3256 OID 67058375)
-- Name: guest_types waper$1956$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1956$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1956$stay_prod" USING ((tenant_id = '1956'::text));


--
-- TOC entry 6411 (class 3256 OID 59504519)
-- Name: guest_types waper$1958$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1958$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1958$stay_prod" USING ((tenant_id = '1958'::text));


--
-- TOC entry 6452 (class 3256 OID 78083039)
-- Name: guest_types waper$1961$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1961$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1961$stay_prod" USING ((tenant_id = '1961'::text));


--
-- TOC entry 6409 (class 3256 OID 57224562)
-- Name: guest_types waper$1962$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1962$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1962$stay_prod" USING ((tenant_id = '1962'::text));


--
-- TOC entry 6407 (class 3256 OID 57224560)
-- Name: guest_types waper$1966$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1966$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1966$stay_prod" USING ((tenant_id = '1966'::text));


--
-- TOC entry 6421 (class 3256 OID 67058376)
-- Name: guest_types waper$1990$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1990$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1990$stay_prod" USING ((tenant_id = '1990'::text));


--
-- TOC entry 6424 (class 3256 OID 67058379)
-- Name: guest_types waper$1991$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$1991$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$1991$stay_prod" USING ((tenant_id = '1991'::text));


--
-- TOC entry 6428 (class 3256 OID 71865526)
-- Name: guest_types waper$2001$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2001$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2001$stay_prod" USING ((tenant_id = '2001'::text));


--
-- TOC entry 6469 (class 3256 OID 151311583)
-- Name: guest_types waper$2004$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2004$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2004$stay_prod" USING ((tenant_id = '2004'::text));


--
-- TOC entry 6437 (class 3256 OID 74869475)
-- Name: guest_types waper$2025$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2025$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2025$stay_prod" USING ((tenant_id = '2025'::text));


--
-- TOC entry 6438 (class 3256 OID 74869476)
-- Name: guest_types waper$2031$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2031$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2031$stay_prod" USING ((tenant_id = '2031'::text));


--
-- TOC entry 6429 (class 3256 OID 71865527)
-- Name: guest_types waper$2038$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2038$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2038$stay_prod" USING ((tenant_id = '2038'::text));


--
-- TOC entry 6453 (class 3256 OID 78678864)
-- Name: guest_types waper$2051$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2051$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2051$stay_prod" USING ((tenant_id = '2051'::text));


--
-- TOC entry 6458 (class 3256 OID 85489645)
-- Name: guest_types waper$2062$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2062$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2062$stay_prod" USING ((tenant_id = '2062'::text));


--
-- TOC entry 6457 (class 3256 OID 85489644)
-- Name: guest_types waper$2065$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2065$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2065$stay_prod" USING ((tenant_id = '2065'::text));


--
-- TOC entry 6451 (class 3256 OID 78083038)
-- Name: guest_types waper$2068$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2068$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2068$stay_prod" USING ((tenant_id = '2068'::text));


--
-- TOC entry 6450 (class 3256 OID 78083037)
-- Name: guest_types waper$2069$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2069$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2069$stay_prod" USING ((tenant_id = '2069'::text));


--
-- TOC entry 6465 (class 3256 OID 125070549)
-- Name: guest_types waper$2078$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2078$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2078$stay_prod" USING ((tenant_id = '2078'::text));


--
-- TOC entry 6455 (class 3256 OID 85489642)
-- Name: guest_types waper$2090$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2090$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2090$stay_prod" USING ((tenant_id = '2090'::text));


--
-- TOC entry 6454 (class 3256 OID 85489641)
-- Name: guest_types waper$2091$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2091$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2091$stay_prod" USING ((tenant_id = '2091'::text));


--
-- TOC entry 6460 (class 3256 OID 92728892)
-- Name: guest_types waper$2093$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2093$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2093$stay_prod" USING ((tenant_id = '2093'::text));


--
-- TOC entry 6459 (class 3256 OID 91133773)
-- Name: guest_types waper$2094$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2094$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2094$stay_prod" USING ((tenant_id = '2094'::text));


--
-- TOC entry 6462 (class 3256 OID 94763235)
-- Name: guest_types waper$2117$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2117$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2117$stay_prod" USING ((tenant_id = '2117'::text));


--
-- TOC entry 6466 (class 3256 OID 125070550)
-- Name: guest_types waper$2145$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2145$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2145$stay_prod" USING ((tenant_id = '2145'::text));


--
-- TOC entry 6468 (class 3256 OID 151311582)
-- Name: guest_types waper$2190$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$2190$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$2190$stay_prod" USING ((tenant_id = '2190'::text));


--
-- TOC entry 6264 (class 3256 OID 239715)
-- Name: guest_types waper$227$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$227$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$227$stay_prod" USING ((tenant_id = '227'::text));


--
-- TOC entry 6288 (class 3256 OID 239883)
-- Name: guest_types waper$253$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$253$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$253$stay_prod" USING ((tenant_id = '253'::text));


--
-- TOC entry 6247 (class 3256 OID 239596)
-- Name: guest_types waper$299$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$299$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$299$stay_prod" USING ((tenant_id = '299'::text));


--
-- TOC entry 6277 (class 3256 OID 239806)
-- Name: guest_types waper$410$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$410$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$410$stay_prod" USING ((tenant_id = '410'::text));


--
-- TOC entry 6404 (class 3256 OID 54184276)
-- Name: guest_types waper$458$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$458$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$458$stay_prod" USING ((tenant_id = '458'::text));


--
-- TOC entry 6304 (class 3256 OID 239995)
-- Name: guest_types waper$460$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$460$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$460$stay_prod" USING ((tenant_id = '460'::text));


--
-- TOC entry 6416 (class 3256 OID 61743070)
-- Name: guest_types waper$478$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$478$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$478$stay_prod" USING ((tenant_id = '478'::text));


--
-- TOC entry 6256 (class 3256 OID 239659)
-- Name: guest_types waper$481$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$481$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$481$stay_prod" USING ((tenant_id = '481'::text));


--
-- TOC entry 6426 (class 3256 OID 68920331)
-- Name: guest_types waper$490$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$490$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$490$stay_prod" USING ((tenant_id = '490'::text));


--
-- TOC entry 6302 (class 3256 OID 239981)
-- Name: guest_types waper$494$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$494$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$494$stay_prod" USING ((tenant_id = '494'::text));


--
-- TOC entry 6281 (class 3256 OID 239834)
-- Name: guest_types waper$518$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$518$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$518$stay_prod" USING ((tenant_id = '518'::text));


--
-- TOC entry 6315 (class 3256 OID 355312)
-- Name: guest_types waper$529$287$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$287$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$529$287$stay_prod" USING (((tenant_id = '529'::text) AND (property_id = '287'::text)));


--
-- TOC entry 6248 (class 3256 OID 239603)
-- Name: guest_types waper$529$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$529$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$529$stay_prod" USING ((tenant_id = '529'::text));


--
-- TOC entry 6367 (class 3256 OID 14545927)
-- Name: guest_types waper$537$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$537$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$537$stay_prod" USING ((tenant_id = '537'::text));


--
-- TOC entry 6258 (class 3256 OID 239673)
-- Name: guest_types waper$554$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$554$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$554$stay_prod" USING ((tenant_id = '554'::text));


--
-- TOC entry 6471 (class 3256 OID 151311585)
-- Name: guest_types waper$588$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$588$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$588$stay_prod" USING ((tenant_id = '588'::text));


--
-- TOC entry 6280 (class 3256 OID 239827)
-- Name: guest_types waper$590$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$590$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$590$stay_prod" USING ((tenant_id = '590'::text));


--
-- TOC entry 6305 (class 3256 OID 240002)
-- Name: guest_types waper$592$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$592$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$592$stay_prod" USING ((tenant_id = '592'::text));


--
-- TOC entry 6427 (class 3256 OID 68920332)
-- Name: guest_types waper$616$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$616$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$616$stay_prod" USING ((tenant_id = '616'::text));


--
-- TOC entry 6474 (class 3256 OID 172314392)
-- Name: guest_types waper$648$643$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$643$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$648$643$stay_prod" USING (((tenant_id = '648'::text) AND (property_id = '643'::text)));


--
-- TOC entry 6413 (class 3256 OID 59504521)
-- Name: guest_types waper$648$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$648$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$648$stay_prod" USING ((tenant_id = '648'::text));


--
-- TOC entry 6333 (class 3256 OID 18313134)
-- Name: guest_types waper$657$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$657$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$657$stay_prod" USING ((tenant_id = '657'::text));


--
-- TOC entry 6393 (class 3256 OID 55372876)
-- Name: guest_types waper$663$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$663$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$663$stay_prod" USING ((tenant_id = '663'::text));


--
-- TOC entry 6368 (class 3256 OID 64532335)
-- Name: guest_types waper$686$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$686$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$686$stay_prod" USING ((tenant_id = '686'::text));


--
-- TOC entry 6399 (class 3256 OID 50617882)
-- Name: guest_types waper$688$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$688$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$688$stay_prod" USING ((tenant_id = '688'::text));


--
-- TOC entry 6245 (class 3256 OID 239582)
-- Name: guest_types waper$690$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$690$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$690$stay_prod" USING ((tenant_id = '690'::text));


--
-- TOC entry 6387 (class 3256 OID 37885626)
-- Name: guest_types waper$710$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$710$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$710$stay_prod" USING ((tenant_id = '710'::text));


--
-- TOC entry 6448 (class 3256 OID 76021268)
-- Name: guest_types waper$734$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$734$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$734$stay_prod" USING ((tenant_id = '734'::text));


--
-- TOC entry 6417 (class 3256 OID 61743071)
-- Name: guest_types waper$761$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$761$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$761$stay_prod" USING ((tenant_id = '761'::text));


--
-- TOC entry 6296 (class 3256 OID 239939)
-- Name: guest_types waper$764$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$764$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$764$stay_prod" USING ((tenant_id = '764'::text));


--
-- TOC entry 6276 (class 3256 OID 239799)
-- Name: guest_types waper$766$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$766$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$766$stay_prod" USING ((tenant_id = '766'::text));


--
-- TOC entry 6376 (class 3256 OID 28319269)
-- Name: guest_types waper$818$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$818$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$818$stay_prod" USING ((tenant_id = '818'::text));


--
-- TOC entry 6300 (class 3256 OID 239967)
-- Name: guest_types waper$871$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$871$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$871$stay_prod" USING ((tenant_id = '871'::text));


--
-- TOC entry 6271 (class 3256 OID 239764)
-- Name: guest_types waper$872$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$872$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$872$stay_prod" USING ((tenant_id = '872'::text));


--
-- TOC entry 6285 (class 3256 OID 239862)
-- Name: guest_types waper$874$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$874$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$874$stay_prod" USING ((tenant_id = '874'::text));


--
-- TOC entry 6268 (class 3256 OID 239743)
-- Name: guest_types waper$883$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$883$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$883$stay_prod" USING ((tenant_id = '883'::text));


--
-- TOC entry 6267 (class 3256 OID 239736)
-- Name: guest_types waper$884$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$884$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$884$stay_prod" USING ((tenant_id = '884'::text));


--
-- TOC entry 6266 (class 3256 OID 239729)
-- Name: guest_types waper$885$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$885$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$885$stay_prod" USING ((tenant_id = '885'::text));


--
-- TOC entry 6272 (class 3256 OID 239771)
-- Name: guest_types waper$901$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$901$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$901$stay_prod" USING ((tenant_id = '901'::text));


--
-- TOC entry 6461 (class 3256 OID 94763234)
-- Name: guest_types waper$908$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$908$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$908$stay_prod" USING ((tenant_id = '908'::text));


--
-- TOC entry 6363 (class 3256 OID 4638250)
-- Name: guest_types waper$923$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$923$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$923$stay_prod" USING ((tenant_id = '923'::text));


--
-- TOC entry 6295 (class 3256 OID 239932)
-- Name: guest_types waper$924$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$924$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$924$stay_prod" USING ((tenant_id = '924'::text));


--
-- TOC entry 6292 (class 3256 OID 239911)
-- Name: guest_types waper$930$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$930$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$930$stay_prod" USING ((tenant_id = '930'::text));


--
-- TOC entry 6289 (class 3256 OID 239890)
-- Name: guest_types waper$932$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$932$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$932$stay_prod" USING ((tenant_id = '932'::text));


--
-- TOC entry 6255 (class 3256 OID 239652)
-- Name: guest_types waper$933$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$933$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$933$stay_prod" USING ((tenant_id = '933'::text));


--
-- TOC entry 6261 (class 3256 OID 239694)
-- Name: guest_types waper$934$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$934$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$934$stay_prod" USING ((tenant_id = '934'::text));


--
-- TOC entry 6290 (class 3256 OID 239897)
-- Name: guest_types waper$936$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$936$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$936$stay_prod" USING ((tenant_id = '936'::text));


--
-- TOC entry 6301 (class 3256 OID 239974)
-- Name: guest_types waper$937$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$937$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$937$stay_prod" USING ((tenant_id = '937'::text));


--
-- TOC entry 6250 (class 3256 OID 239617)
-- Name: guest_types waper$939$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$939$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$939$stay_prod" USING ((tenant_id = '939'::text));


--
-- TOC entry 6293 (class 3256 OID 239918)
-- Name: guest_types waper$940$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$940$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$940$stay_prod" USING ((tenant_id = '940'::text));


--
-- TOC entry 6377 (class 3256 OID 29003966)
-- Name: guest_types waper$950$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$950$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$950$stay_prod" USING ((tenant_id = '950'::text));


--
-- TOC entry 6430 (class 3256 OID 71865528)
-- Name: guest_types waper$974$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$974$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$974$stay_prod" USING ((tenant_id = '974'::text));


--
-- TOC entry 6467 (class 3256 OID 134516127)
-- Name: guest_types waper$999$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$999$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$999$stay_prod" USING ((tenant_id = '999'::text));


--
-- TOC entry 6273 (class 3256 OID 239778)
-- Name: guest_types waper$victors$stay_prod$guest_types; Type: POLICY; Schema: public; Owner: agilysys
--

CREATE POLICY "waper$victors$stay_prod$guest_types" ON public.guest_types FOR SELECT TO "waper$Victors$stay_prod" USING ((tenant_id = 'Victors'::text));


--
-- TOC entry 6480 (class 0 OID 0)
-- Dependencies: 1442
-- Name: FUNCTION pg_buffercache_pages(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_buffercache_pages() TO PUBLIC;


--
-- TOC entry 6481 (class 0 OID 0)
-- Dependencies: 1440
-- Name: FUNCTION pg_stat_statements_reset(); Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT ALL ON FUNCTION public.pg_stat_statements_reset() TO PUBLIC;


--
-- TOC entry 6482 (class 0 OID 0)
-- Dependencies: 1274
-- Name: TABLE guest_types; Type: ACL; Schema: public; Owner: agilysys
--

GRANT SELECT ON TABLE public.guest_types TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.guest_types TO agilysys_rillingp;
GRANT SELECT ON TABLE public.guest_types TO stayrouser;
GRANT SELECT ON TABLE public.guest_types TO stayreprouser;
GRANT SELECT ON TABLE public.guest_types TO stayreaderuser;


--
-- TOC entry 6483 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TABLE pg_buffercache; Type: ACL; Schema: public; Owner: azure_superuser
--

GRANT SELECT ON TABLE public.pg_buffercache TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_buffercache TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_buffercache TO stayrouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreprouser;
GRANT SELECT ON TABLE public.pg_buffercache TO stayreaderuser;


--
-- TOC entry 6484 (class 0 OID 0)
-- Dependencies: 1242
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: public; Owner: azure_superuser
--

REVOKE SELECT ON TABLE public.pg_stat_statements FROM PUBLIC;
GRANT SELECT ON TABLE public.pg_stat_statements TO "read_only$stay_prod";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO agilysys_rillingp;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayrouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreprouser;
GRANT SELECT ON TABLE public.pg_stat_statements TO stayreaderuser;


-- Completed on 2024-04-17 14:03:13

--
-- PostgreSQL database dump complete
--

