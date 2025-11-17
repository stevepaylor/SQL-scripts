CREATE TABLE public.do_not_room_move_reasons (
    id text NOT NULL,
    tenant_id text,
    property_id text,
    code text,
    reason text,
    description text,
    active boolean,
    property_inactivation boolean,
    excluded_properties text[],
    deleted boolean
);


ALTER TABLE public.do_not_room_move_reasons OWNER TO agilysys;

--
-- TOC entry 6080 (class 2606 OID 70467588)
-- Name: do_not_room_move_reasons do_not_room_move_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.do_not_room_move_reasons
    ADD CONSTRAINT do_not_room_move_reasons_pkey PRIMARY KEY (id);


--
-- TOC entry 6081 (class 1259 OID 70467589)
-- Name: idx_do_not_room_move_reasons_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_do_not_room_move_reasons_tid_pid_id ON public.do_not_room_move_reasons USING btree (tenant_id, property_id, id);
