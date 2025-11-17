CREATE TABLE public.reservation_custom_fields (
    id uuid NOT NULL,
    tenant_id text,
    property_id text,
    reservation_id text,
    code text,
    "values" text[]
);


ALTER TABLE public.reservation_custom_fields OWNER TO agilysys;

--
-- Name: reservation_custom_fields reservation_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.reservation_custom_fields
    ADD CONSTRAINT reservation_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: idx_reservation_custom_fields_tid_pid_resid_idx; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_reservation_custom_fields_tid_pid_resid_idx ON public.reservation_custom_fields USING btree (tenant_id, property_id, reservation_id);
