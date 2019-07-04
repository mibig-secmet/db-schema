--- Many to many relation for entries and bgc_types
CREATE TABLE mibig.rel_entries_types (
    entry_id	int4,
    bgc_type_id	int4,
    CONSTRAINT mibig_rel_entries_types_pkey PRIMARY KEY (entry_id, bgc_type_id),
    CONSTRAINT mibig_rel_entries_types_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES mibig.entries (entry_id) ON DELETE CASCADE,
    CONSTRAINT mibig_rel_entries_types_bgc_type_id_fkey FOREIGN KEY (bgc_type_id) REFERENCES mibig.bgc_types (bgc_type_id)
);

