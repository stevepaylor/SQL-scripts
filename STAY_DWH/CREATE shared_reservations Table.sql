CREATE TABLE public.shared_reservations (
    id text NOT NULL,
    tenant_id text,
    property_id text,
    room_type_id text,
    room_id text,
    earliest_arrival date,
    latest_departure date,
    reservation_ids text[]
);

ALTER TABLE ONLY public.shared_reservations
    ADD CONSTRAINT shared_reservations_pkey PRIMARY KEY (id);


--
-- Name: idx_shared_reservations_tid_pid_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_shared_reservations_tid_pid_id ON public.shared_reservations USING btree (tenant_id, property_id, id);


