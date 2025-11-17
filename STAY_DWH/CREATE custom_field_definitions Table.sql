CREATE TABLE public.custom_field_definitions (
    id text NOT NULL,
    tenant_id text,
    property_id text,
    code text,
    system_generated text,
    field_name text,
    applicable_objects text[],
    type text
);


ALTER TABLE public.custom_field_definitions OWNER TO agilysys;

--
-- TOC entry 6080 (class 2606 OID 43784623)
-- Name: custom_field_definitions custom_field_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.custom_field_definitions
    ADD CONSTRAINT custom_field_definitions_pkey PRIMARY KEY (id);


--
-- TOC entry 6081 (class 1259 OID 43784624)
-- Name: idx_custom_field_definitions_tid_pid_code_idx; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_custom_field_definitions_tid_pid_code_idx ON public.custom_field_definitions USING btree (tenant_id, property_id, code);
