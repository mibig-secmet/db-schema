CREATE TABLE mibig.taxa (
    tax_id	serial NOT NULL,
    ncbi_taxid	int4,
    superkingdom	text,
    kingdom	text,
    phylum	text,
    class	text,
    taxonomic_order	text,
    family	text,
    genus	text,
    species	text,
    name	text NOT NULL,
    CONSTRAINT mibig_taxa_pkey PRIMARY KEY (tax_id),
    CONSTRAINT mibig_taxa_name_unique UNIQUE (name)
);
