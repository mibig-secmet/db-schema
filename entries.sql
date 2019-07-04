-- A simple table with only a JSONB field and an ID

CREATE TABLE mibig.entries (
    entry_id int4 NOT NULL,
    acc varchar(10),
    tax_id int4,
    data jsonb,
    CONSTRAINT mibig_bgc_types_pkey PRIMARY KEY (entry_id),
    CONSTRAINT mibig_bgc_types_acc_unique UNIQUE (acc),
    CONSTRAINT mibig_bgc_types_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES mibig.taxa (tax_id)
);
