LOAD CSV WITH HEADERS
FROM 'https://docs.google.com/spreadsheets/d/1V8S-hrHrxr0cy8HDlapc7qP51V4DtUxxUtIwBZ54MB8/export?format=csv' AS row

// -------------------- USER --------------------
MERGE (u:User {user_id: row.user_id})
SET u.location = row.location,
    u.language = row.language


// -------------------- POST --------------------
MERGE (p:Post {post_id: row.post_id})
SET p.timestamp        = row.timestamp,
    p.day_of_week      = row.day_of_week,
    p.topic_category   = row.topic_category,
    p.sentiment_score  = toFloat(row.sentiment_score),
    p.sentiment_label  = row.sentiment_label,
    p.emotion_type     = row.emotion_type,
    p.toxicity_score   = toFloat(row.toxicity_score)


// -------------------- ENGAGEMENT --------------------
MERGE (u)-[e:ENGAGED_WITH]->(p)
SET e.likes_count      = toInteger(row.likes_count),
    e.shares_count    = toInteger(row.shares_count),
    e.comments_count  = toInteger(row.comments_count),
    e.impressions     = toInteger(row.impressions),
    e.engagement_rate = toFloat(row.engagement_rate)


// -------------------- PLATFORM --------------------
MERGE (pl:Platform {name: row.platform})
MERGE (p)-[:PUBLISHED_ON]->(pl)


// -------------------- HASHTAGS --------------------
WITH row, p
UNWIND split(coalesce(row.hashtags, ""), ",") AS hashtag
WITH p, trim(hashtag) AS tag
WHERE tag <> ""
MERGE (h:Hashtag {name: tag})
MERGE (p)-[:HAS_HASHTAG]->(h);