CREATE TABLE mibig.compounds (
    name	text,
    entry_id	int4,
    CONSTRAINT mibig_compounds_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES mibig.entries (entry_id)
)
