CREATE TABLE mibig_submitters.submitters (
    user_id text NOT NULL,
    email text NOT NULL,
    name text,
    call_name text,
    institution text,
    password_hash text,
    is_public boolean,
    gdpr_consent boolean,
    active boolean,
    CONSTRAINT mibig_submitters_submitters_pkey PRIMARY KEY (user_id),
    CONSTRAINT mibig_submitters_submitters_email_unique UNIQUE (email)
);

INSERT INTO mibig_submitters.submitters (
    user_id, email, name, call_name, institution, password_hash, is_public, gdpr_consent, active
) VALUES (
    'AAAAAAAAAAAAAAAAAAAAAAAA', 'mibig@secondarymetabolites.org', 'MIBiG Submitters', 'MIBiG', 'MIBiG', 'unused', TRUE, TRUE, FALSE
);
