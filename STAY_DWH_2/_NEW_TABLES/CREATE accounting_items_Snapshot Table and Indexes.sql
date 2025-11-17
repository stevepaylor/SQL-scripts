CREATE TABLE public.account_balance_aggregate (
    date date,
    tenant_id text,
    property_id text,
    account_id text,
    sub_total numeric,
    tax numeric,
    paid numeric,
    total numeric,
    last_updated_at timestamp with time zone,
    historic boolean,
    ledger_name text,
    recurring_charge boolean,
    rr_charges numeric,
    rr_transfers numeric,
    nrr_charges numeric,
    nrr_transfers numeric,
    rr_charges_tax numeric,
    rr_transfers_tax numeric,
    nrr_charges_tax numeric,
    nrr_transfers_tax numeric,
    rr_routing_charges numeric,
    nrr_routing_charges numeric,
    rr_routing_charges_tax numeric,
    nrr_routing_charges_tax numeric
);

CREATE INDEX idx_account_balance_aggregate_aid_pid_date_idx ON public.account_balance_aggregate USING btree (account_id, property_id, date);

CREATE INDEX idx_account_balance_aggregate_tid_pid_aid ON public.account_balance_aggregate USING btree (tenant_id, property_id, account_id);

CREATE INDEX idx_accountbalancesaggregate_tid_pid_date ON public.account_balance_aggregate USING btree (tenant_id, property_id, date);
