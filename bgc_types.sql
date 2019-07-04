CREATE TABLE mibig.bgc_types (
    bgc_type_id	serial NOT NULL,
    term	text,
    name	text,
    description	text,
    parent_id	int4,
    safe_class	text,
    CONSTRAINT bgc_types_pkey PRIMARY KEY (bgc_type_id),
    CONSTRAINT bgc_types_term_unique UNIQUE (term),
    CONSTRAINT bgc_types_name_unique UNIQUE (name),
    CONSTRAINT bgc_types_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES mibig.bgc_types (bgc_type_id)
);

COMMENT ON TABLE mibig.bgc_types IS
  'Biosynthetic gene cluster types.';

--- basic MIBiG types
INSERT INTO mibig.bgc_types (term, name, description, parent_id, safe_class)
SELECT val.term, val.name, val.description, val.parent_id::int4, val.safe_class
FROM (
    VALUES
        ('pks', 'Polyketide', 'Polyketide', NULL, 'pks'),
        ('nrps', 'NRP', 'Nonribosomal peptide', NULL, 'nrps'),
        ('ripp', 'RiPP', 'Ribosomally synthesized and post-translationally modified peptide', NULL, 'ripp'),
        ('terpene', 'Terpene', 'Terpene', NULL, 'terpene'),
        ('saccharide', 'Saccharide', 'Saccharide', NULL, 'saccharide'),
        ('alkaloid', 'Alkaloid', 'Alkaloid', NULL, 'alkaloid'),
        ('other', 'Other', 'Other', NULL, 'other')
    ) val ( term, name, description, parent_id, safe_class );


--- Using the more detailed subtypes
INSERT INTO mibig.bgc_types (term, name, description, parent_id, safe_class)
SELECT val.term, val.name, val.description, f.bgc_type_id, val.safe_class
FROM (
   VALUES
        ('mt1pks', 'Modular type I polyketide', 'Modular type I polyketide', 'pks', 'pks'),
        ('it1pks', 'Iterative type I polyketide', 'Iterative type I polyketide', 'pks', 'pks'),
        ('transatpks', 'Trans-AT type I polyketide', 'Trans-AT type I polyketide', 'pks', 'pks'),
        ('t2pks', 'Type II polyketide', 'Type II polyketide', 'pks', 'pks'),
        ('glycopeptide', 'Glycopeptide', 'Glycopeptide', 'nrps', 'nrps'),
        ('lipopeptide', 'Lipopeptide', 'Lipopeptide', 'nrps', 'nrps'),
        ('nrp_siderophore', 'NRP siderophore', 'NRP siderophore', 'nrps', 'nrps'),
        ('cyc_depsipeptide', 'Cyclic depsipeptide', 'Cyclic depsipeptide', 'nrps', 'nrps'),
        ('bottromycin', 'Bottromycin', 'Bottromycin' ,'ripp', 'ripp'),
        ('Cyanobactin', 'Cyanobactin',	'Cyanobactin', 'ripp', 'ripp'),
        ('head_tail', 'Head-to-tail cyclized peptide', 'Head-to-tail cyclized peptide', 'ripp', 'ripp'),
        ('lanthipeptide', 'Lanthipeptide', 'Lanthipeptide', 'ripp', 'ripp'),
        ('lassopeptide', 'Lassopeptide', 'Lassopeptide', 'ripp', 'ripp'),
        ('linaridin', 'Linaridin', 'Linaridin', 'ripp', 'ripp'),
        ('microcin', 'Microcin', 'Microcin', 'ripp', 'ripp'),
        ('microviridin', 'Microviridin', 'Microviridin', 'ripp', 'ripp'),
        ('sactipeptide', 'Sactipeptide', 'Sactipeptide', 'ripp', 'ripp'),
        ('thiopeptide', 'Thiopeptide', 'Thiopeptide', 'ripp', 'ripp'),
        ('betalactam', 'Non-NRP beta-lactam', 'Non-NRP beta-lactam', 'other', 'other'),
        ('nucleoside', 'Nucleoside', 'Nucleoside', 'other', 'other'),
        ('aminocoumarin', 'Aminocoumarin', 'Aminocoumarin', 'other', 'other'),
        ('phenazine', 'Phenazine', 'Phenazine', 'other', 'other'),
        ('nrp_betalactam', 'Beta-lactam', 'Beta-lactam', 'nrps', 'nrps'),
        ('pufa', 'PUFA synthase or related polyketide', 'PUFA synthase or related polyketide', 'pks', 'pks'),
        ('fatty_acid', 'Fatty acid', 'Fatty acid', 'other', 'other'),
        ('lap', 'LAP', 'Linear azol(ine)-containing peptide', 'ripp', 'ripp'),
        ('aminoglycoside', 'Aminoglycoside', 'Aminoglycoside', 'saccharide', 'saccharide'),
        ('tailoring_saccharide', 'Hybrid/tailoring saccharide', 'Saccharide used in a tailoring step with another natural product', 'saccharide', 'saccharide'),
        ('oligosaccharide', 'Oligosaccharide', 'Oligosaccharide', 'saccharide', 'saccharide'),
        ('et1pks', 'Enediyne type I polyketide', 'Enediyne type I polyketide', 'pks', 'pks'),
        ('t3pks', 'Type III polyketide', 'Type III polyketide', 'pks', 'pks'),
        ('cyclitol', 'Cyclitol', 'Cyclitol', 'other', 'other'),
        ('other_pks', 'Other polyketide', 'Other polyketide', 'pks', 'pks'),
        ('pyrrolobenzodiazepine', 'Pyrrolobenzodiazepine', 'Pyrrolobenzodiazepine', 'nrps', 'nrps'),
        ('proteusin', 'Proteusin', 'Proteusin', 'ripp', 'ripp'),
        ('exopolysaccharide', 'Exopolysaccharide', 'Exopolysaccharide', 'saccharide', 'saccharide'),
        ('lipopolysaccharide', 'Lipopolysaccharide', 'Lipopolysaccharide', 'saccharide', 'saccharide'),
        ('butyrolactone', 'Butyrolactone', 'Butyrolactone', 'other', 'other'),
        ('shikimate_derived', 'Shikimate-derived', 'Shikimate-derived', 'other', 'other'),
        ('siderophore', 'Non-NRP siderophore', 'Non-NRP siderophore', 'other', 'other'),
        ('uridylpeptide', 'Uridylpeptide', 'Uridylpeptide', 'nrps', 'nrps'),
        ('trna_derived', 'tRNA-derived', 'tRNA-derived', 'other', 'other')
    ) val ( term, name, description, parent_term, safe_class )
LEFT JOIN mibig.bgc_types f ON val.parent_term = f.term;

-- And subtypes of the detailed subtypes
INSERT INTO mibig.bgc_types (term, name, description, parent_id, safe_class)
SELECT val.term, val.name, val.description, f.bgc_type_id, val.safe_class
FROM (
    VALUES
        ('ca_dependent_lipopeptide', 'Ca+-dependent lipopeptide', 'Ca+-dependent lipopeptide', 'lipopeptide', 'nrps')
    ) val ( term, name, description, parent_term, safe_class )
LEFT JOIN mibig.bgc_types f ON val.parent_term = f.term;

