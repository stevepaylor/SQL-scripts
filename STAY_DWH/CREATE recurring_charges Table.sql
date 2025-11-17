CREATE TABLE public.recurring_charges (
    id text NOT NULL,
    account_id text,
    original_amount numeric(19,2),
    auto_recurring_item_id text,
    end_date date,
    folio_id text,
    invalid boolean,
    item_id text,
    property_id text,
    original_quantity integer,
    room_charge boolean,
    source_id text,
    start_date date,
    tenant_id text,
    arrival_date date,
    departure_date date,
    estimated_subtotal numeric(19,2),
    estimated_tax numeric(19,2),
    pet_reference_id text,
    nights integer,
    frequency_type text,
    occurrence_days integer[],
    auto_recurring_item_status text,
    reference_id text,
    charge_type text,
    transport_charge_reference_id text
);


ALTER TABLE public.recurring_charges OWNER TO agilysys;

--
-- Name: recurring_charges recurring_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: agilysys
--

ALTER TABLE ONLY public.recurring_charges
    ADD CONSTRAINT recurring_charges_pkey PRIMARY KEY (id);


--
-- Name: idx_recurring_charges_tenant_id_property_id_account_id; Type: INDEX; Schema: public; Owner: agilysys
--

CREATE INDEX idx_recurring_charges_tenant_id_property_id_account_id ON public.recurring_charges USING btree (tenant_id, property_id, account_id);
