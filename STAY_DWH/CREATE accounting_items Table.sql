CREATE TABLE public.accounting_items (
    tenant_id text NOT NULL,
    property_id text NOT NULL,
    id text NOT NULL,
    type text,
    alt_system_id text,
    default_price numeric(19,2),
    general_ledger_code text,
    allow_comp boolean,
    price_look_up_code text,
    status text,
    category_id text,
    room_revenue boolean,
    subcategory_id text,
    name text,
    code text,
    internal boolean,
    available_count integer,
    max_quantity_per_reservation integer,
    restricted boolean,
    tax_rate text
);


--
-- Name: accounting_items accounting_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounting_items
    ADD CONSTRAINT accounting_item_pkey PRIMARY KEY (tenant_id, property_id, id);