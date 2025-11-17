CREATE TABLE public.room_move_reasons (
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
    category text
);


ALTER TABLE public.room_move_reasons OWNER TO agilysys;

--
-- Name: room_move_reasons room_move_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.room_move_reasons
    ADD CONSTRAINT room_move_reasons_pkey PRIMARY KEY (id);


--
-- Name: idx_room_move_reasons_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_room_move_reasons_tid_pid_id ON public.room_move_reasons USING btree (tenant_id, property_id, id);
