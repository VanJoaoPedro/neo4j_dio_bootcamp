// ================================
// CONSTRAINTS – SOCIAL MEDIA GRAPH
// ================================

// ---------- USER ----------
CREATE CONSTRAINT user_id_unique
IF NOT EXISTS
FOR (u:User)
REQUIRE u.user_id IS UNIQUE;

CREATE CONSTRAINT user_id_not_null
IF NOT EXISTS
FOR (u:User)
REQUIRE u.user_id IS NOT NULL;


// ---------- POST ----------
CREATE CONSTRAINT post_id_unique
IF NOT EXISTS
FOR (p:Post)
REQUIRE p.post_id IS UNIQUE;

CREATE CONSTRAINT post_id_not_null
IF NOT EXISTS
FOR (p:Post)
REQUIRE p.post_id IS NOT NULL;


// ---------- PLATFORM ----------
CREATE CONSTRAINT platform_name_unique
IF NOT EXISTS
FOR (pl:Platform)
REQUIRE pl.name IS UNIQUE;

CREATE CONSTRAINT platform_name_not_null
IF NOT EXISTS
FOR (pl:Platform)
REQUIRE pl.name IS NOT NULL;


// ---------- HASHTAG ----------
CREATE CONSTRAINT hashtag_name_unique
IF NOT EXISTS
FOR (h:Hashtag)
REQUIRE h.name IS UNIQUE;

CREATE CONSTRAINT hashtag_name_not_null
IF NOT EXISTS
FOR (h:Hashtag)
REQUIRE h.name IS NOT NULL;
