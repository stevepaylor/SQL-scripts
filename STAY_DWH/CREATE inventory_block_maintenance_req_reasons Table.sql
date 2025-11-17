CREATE TABLE public.inventory_block_maintenance_req_reasons (
    id text NOT NULL,
    tenant_id text,
    property_id text,
    code text,
    reason text,
    description text,
    active boolean,
    property_inactivation boolean,
    deleted boolean,
    excluded_properties text[],
    maintenance_services text[],
    out_of_order boolean,
    of_the_market boolean,
    on_hold boolean
);


ALTER TABLE public.inventory_block_maintenance_req_reasons OWNER TO agilysys;

--
-- TOC entry 6081 (class 2606 OID 76091202)
-- Name: inventory_block_maintenance_req_reasons inventory_block_maintenance_req_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.inventory_block_maintenance_req_reasons
    ADD CONSTRAINT inventory_block_maintenance_req_reasons_pkey PRIMARY KEY (id);


--
-- TOC entry 6079 (class 1259 OID 76091203)
-- Name: idx_inventory_block_maintenance_req_reasons_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_inventory_block_maintenance_req_reasons_tid_pid_id ON public.inventory_block_maintenance_req_reasons USING btree (tenant_id, property_id, id);
